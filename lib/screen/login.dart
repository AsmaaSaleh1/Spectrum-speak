import 'package:flutter/material.dart';
import 'package:spectrum_speak/const.dart';
import 'package:spectrum_speak/units/build_text_field.dart';
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
    bool isObscurePassword = true;
    return Scaffold(
      backgroundColor: kPrimary,
      body: SingleChildScrollView(
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
              child: Text(
                'Login',
                style: TextStyle(
                    color: kDarkerColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 15),
                width: 280,
                height: 50,
                child: buildTextField(Icons.mail, "Email Address",
                    "Asmaa@gmail.com", false, isObscurePassword)),
            const SizedBox(height: 10,),
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 15),
                width: 280,
                height: 50,
                child: buildTextField(Icons.lock_outline, "Password",
                    "**********", true, isObscurePassword)),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
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
                child: Text(
                  'Log in',
                  style: TextStyle(
                    color: kDarkerColor,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  margin: const EdgeInsets.only(top: 20, right: 20),
                  width: 150,
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: kYellow)),
                  ),
                  child: const Text(
                    ' ',
                    style: TextStyle(
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 33),
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
                  margin: const EdgeInsets.only(left: 20, top: 20),
                  width: 150,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: kYellow),
                    ),
                  ),
                  child: const Text(
                    ' ',
                    style: TextStyle(
                      color: Colors.deepOrange,
                    ),
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SignUp(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(kBlue),
                  fixedSize: MaterialStateProperty.all(const Size(315, 50)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ), // specify width, height
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: kDarkerColor,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
