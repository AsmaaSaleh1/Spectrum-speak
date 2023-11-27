import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/screen/main_page.dart';
import 'package:spectrum_speak/units/build_text_field.dart';
import 'sign_up.dart';
import 'package:spectrum_speak/rest/rest_api.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late SharedPreferences _sharedPreferences;
  bool _showErrorText = false;
  bool _notValid = false;
  bool _notCorrect = false;
  @override
  void initState() {
    _showErrorText = false;
    _notValid = false;
    _notCorrect = false;
  }
  String _errorMessage() {
    if (_notValid) {
      return 'All fields are required';
    } else if (_notCorrect) {
      return 'Email or password are not valid';
    } else {
      return 'Error'; // Return empty string if no error message should be displayed
    }
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
                    "Asmaa@gmail.com", false, isObscurePassword,_emailController)),
            const SizedBox(height: 10,),
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 15),
                width: 280,
                height: 50,
                child: buildTextField(Icons.lock_outline, "Password",
                    "**********", true, isObscurePassword,_passwordController)),
            Visibility(
              visible: _showErrorText,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  _errorMessage(),
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {
                  _notCorrect=false;
                  _notValid=false;
                  _showErrorText=false;
                  if (_emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty) {
                    doLogin(_emailController.text, _passwordController.text);
                  } else {
                    setState(() {
                      _showErrorText = true;
                      _notValid=true;
                    });
                  }
                },
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

  doLogin(String email, String password) async{
    _sharedPreferences = await SharedPreferences.getInstance();
    var rest = await userLogin(email.trim(), password.trim());

    if(rest['success']){
      String userEmail= rest['data'][0]['Email'];
      String userID= rest['data'][0]['UserID'].toString();
      _sharedPreferences.setString('userID', userID);
      _sharedPreferences.setString('userEmail', userEmail);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const MainPage()));
    }else{
      setState(() {
        _showErrorText = true;
        _notCorrect=true;
      });
    }
  }
}
