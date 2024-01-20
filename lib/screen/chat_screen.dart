import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/modules/ChatUser.dart';
import 'package:spectrum_speak/modules/Message.dart';
import 'package:spectrum_speak/modules/my_date_util.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/screen/call_page.dart';
import 'package:spectrum_speak/units/build_text_field.dart';
import 'package:spectrum_speak/widgets/message_card.dart';
import 'login.dart';
class ChatScreen extends StatefulWidget {
  final ChatUser user;
  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool firstMessage = false;
  late MediaQueryData mq; // Declare MediaQueryData variable
  bool _showEmoji = false;
  TextEditingController _textController = TextEditingController();
  bool _isUploading = false;
  late FocusNode _focusNode;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // TextField tapped, hide emoji picker
        setState(() {
          _showEmoji = false;
        });
      }
    });
  }

  // Method to check if the user is logged in
  Future<void> checkLoginStatus() async {
    bool isLoggedIn = await AuthManager.isUserLoggedIn();

    if (!isLoggedIn) {
      // If the user is not logged in, navigate to the login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Message> _messagesList = [];
    mq = MediaQuery.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () {
            if (_showEmoji) {
              setState(() => _showEmoji = false);
              return Future.value(false);
            } else {
              Navigator.pop(context);
              return Future.value(true);
            }
          },
          child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: _appBar(),
              ),
              backgroundColor: kPrimary,
              body: Column(
                children: [
                  Expanded(
                    child: StreamBuilder(
                        stream: Utils.getAllMessages(widget.user),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            firstMessage = true;
                            return Center(
                                child: Text('No messages available.'));
                          } else {
                            final data = snapshot.data?.docs;
                            print('Data: ${jsonEncode(data![0].data())}');
                            _messagesList = data
                                    ?.map((e) => Message.fromJson(e.data()))
                                    .toList() ??
                                [];

                            if (_messagesList.isNotEmpty) {
                              return ListView.builder(
                                  controller: _scrollController,
                                  reverse: true,
                                  itemCount: _messagesList.length,
                                  padding: const EdgeInsets.only(top: 8),
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return MessageCard(
                                        message: _messagesList[
                                            _messagesList.length - index - 1]);
                                  });
                            } else {
                              return const Center(
                                child: Text('Say Hi!👋',
                                    style: TextStyle(fontSize: 20)),
                              );
                            }
                          }
                        }),
                  ),
                  if (_isUploading)
                    const Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
                            child: CircularProgressIndicator(strokeWidth: 2))),
                  _chatInput(),
                  if (_showEmoji)
                    SizedBox(
                      height: mq.size.height * .35,
                      child: EmojiPicker(
                          textEditingController: _textController,
                          config: Config(
                            bgColor: kPrimary,
                            columns: 8,
                            initCategory: Category.SMILEYS,
                            emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                          )),
                    ),
                ],
              )),
        ),
      ),
    );
  }

  Widget _appBar() {
    return InkWell(
        onTap: () {},
        child: StreamBuilder(
            stream: Utils.getUserInfo(widget.user),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
              return Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    color: kPrimary,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(mq.size.height * .03),
                    child: CachedNetworkImage(
                      width: mq.size.height * .055,
                      height: mq.size.height * .055,
                      imageUrl:
                          list.isNotEmpty ? list[0].image : widget.user.image,
                      errorWidget: (context, url, error) => const CircleAvatar(
                          child: Icon(CupertinoIcons.person)),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        list.isNotEmpty ? list[0].Name : widget.user.Name,
                        style: TextStyle(
                          color: kPrimary.withOpacity(0.95),
                          fontWeight: FontWeight.w500,
                          fontSize: 19,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        list.isNotEmpty
                            ? list[0].isOnline
                                ? 'Online'
                                : MyDateUtil.getLastActiveTime(
                                    context: context,
                                    lastActive: list[0].lastActive)
                            : MyDateUtil.getLastActiveTime(
                                context: context,
                                lastActive: widget.user.lastActive),
                        style: TextStyle(
                          color: kPrimary.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: mq.size.width * 0.05),
                  // if (!foundation.kIsWeb)
                    IconButton(
                      onPressed: () {
                        int max = AuthManager.u.UserID > widget.user.UserID
                            ? AuthManager.u.UserID
                            : widget.user.UserID;
                        int min = AuthManager.u.UserID < widget.user.UserID
                            ? AuthManager.u.UserID
                            : widget.user.UserID;
                        String CallID = 'call_id$max\_$min';
                        print('$CallID');
                        Utils.sendPushCallNotification(widget.user);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CallPage(callId: 'call_id')));
                      },
                      icon: const Icon(
                        Icons.video_call,
                        size: 40,
                      ),
                      color: kPrimary,
                    ),
                ],
              );
            }));
  }

  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: mq.size.height * .01, horizontal: mq.size.width * .025),
      child: Container(
        color: kPrimary,
        child: Row(
          children: [
            //input field & buttons
            Expanded(
              child: Card(
                color: kPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: Colors.black, // Choose your border color
                    width: 2.0, // Set the width of the border
                  ),
                ),
                child: Row(
                  children: [
                    //emoji button
                    IconButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          setState(() => _showEmoji = !_showEmoji);
                        },
                        icon: const Icon(Icons.emoji_emotions,
                            color: kDarkBlue, size: 25)),

                    Expanded(
                        child: CustomTextField(
                      controller: _textController,
                      labelText: '',
                      focusNode: _focusNode,
                      placeholder: 'Write your message',
                      isPasswordTextField: false,
                      numOfLine: null,
                      keyboardType: TextInputType.multiline,
                      existsBorder: false,
                      onTap: () {
                        print('Emoji state: $_showEmoji');
                        if (_showEmoji) setState(() => _showEmoji = false);
                      },
                    )),

                    //pick image from gallery button
                    IconButton(
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();

                          // Picking multiple images
                          final List<XFile> images =
                              await picker.pickMultiImage();

                          // uploading & sending image one by one
                          for (var i in images) {
                            log('Image Path: ${i.path}');
                            setState(() => _isUploading = true);
                            await Utils.sendChatImage(
                                widget.user, File(i.path));
                            setState(() => _isUploading = false);
                          }
                        },
                        icon: const Icon(Icons.image,
                            color: kDarkBlue, size: 26)),

                    //take image from camera button
                    IconButton(
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();

                          // Pick an image
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.camera);
                          if (image != null) {
                            log('Image Path: ${image.path}');
                            setState(() => _isUploading = true);

                            await Utils.sendChatImage(
                                widget.user, File(image.path));
                            setState(() => _isUploading = false);
                          }
                        },
                        icon: const Icon(Icons.camera_alt_rounded,
                            color: kDarkBlue, size: 26)),

                    //adding some space
                    SizedBox(width: mq.size.width * .02),
                  ],
                ),
              ),
            ),

            //send message button
            MaterialButton(
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  Utils.sendMessage(
                      widget.user, _textController.text, Type.text);
                  if (firstMessage) {
                    print('First Message ever\n');
                    firstMessage = false;
                    Utils.addChatUser2(widget.user.UserID, AuthManager.u.Email);
                  }
                }
                _textController.text = '';
              },
              minWidth: 0,
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, right: 5, left: 10),
              shape: const CircleBorder(),
              color: kDarkerBlue,
              child: const Icon(Icons.send, color: kPrimary, size: 28),
            )
          ],
        ),
      ),
    );
  }
}
