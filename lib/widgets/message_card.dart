import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/modules/Dialogs.dart';
import 'package:spectrum_speak/modules/Message.dart';
import 'package:spectrum_speak/modules/my_date_util.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.message});
  final Message message;
  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  GlobalKey<_MessageCardState> _scaffoldKey = GlobalKey();
  final int id = AuthManager.u.UserID;
  late MediaQueryData mq;
  bool isMe() {
    if (widget.message.fromID == id) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return InkWell(
      onLongPress: () {
        _showBottomSheet();
      },
      child: isMe() ? _greenMessage() : _blueMessage(),
    );
  }

  Widget _blueMessage() {
    //update last read message
    if (widget.message.read.isEmpty) {
      Utils.updateMessgaeReadStatus(widget.message);
      print('message read updated');
    }
    return Row(
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(widget.message.type == Type.image.toString()
                ? mq.size.width * .03
                : mq.size.width * .04),
            margin: EdgeInsets.symmetric(
                horizontal: mq.size.width * .04,
                vertical: mq.size.height * .01),
            //message card decoration
            decoration: BoxDecoration(
                color: kreceiverMessage,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                border: Border.all(color: kreceiverMessageBorder)),
            //display text or  image
            child: widget.message.type == Type.text.toString()
                ? Text(widget.message.message,
                    style: TextStyle(fontSize: 18, color: Colors.black87))
                : ClipRRect(
                    borderRadius: BorderRadius.circular(mq.size.height * .03),
                    child: CachedNetworkImage(
                      imageUrl: widget.message.message,
                      errorWidget: (context, url, error) => const CircleAvatar(
                          child: Icon(Icons.image, size: 70)),
                      placeholder: (context, url) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: mq.size.width * .04),
          child: Text(
            MyDateUtil.getFormattedTime(
                context: context, time: widget.message.sent),
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          SizedBox(width: mq.size.width * .04),
          if (widget.message.read.isNotEmpty)
            Icon(Icons.done_all_rounded, color: kBlue, size: 20),
          const SizedBox(width: 2),
          Text(
            MyDateUtil.getFormattedTime(
                context: context, time: widget.message.sent),
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ]),
        Flexible(
            child: Container(
          padding: EdgeInsets.all(widget.message.type == Type.image
              ? mq.size.width * .03
              : mq.size.width * .04),
          margin: EdgeInsets.symmetric(
              horizontal: mq.size.width * .04, vertical: mq.size.height * .01),
          decoration: BoxDecoration(
              color: ksenderMessage,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
              border: Border.all(color: ksenderMessageBorder)),
          child: widget.message.type == Type.text.toString()
              ? Text(widget.message.message,
                  style: TextStyle(fontSize: 18, color: Colors.black87))
              : ClipRRect(
                  borderRadius: BorderRadius.circular(mq.size.height * .03),
                  child: CachedNetworkImage(
                      imageUrl: widget.message.message,
                      errorWidget: (context, url, error) => const CircleAvatar(
                          child: Icon(Icons.image, size: 70)),
                      placeholder: (context, url) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )),
                ),
        ))
      ],
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            children: [
              Container(
                height: 4,
                margin: EdgeInsets.symmetric(
                    vertical: mq.size.width * .015,
                    horizontal: mq.size.height * .4),
                decoration: BoxDecoration(
                    color: kDarkBlue, borderRadius: BorderRadius.circular(8)),
              ),
              if (widget.message.type == Type.text.toString())
                _OptionItem(
                  icon: const Icon(Icons.copy_all_rounded,
                      color: Colors.blue, size: 26),
                  name: 'Copy Text',
                  onTap: () async {
                    await Clipboard.setData(
                            ClipboardData(text: widget.message.message))
                        .then((value) {
                      //for hiding bottom sheet
                      Navigator.pop(context);

                      Dialogs.showSnackbar(context, 'Text Copied!');
                    });
                  },
                  mq: mq,
                ),
              if (widget.message.type == Type.text.toString() && isMe())
                _OptionItem(
                    icon: const Icon(Icons.edit, color: Colors.blue, size: 26),
                    name: 'Edit Message',
                    onTap: () {
                      //for hiding bottom sheet
                      Navigator.pop(context);

                      _showMessageUpdateDialog();
                    },
                    mq: mq),
              if (isMe())
                _OptionItem(
                    icon: const Icon(Icons.delete_forever,
                        color: Colors.red, size: 26),
                    name: 'Delete Message',
                    onTap: () async {
                      await Utils.deleteMessage(widget.message).then((value) {
                        //for hiding bottom sheet
                        Navigator.pop(context);
                      });
                    },
                    mq: mq),
            ],
          );
        });
  }

  void _showMessageUpdateDialog() {
    String updatedMesage = widget.message.message;
    if (!mounted) {
      return;
    }
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              backgroundColor: kDarkBlue,       
               key: _scaffoldKey,
              contentPadding: const EdgeInsets.only(
                  left: 24, right: 24, top: 20, bottom: 10),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.black)),

              //title
              title: Row(
                children: const [
                  Icon(
                    Icons.message,
                    color: kPrimary,
                    size: 28,
                  ),
                  Text(' Edit Message', style: TextStyle(color: kPrimary))
                ],
              ),

              //content
              content: TextFormField(
                initialValue: updatedMesage,
                maxLines: null,
                onChanged: (value) => updatedMesage = value,
                style: TextStyle(color: kDarkerBlue),
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
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: kPrimary, fontSize: 16),
                    )),

                //update button
                MaterialButton(
                    onPressed: () {
                      //hide alert dialog
                      Utils.updateMessage(widget.message, updatedMesage).then((value){
                      Navigator.of(_scaffoldKey.currentContext!).pop();
                      });
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(color: kPrimary, fontSize: 16),
                    ))
              ],
            ));
  }
}

class _OptionItem extends StatelessWidget {
  final Icon icon;
  final String name;
  final VoidCallback onTap;
  final MediaQueryData mq; // Include MediaQueryData as a parameter

  const _OptionItem({
    required this.icon,
    required this.name,
    required this.onTap,
    required this.mq, // Add MediaQueryData as a parameter
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: EdgeInsets.only(
              left: mq.size.width * .05,
              top: mq.size.height * .015,
              bottom: mq.size.height * .015),
          child: Row(children: [
            icon,
            Flexible(
                child: Text('    $name',
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        letterSpacing: 0.5)))
          ]),
        ));
  }
}
