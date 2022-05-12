// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../providers/auth.dart';
import '../../providers/providers.dart';
import '../../screens/screens.dart';
import '../../widgets/widgets.dart';

// ignore: use_key_in_widget_constructors
class LogIn extends StatefulWidget {
  static const routeName = '/login';
  @override
  State<StatefulWidget> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final newUser = NewUser();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  _signinMethod({required String email, required String password}) async {
    setState(() {
      isLoading = true;
    });

    if (email != '' && password != '') {
      var res = await AuthenticationService()
          .signIn(email: email, password: password);
      if (res == 'welcome') {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pushNamedAndRemoveUntil(
          Homepage.routeName,
          (route) => false,
        );
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
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email and password cannot be empty!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    num _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: [
            const SizedBox(
              height: 71,
            ),
            Column(
              children: [
                Text(
                  'Jipange!',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    // fontStyle: Theme.of(context).textTheme.headline2,
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).buttonColor,
                  ),
                ),
                Text(
                  'Sign in to proceed',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    // textStyle: Theme.of(context).textTheme.headline2,
                    fontSize: 23,
                    color: Color.fromRGBO(180, 103, 214, 1),
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  width: _screenWidth * .8,
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
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        border: InputBorder.none,
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontSize: 17,
                          color: Theme.of(context).buttonColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: _screenWidth * .8,
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
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        border: InputBorder.none,
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontSize: 17,
                          color: Theme.of(context).buttonColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                GestureDetector(
                  onTap: () => _signinMethod(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  ),
                  child: Container(
                    width: 200,
                    height: 55,
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
                          offset:
                              const Offset(0, 4), // changes position of shadow
                        )
                      ],
                    ),
                    child: Center(
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              'Sign In',
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
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NameInput(
                          newUser: newUser,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 90),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontFamily: 'Inter',
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.of(context).pushNamed(ResetPage.routeName);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Text(
                      'Forgot password',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 13,
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
