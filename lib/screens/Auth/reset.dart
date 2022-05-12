// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../providers/auth.dart';
import '../../screens/Auth/login.dart';

// ignore: use_key_in_widget_constructors
class ResetPage extends StatefulWidget {
  static const routeName = '/reset';
  @override
  State<StatefulWidget> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final TextEditingController emailController = TextEditingController();

  bool isLoading = false;

  void resetPass({required String email}) async {
    setState(() {
      isLoading = true;
    });
    if (email != '') {
      var res = await AuthenticationService()
          .resetPassword(email: emailController.text.trim());
      if (res == 'email sent') {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pushNamedAndRemoveUntil(
          LogIn.routeName,
          (route) => false,
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res.toString())));
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res.toString())));
      }
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Enter a valid email address')));
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(children: [
          const SizedBox(
            height: 71,
          ),
          Column(
            children: [
              Text(
                'Jipange!',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  // textStyle: Theme.of(context).textTheme.headline2,
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).buttonColor,
                ),
              ),
              const Text(
                'Reset your password',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 23,
                  color: const Color.fromRGBO(187, 96, 228, 1),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(40, 90, 40, 10),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).buttonColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      style: TextStyle(color: Theme.of(context).hintColor),
                      controller: emailController,
                      decoration: InputDecoration(
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
              ),
              SizedBox(height: 40),
              resetPassButton(emailController),
            ],
          )
        ]),
      ),
    );
  }

  Container resetPassButton(TextEditingController controller) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(93, 56, 109, 1),
        borderRadius: BorderRadius.circular(50),
        gradient: const LinearGradient(
          begin: Alignment(0.0, -1.0),
          end: Alignment(0.0, 1.0),
          colors: [
            Color.fromRGBO(215, 150, 247, 1),
            Color.fromRGBO(180, 103, 214, 1),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 4), // changes position of shadow
          )
        ],
      ),
      child: GestureDetector(
        onTap: () => resetPass(
          email: controller.text.trim(),
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : Text(
                  'Reset Password',
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
    );
  }
}
