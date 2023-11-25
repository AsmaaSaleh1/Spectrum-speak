import 'package:flutter/material.dart';

import 'package:spectrum_speak/const.dart';
import 'login.dart';
import 'follow_up_sign_up.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController = new TextEditingController();
  bool _passwordVisible1=false;
  bool _obscureText1=true;
  bool _passwordVisible2=false;
  bool _obscureText2=true;
  bool showText=false;
  @override
  void initState() {
    _passwordVisible1 = false;
    _obscureText1 = true;
    _passwordVisible2 = false;
    _obscureText2 = true;
  }
  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }
  void _toggle2() {
    setState(() {
      _obscureText2= !_obscureText2;
    });
  }
  bool confirmation()
  {
    if(_confirmPasswordController.text==_passwordController.text)
    {
      return true;
    }
    return false;
  }
  void noMatch()
  {
    setState(() {
      showText=true;
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
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top:100,bottom: 35),
                      child: Text('Sign Up', style: TextStyle(color: Color(0xff0E5F88),fontSize: 28,fontFamily: 'IstokWeb',fontWeight: FontWeight.bold)),
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: Wrap(
                            spacing:0,
                            children: [
                              // Container(
                              //   alignment: Alignment.center,
                              Image.asset('images/emaill.png'),
                              // ),
                              Container(
                                  margin: EdgeInsets.only(bottom: 15),
                                  width: 260,
                                  height: 50,
                                  child: TextField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: kDarkerColor,
                                      border:OutlineInputBorder(borderRadius: BorderRadius.only( topRight: Radius.circular(15.0),bottomRight: Radius.circular(15.0)),borderSide: BorderSide.none),
                                      hintText: 'Email Address',
                                      hintStyle: TextStyle(fontSize: 15.0,color: tdPlaceHolder),
                                    ),

                                  )
                              ),
                            ]
                        )
                    ),
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10,bottom: 15),
                        child: Wrap(
                            spacing:0,
                            children: [
                              // Container(
                              //   alignment: Alignment.center,
                              Image.asset('images/username.png'),
                              // ),
                              Container(
                                  width: 260,
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: TextField(
                                      controller: _usernameController,
                                      style: TextStyle(color: ktextfieldColor),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: kDarkerColor,
                                        border:OutlineInputBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0),),borderSide: BorderSide.none),
                                        hintText: 'Username',
                                        hintStyle: TextStyle(fontSize: 15.0,color: tdPlaceHolder),
                                      )
                                  )
                              ),
                            ]
                        )
                    ),
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10,bottom: 15),
                        child: Wrap(
                            spacing:0,
                            children: [
                              // Container(
                              //   alignment: Alignment.center,
                              Image.asset('images/phone.png'),
                              // ),
                              Container(
                                  width: 260,
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: TextField(
                                      controller: _phoneNumberController,
                                      style: TextStyle(color: ktextfieldColor),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: kDarkerColor,
                                        border:OutlineInputBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0),),borderSide: BorderSide.none),
                                        hintText: 'Phone Number',
                                        hintStyle: TextStyle(fontSize: 15.0,color: tdPlaceHolder),
                                      )
                                  )
                              ),
                            ]
                        )
                    ),
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10,bottom: 15),
                        child: Wrap(
                            spacing:0,
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
                                      obscureText: _obscureText1,
                                      style: TextStyle(color: ktextfieldColor),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: kDarkerColor,
                                        border:OutlineInputBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0),),borderSide: BorderSide.none),
                                        hintText: 'Password',
                                        hintStyle: TextStyle(fontSize: 15.0,color: tdPlaceHolder),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            // Based on passwordVisible state choose the icon
                                            _passwordVisible1
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Theme.of(context).primaryColorDark,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _passwordVisible1 = !_passwordVisible1;
                                              _toggle1();
                                            });
                                          },
                                        ),
                                      )
                                  )
                              ),
                            ]
                        )
                    ),
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10,bottom: 25),
                        child: Wrap(
                            spacing:0,
                            children: [
                              // Container(
                              //   alignment: Alignment.center,
                              Image.asset('images/confirm.png'),
                              // ),
                              Container(
                                  width: 260,
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: TextField(
                                      controller: _confirmPasswordController,
                                      obscureText: _obscureText2,
                                      style: TextStyle(color: ktextfieldColor),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: kDarkerColor,
                                        border:OutlineInputBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), bottomRight: Radius.circular(15.0),),borderSide: BorderSide.none),
                                        hintText: 'Confirm Password',
                                        hintStyle: TextStyle(fontSize: 15.0,color: tdPlaceHolder),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            // Based on passwordVisible state choose the icon
                                            _passwordVisible2
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Theme.of(context).primaryColorDark,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _passwordVisible2 = !_passwordVisible2;
                                              _toggle2();
                                            });
                                          },
                                        ),
                                      )
                                  )
                              ),
                            ]
                        )
                    ),
                    showText ?
                    Container(
                        margin: EdgeInsets.only(left:40),
                        alignment: Alignment.centerLeft,
                        child:Text('Passwords do not match', style: TextStyle(color: Colors.red,fontSize: 15,fontFamily: 'Poppins'))
                    )
                        :Container(child:null),
                    ElevatedButton(
                      onPressed: (){
                        if(confirmation()==true)
                        {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FollowUpSignUp()));
                        }
                        else
                        {
                          noMatch();
                        }
                      },
                      child: Text('Sign Up',style: TextStyle(color: kDarkBlue,fontFamily: 'Inter',fontSize: 19,fontWeight: FontWeight.bold)),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(tdPurple),
                        fixedSize: MaterialStateProperty.all(Size(315, 50)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                        ),// specify width, height
                      ),

                    ),
                    Row(
                        children: [
                          Container(
                              alignment: Alignment.topCenter,
                              margin: EdgeInsets.only(left: 31,top:20,right:20),
                              width:120,
                              child: Text(' ', style: TextStyle(color:Colors.deepOrange)),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: tdPurple)),
                              )
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 33),
                            child: Text('OR', style: TextStyle(color: kDarkBlue,fontFamily: 'Poppins',fontWeight: FontWeight.bold,fontSize: 20)),
                          ),
                          Container(
                              alignment: Alignment.topCenter,
                              margin: EdgeInsets.only(left: 20,top:20),
                              width:120,
                              child: Text(' ', style: TextStyle(color:Colors.deepOrange)),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: tdPurple)),
                              )
                          )
                        ]
                    ),
                    Container(
                      margin: EdgeInsets.only(top:25),
                      child:null,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login()));
                      },
                      child: Text('Do you have an account? Log in',
                        style: TextStyle(color: kDarkBlue, decoration: TextDecoration.underline,fontSize: 15,fontFamily: 'Poppins'),
                      ),
                    ),
                  ]
              ),
            )
        )
    );
  }
}