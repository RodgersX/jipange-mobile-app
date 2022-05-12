// ignore: file_names
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import './phoneInput.dart';
import '../../models/user.dart';

class CredentialsInput extends StatefulWidget {
  static const routeName = '/CredentialsInput';
  final NewUser newUser;
  const CredentialsInput({Key? key, required this.newUser}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CredentialsInputState();
}

class _CredentialsInputState extends State<CredentialsInput> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    num _screenWidth = MediaQuery.of(context).size.width;
    num _screenHeight = MediaQuery.of(context).size.height;
    String? firstName = widget.newUser.firstName;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        // padding: const EdgeInsets.only(left: 30),
        color: Theme.of(context).primaryColor,
        child: ListView(children: [
          SizedBox(
            height: _screenHeight * .195,
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Hello, ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Theme.of(context).buttonColor,
                            fontSize: 46,
                            letterSpacing: -2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: firstName,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 46,
                            letterSpacing: -2,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(187, 96, 228, 1),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Let\'s get to know you',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 24,
                      letterSpacing: -.4,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).buttonColor,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Center(
                  child: Container(
                    width: _screenWidth * .8,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).buttonColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      style: TextStyle(color: Theme.of(context).hintColor),
                      controller: emailCtrl,
                      // validator: emailValidator,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 10, top: 5),
                        border: InputBorder.none,
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).buttonColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Center(
                  child: Container(
                    width: _screenWidth * .8,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).buttonColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      style: TextStyle(color: Theme.of(context).hintColor),
                      controller: passwordCtrl,
                      obscureText: true,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 10, top: 5),
                        border: InputBorder.none,
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).buttonColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Center(
                  child: Container(
                    width: _screenWidth * .8,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).buttonColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      style: TextStyle(color: Theme.of(context).hintColor),
                      controller: confirmPasswordCtrl,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 10, top: 5),
                        border: InputBorder.none,
                        labelText: 'Confirm password',
                        labelStyle: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).buttonColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {
                      widget.newUser.email = emailCtrl.text;
                      widget.newUser.password = passwordCtrl.text;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PhoneNumberInput(newUser: widget.newUser),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).buttonColor,
                      size: 130,
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  // String? emailValidator(String? value) {
  //   if (value == null) {
  //     return 'Looks like you forgot this...';
  //   }
  //   var emailValid = RegExp(
  //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
  //       .hasMatch(value.toString());

  //   if (!emailValid) {
  //     return 'Kindly check the email format';
  //   }
  //   return null;
}
