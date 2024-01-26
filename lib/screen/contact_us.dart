import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/units/build_text_field.dart';
import 'package:spectrum_speak/units/custom_button.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopBar(
        body: ContactUsCall(),
      ),
    );
  }
}

class ContactUsCall extends StatefulWidget {
  const ContactUsCall({super.key});

  @override
  State<ContactUsCall> createState() => _ContactUsCallState();
}

class _ContactUsCallState extends State<ContactUsCall> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  int _characterCount = 0;
  int _maxCharacterCount = 300;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: 250,
                    //margin: const EdgeInsets.only(left: 8, top: 45),
                    child: Image.asset(
                      'images/send.png',
                      width: 250.0,
                      height: 250.0,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Contact Us',
                    style: TextStyle(
                      color: kDarkerColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin:
                      const EdgeInsets.only(bottom: 35, left: 20, right: 20),
                  child: Text(
                    "Your contribution makes a difference",
                    style: TextStyle(
                      color: kDarkerColor.withOpacity(0.5),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 15),
                  width: 320,
                  height: 50,
                  child: CustomTextField(
                    preIcon: Icons.person,
                    labelText: "Name",
                    placeholder: "Asmaa",
                    isPasswordTextField: false,
                    controller: _usernameController,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 320,
                  height: 260,
                  child: CustomTextField(
                    labelText: "Feedback",
                    placeholder:
                        "Hello Spectrum Speak Team!,\nI would like to send a feedback about...",
                    isPasswordTextField: false,
                    controller: _contactController,
                    numOfLine: 10,
                    onChange: (text) {
                      setState(() {
                        _characterCount = text.length;
                      });

                      if (_characterCount > _maxCharacterCount) {
                        // Truncate the text to the maximum allowed characters
                        _contactController.text = _contactController.text
                            .substring(0, _maxCharacterCount);
                        _contactController.selection =
                            TextSelection.fromPosition(
                          TextPosition(offset: _maxCharacterCount),
                        );
                      }
                    },
                    maxCharacterCount: _maxCharacterCount,
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.only(right: 5),
                  width: 320,
                  height: 18,
                  child: Text(
                    '$_characterCount/$_maxCharacterCount',
                    style: TextStyle(
                      color: _characterCount >= _maxCharacterCount
                          ? kRed
                          : kDarkerColor.withOpacity(0.8),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.only(right: 5),
                  width: 320,
                  height: 50,
                  child: CustomButton(
                    foregroundColor: kDarkerColor,
                    backgroundColor: kBlue,
                    onPressed: () {},
                    buttonText: "     Send     ",
                    icon: Icon(
                      Icons.send,
                    ),
                    iconColor: kPrimary,
                  ),
                ),
                Container(
                  width: 350,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    'Your voice matters! Use this space to share feedback, file a complaint, or inquire about anything. We\'re here to listen and assist you.',
                    style: TextStyle(
                      color: kDarkerColor.withOpacity(0.8),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(top: 5, right: 20),
                      width: 150,
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: kDarkBlue)),
                      ),
                      child: const Text(
                        ' ',
                        style: TextStyle(
                          color: kDarkBlue,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 22),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          color: kDarkerColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(left: 20, top: 5),
                      width: 150,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: kDarkBlue),
                        ),
                      ),
                      child: const Text(
                        ' ',
                        style: TextStyle(
                          color: kDarkBlue,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 350,
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(left: 5),
                  child: Text(
                    'Contact Information',
                    style: TextStyle(
                      color: kDarkerColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: 350,
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.email,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email:',
                                style: TextStyle(
                                  color: kDarkerColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'SpectrumSpeak@gmail.com',
                                style: TextStyle(
                                  color: kDarkerColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Phone:',
                                style: TextStyle(
                                  color: kDarkerColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '+(970) 592-676-710',
                                style: TextStyle(
                                  color: kDarkerColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80, // Adjust the height as needed
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    kDarkerColor.withOpacity(0.5),
                    kDarkerColor.withOpacity(0.3),
                    kDarkerColor.withOpacity(0.1),
                    kDarkerColor.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
