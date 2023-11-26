import 'package:flutter/material.dart';
import 'package:spectrum_speak/const.dart';
import 'sign_up.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool _obscureText = true;

  @override
  void initState() {
    _passwordVisible = false;
    _obscureText = true;
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _clearP() {
    setState(() {
      _passwordController.clear();
    });
  }

  void _clearE() {
    setState(() {
      _emailController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                height: 210,
                margin: const EdgeInsets.only(left: 8, top: 45),
                child: Image.asset('images/spectrumspeak.png',
                    width: 270.0, height: 270.0),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 35),
                child: const Text(
                  'Login',
                  style: TextStyle(
                      color: Color(0xff0E5F88),
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Wrap(
                  spacing: 0,
                  children: [
                    // Container(
                    //   alignment: Alignment.center,
                    Image.asset('images/emaill.png'),
                    // ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      width: 260,
                      height: 50,
                      child: TextField(
                        controller: _emailController,
                        style: const TextStyle(color: ktextfieldColor),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: kDarkerColor,
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0),
                              ),
                              borderSide: BorderSide.none,
                          ),
                          hintText: 'Email Address',
                          hintStyle: const TextStyle(
                            fontSize: 15.0,
                            color: tdPlaceHolder,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10, bottom: 35),
                child: Wrap(
                  spacing: 0,
                  children: [
                    // Container(
                    //   alignment: Alignment.center,
                    Image.asset('images/lock.png'),
                    // ),
                    Container(
                      width: 260,
                      height: 50,
                      alignment: Alignment.center,
                      child: TextField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        style: const TextStyle(color: ktextfieldColor),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: kDarkerColor,
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0),
                              ),
                              borderSide: BorderSide.none,
                          ),
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                            fontSize: 15.0,
                            color: tdPlaceHolder,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                                _toggle();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kYellow),
                  fixedSize: MaterialStateProperty.all(const Size(315, 50)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ), // specify width, height
                ),
                child: const Text(
                  'Log in',
                  style: TextStyle(
                      color: kDarkBlue,
                      fontFamily: 'Inter',
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 25),
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                      color: kDarkBlue,
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                      fontFamily: 'Poppins'),
                ),
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.only(left: 31, top: 20, right: 20),
                    width: 120,
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: kYellow)),
                    ),
                    child: const Text(
                      ' ',
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 33),
                    child: const Text(
                      'OR',
                      style: TextStyle(
                          color: kDarkBlue,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.only(left: 20, top: 20),
                    width: 120,
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: kYellow)),
                    ),
                    child: const Text(
                      ' ',
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 40,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignUp()));
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    side: MaterialStateProperty.all(
                        const BorderSide(color: kYellow, width: 1)),
                    fixedSize: MaterialStateProperty.all(const Size(315, 50)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ), // specify width, height
                  ),
                  child: const Text('Sign Up',
                      style: TextStyle(
                          color: kDarkBlue,
                          fontFamily: 'Inter',
                          fontSize: 19,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
