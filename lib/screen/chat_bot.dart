import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constant/const_color.dart';
import '../constant/apiKey.dart';
import '../units/build_input_decorations.dart';

class ChatBot extends StatefulWidget {
  final String name;
  final String id;
  const ChatBot({super.key, required this.name, required this.id});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  TextEditingController controller = TextEditingController();
  final _openAI = OpenAI.instance.build(
      token: OPENAI_API_KEY,
      baseOption: HttpSetup(receiveTimeout: Duration(seconds: 5)),
      enableLog: true);
  late ChatUser _currentUser = ChatUser(id: '1', firstName: '');
  late ChatUser _gptChatUser = ChatUser(id: '0', firstName: 'SpectrumBot');
  List<ChatMessage> _messages = <ChatMessage>[];
  @override
  initState() {
    super.initState();
    _currentUser = new ChatUser(id: widget.id, firstName: widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimary,
        appBar: AppBar(
          backgroundColor: kDarkerBlue,
          title:
              const Text('SpectrumBot', style: TextStyle(color: Colors.white)),
        ),
        body: DashChat(
          currentUser: _currentUser,
          messageOptions: MessageOptions(
            currentUserContainerColor: ksenderMessage,
            containerColor: kreceiverMessage,
            timeFormat: DateFormat.jm(),
                userNameBuilder: (ChatUser user) {
                // Customize the author label based on the user
                if (user.id == widget.id) {
                  // Customize label for the current user
                  return Text(
                    '${widget.name}',  // You can replace 'You' with any label you want
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kDarkerBlue,
                      fontSize: 18  // Customize color if needed
                    ),
                  );
                } else {
                  // Customize label for other users
                  return Text(
                    "  SpectrumBot",  // You can customize the label based on the user's name
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kDarkerBlue,fontSize: 13  // Customize color if needed
                    ),
                  );
                }
            },
            messageTextBuilder: (ChatMessage message, ChatMessage? previousMessage, ChatMessage? nextMessage) {
              // Customize the text size based on the message sender (current user or other user)
              double fontSize = message.user.id == widget.id ? 21.0 : 19.0;
              Color color= message.user.id == widget.id ? kPrimary:Colors.black;
              return Text(
                message.text,
                style: TextStyle(
                  fontSize: fontSize,
                  color: color
                  // Add more text styling properties if needed
                ),
              );
            },
          ),
          onSend: (ChatMessage m) {
            getChatResponse(m);
          },
          messages: _messages,
          inputOptions: InputOptions(
            inputDecoration: buildInputDecoration(
                null, null, "Write Your Message Here", false, false),
            inputTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: kDarkerColor,
            ),
            sendButtonBuilder: (Function onSend) {
              return Container(
                decoration: BoxDecoration(
                  color:
                      kDarkerBlue, // Change this color to your desired color
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.send, color: kPrimary),
                  onPressed: () {
                    onSend();
                  },
                ),
              );
            },
          ),
        ));
  }

  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      _messages.insert(0, m);
    });
    List<Messages> _messagesHistory = _messages.reversed.map((m) {
      if (m.user == _currentUser) {
        return Messages(role: Role.user, content: m.text);
      } else {
        return Messages(role: Role.assistant, content: m.text);
      }
    }).toList();
    final request = ChatCompleteText(
        model: GptTurbo0301ChatModel(),
        messages: _messagesHistory,
        maxToken: 200);
    final response = await _openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      if (element.message != null) {
        setState(() {
          _messages.insert(
              0,
              ChatMessage(
                  user: _gptChatUser,
                  createdAt: DateTime.now(),
                  text: element.message!.content));
        });
      }
    }
  }
  Widget Function(Function send) defaultSendButton({
    required Color color,
    IconData icon = Icons.send,
    EdgeInsets? padding,
    bool disabled = false,
  }) =>
    (Function fct) => InkWell(
          onTap: disabled ? null : () => fct(),
          child: Padding(
            padding: padding ??
                const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Icon(
              Icons.send,
              color: color,
            ),
          ),
        );
}
