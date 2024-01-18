import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/modules/ChatUser.dart';
import 'package:spectrum_speak/modules/Dialogs.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/screen/main_page.dart';
import 'package:spectrum_speak/widgets/card_user_chat.dart';

class AllChat extends StatefulWidget {
  const AllChat({super.key});

  @override
  State<AllChat> createState() => _AllChatState();
}

class _AllChatState extends State<AllChat> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<ChatUser> list = [];
  List<ChatUser> searchList = [];
  bool _isSearching = false;
  TextEditingController _search = TextEditingController();
  String _previousText = '';
  @override
  void initState() {
    super.initState();
    // Utils.getFirebaseMessagingToken(AuthManager.u.UserID.toString());
    // Utils.updateActiveStatus(AuthManager.u.UserID.toString(), true);
    SystemChannels.lifecycle.setMessageHandler((message) {
      print('Message: $message');

      // ignore: unnecessary_null_comparison
      if (message.toString().contains('resume')) {
        Utils.updateActiveStatus(AuthManager.u.UserID.toString(), true);
      }
      if (message.toString().contains('pause')) {
        Utils.updateActiveStatus(AuthManager.u.UserID.toString(), false);
      }

      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          } else {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => MainPage())));
            return Future.value(true);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: _isSearching
                ? TextField(
                    decoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Name,Email,...',
                    ),
                    autofocus: true,
                    style: TextStyle(fontSize: 17, letterSpacing: 0.5),
                    onChanged: (val) async {
                      String currentText = val.trim();

                      if (_previousText.length > currentText.length) {
                        setState(() {
                          searchList.clear();
                        });
                        print(
                            'Deletion detected: ${_previousText.substring(currentText.length)}');
                      } else if (_previousText.length < currentText.length) {
                        setState(() {
                          searchList.clear();
                        });
                        // Addition happened
                        print(
                            'Addition detected: ${currentText.substring(_previousText.length)}');
                      }

                      _previousText = currentText;
                      setState(() {
                        searchList.clear();
                      });

                      if (val.isEmpty) {
                        return; // Don't perform search if the text is empty
                      }

                      List<ChatUser> listt = await Utils.getAllUsersSearch();
                      for (var i in listt) {
                        if ((i.Name?.toLowerCase()
                                    ?.startsWith(val.toLowerCase()) ??
                                false) ||
                            (i.Name?.split(" ")[1]
                                    ?.toLowerCase()
                                    ?.startsWith(val.toLowerCase()) ??
                                false)) {
                          print('${i.Name}\n');
                          searchList.add(i);
                        }
                      }
                      setState(() {
                        // Set the state after the entire loop has finished
                        searchList;
                      });
                    },
                    controller: _search)
                : Text(
                    "Chat",
                  ),
            leading: Container(
              child: Icon(CupertinoIcons.house),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isSearching = !_isSearching;
                      if (_search.text.isEmpty) searchList.clear();
                      _search.clear();
                    });
                  },
                  icon: Icon(_isSearching
                      ? CupertinoIcons.clear_circled_solid
                      : CupertinoIcons.search)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _addChatUserDialog();
            },
            backgroundColor: kDarkBlue,
            child: const Icon(
              Icons.add_comment_rounded,
              color: kPrimary,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            child: StreamBuilder(
                stream: Utils.getMyUsersIDs(),
                builder: (context, snapshott) {
                  switch (snapshott.connectionState) {
                    //if data is loading
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(child: CircularProgressIndicator());

                    //if some or all data is loaded then show it
                    case ConnectionState.active:
                    case ConnectionState.done:
                      return StreamBuilder(
                          stream: Utils.getAllUserss(
                              snapshott.data?.docs.map((e) => e.id).toList() ??
                                  []),
                          builder: (context, snapshot) {
                            // if (snapshot.connectionState ==
                            //     ConnectionState.waiting) {
                            //   return Center(child: CircularProgressIndicator());
                            // } else if (snapshot.hasError) {
                            //   return Center(
                            //       child: Text('Error: ${snapshot.error}'));
                            // } else if (!snapshot.hasData ||
                            //     snapshot.data!.docs.isEmpty) {
                            //   return Center(
                            //       child: Text('No messages available.'));
                            // } else {
                            final data = snapshot.data?.docs;
                            list = data
                                    ?.map((e) => ChatUser.fromJson(e.data()))
                                    .toList() ??
                                [];
                            if (list.isEmpty) {
                              print('What a waste');
                            }
                            print(searchList);
                            return ListView.builder(
                                itemCount: _isSearching
                                    ? searchList.length
                                    : list.length,
                                padding: const EdgeInsets.only(top: 8),
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return CardUserChat(
                                      user: _isSearching
                                          ? searchList[index]
                                          : list[index]);
                                });
                          }
                          // }
                          );
                  }
                }),
          ),
        ),
      ),
    );
  }

  void _addChatUserDialog() {
    String email = '';

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              key: _scaffoldKey,
              backgroundColor: kDarkBlue,
              contentPadding: const EdgeInsets.only(
                  left: 24, right: 24, top: 20, bottom: 10),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),

              //title
              title: Row(
                children: const [
                  Icon(
                    Icons.person_add,
                    color: kPrimary,
                    size: 28,
                  ),
                  Text('  Add User', style: TextStyle(color: kPrimary))
                ],
              ),

              //content
              content: TextFormField(
                maxLines: null,
                onChanged: (value) => email = value,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: kPrimary,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(15))),
              ),

              //actions
              actions: [
                //cancel button
                MaterialButton(
                    onPressed: () {
                      //hide alert dialog
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel',
                        style: TextStyle(color: kPrimary, fontSize: 16))),

                //add button
                MaterialButton(
                    onPressed: () async {
                      //hide alert dialog
                      Navigator.of(_scaffoldKey.currentContext!).pop();
                      if (email.isNotEmpty) {
                        await Utils.addChatUser(email).then((value) {
                          if (!value) {
                            Dialogs.showSnackbar(
                                context, 'User does not Exists!');
                          }
                        });
                      }
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ))
              ],
            ));
  }
}
