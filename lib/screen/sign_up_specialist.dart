import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api.dart';
import 'package:spectrum_speak/units/build_drop_down_menu.dart';
import 'package:spectrum_speak/units/build_text_field.dart';
import 'package:spectrum_speak/units/validate_input_from_user.dart';
import 'main_page.dart';

class SignUpSpecialist extends StatefulWidget {
  const SignUpSpecialist({super.key});

  @override
  State<SignUpSpecialist> createState() => _SignUpSpecialistState();
}

class _SignUpSpecialistState extends State<SignUpSpecialist> {
  String? selectedSpecialist;
  bool isObscurePassword = true;
  final TextEditingController _priceController = TextEditingController();
  bool _showErrorText = false;
  bool _showPriceError =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Container(
                alignment: Alignment.topCenter,
                height: 210,
                //margin: const EdgeInsets.only(left: 8, top: 45),
                child: Image.asset(
                  'images/spectrumspeak.png',
                  width: 270.0,
                  height: 270.0,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 15, bottom: 35),
              child: Text(
                'Welcome, Specialist',
                style: TextStyle(
                  color: kDarkerColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 15),
              width: 280,
              height: 50,
              child: CustomTextField(
                  preIcon:FontAwesomeIcons.sackDollar,
                  labelText:"Price",
                  placeholder:"100\$ (in one session)",
                  isPasswordTextField:false,
                  controller:_priceController),
            ),
            Visibility(
              visible: _showPriceError,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Text(
                  'Please enter a valid price (maximum 99999.99)',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 15),
              width: 280,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 10, bottom: 0),
                    child: Icon(
                      FontAwesomeIcons.userDoctor,
                      size: 25.0,
                      color: kDarkerColor,
                    ),
                  ),
                  CustomDropDown(
                    items: const [
                      'Audio & Speech',
                      'Rehabilitation',
                      'Psychiatrists'
                    ],
                    selectedValue: selectedSpecialist,
                    hint: 'Select Category',
                    onChanged: (String? value) {
                      setState(() {
                        selectedSpecialist = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _showErrorText,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Text(
                  'All fields are required',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String? userId = await AuthManager.getUserId();
                _showErrorText=false;
                _showPriceError=false;
                if (userId != null) {
                  if(_priceController.text.isNotEmpty &&
                      selectedSpecialist.toString().isNotEmpty){
                    if(isDecimal(_priceController.text)){
                      saveSpecialist(
                          userId,
                          _priceController.text,
                          selectedSpecialist!
                      );
                    }else{
                      setState(() {
                        _showPriceError=true;
                      });
                    }
                  }else {
                    setState(() {
                      _showErrorText = true;
                    });
                  }

                } else {
                  // Handle the case where user ID is not available
                  print('User ID not available');
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
                'Done',
                style: TextStyle(
                  color: kDarkerColor,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
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

  saveSpecialist(String userId, String price,String selectedSpecialist) async {
    var rest = await specialistSignUp(userId,
        double.parse(price),
        selectedSpecialist);

    if (rest['success']) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const MainPage()));
    } else {
      setState(() {
        _showErrorText = true;
      });
    }
  }
}
