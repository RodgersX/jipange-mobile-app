// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/user.dart';
import '../../providers/auth.dart';
import '../../screens/Home.dart';

class PhoneNumberInput extends StatefulWidget {
  static const routeName = '/PhoneNumberInput';
  final NewUser newUser;
  const PhoneNumberInput({Key? key, required this.newUser}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  final TextEditingController _phoneNumberCtrl = TextEditingController();

  bool isLoading = false;

  void register({required String email, required String password}) async {
    setState(() {
      isLoading = true;
    });
    var res = await AuthenticationService().createAccount(
      email: email.trim(),
      password: password.trim(),
    );

    if (res == 'Account created') {
      setState(() {
        isLoading = false;
      });
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
        (route) => false,
      );
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error! Try again in a few minutes')));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _phoneNumberCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    num _screenWidth = MediaQuery.of(context).size.width;
    num _screenHeight = MediaQuery.of(context).size.height;

    String? email = widget.newUser.email.toString();
    String? password = widget.newUser.password.toString();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: [
            SizedBox(height: _screenHeight * .195),
            Column(
              children: [
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'One ',
                            style: GoogleFonts.poppins(
                              textStyle: Theme.of(context).textTheme.headline2,
                              fontSize: 36,
                              letterSpacing: -2,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).buttonColor,
                            )),
                        TextSpan(
                          text: 'final ',
                          style: GoogleFonts.poppins(
                            textStyle: Theme.of(context).textTheme.headline2,
                            fontSize: 36,
                            letterSpacing: -2,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(187, 96, 228, 1),
                          ),
                        ),
                        TextSpan(
                            text: 'step!',
                            style: GoogleFonts.poppins(
                              textStyle: Theme.of(context).textTheme.headline2,
                              fontSize: 36,
                              letterSpacing: -2,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).buttonColor,
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Provide your phone number',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24,
                    letterSpacing: -.4,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).buttonColor,
                  ),
                ),
                SizedBox(height: 70),
                Container(
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
                    controller: _phoneNumberCtrl,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      border: InputBorder.none,
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).buttonColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60),
                Container(
                  width: 200,
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(93, 56,  109, 1),
                    borderRadius: BorderRadius.circular(50),
                    gradient: const LinearGradient(
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, 1.0),
                        colors: [
                          Color.fromRGBO(215, 150, 247, 1),
                          Color.fromRGBO(180, 103, 214, 1),
                        ]),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 4), // changes position of shadow
                      )
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () => register(email: email, password: password),
                    child: Center(
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              'Sign Up',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 24,
                                letterSpacing: -1,
                                fontWeight: FontWeight.w700,
                                color: const Color.fromRGBO(70, 30, 88, 1),
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


  // widget.newUser.phoneNumber = _phoneNumberCtrl.text;
  // var phoneNumber = widget.newUser.phoneNumber.toString();

  // await context
  //     .read<AuthenticationService>()
  //     .signUp(
  //       email: email,
  //       password: password,
  //       firstName: firstName,
  //       lastName: lastName,
  //       phoneNumber: phoneNumber,
  //     )
  //     .then((_) => Navigator.of(context)
  //         .pushReplacementNamed(Homepage.routeName))
  //     .catchError((e) {
  //   print("Sign-Up Error: ${e.error}");
  // });