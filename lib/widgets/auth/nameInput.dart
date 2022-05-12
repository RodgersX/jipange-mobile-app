// ignore: file_names
// ignore_for_file: deprecated_member_use

import 'package:app1/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './credentialsInput.dart';
import '../../models/user.dart';

class NameInput extends StatefulWidget {
  static const routeName = '/NameInput';

  final NewUser newUser;
  const NameInput({Key? key, required this.newUser}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _NameInputState();
}

class _NameInputState extends State<NameInput> {
  final TextEditingController _firstNameCtrl = TextEditingController();
  final TextEditingController _lastNameCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Looks like you forgot this...';
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;
    num _screenWidth = MediaQuery.of(context).size.width;
    num _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(children: [
          SizedBox(
            height: _screenHeight * .195,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: _screenWidth * .139),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Karibu!',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 46,
                        letterSpacing: -2,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).buttonColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: _screenWidth * .139),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    // ignore: prefer_const_constructors
                    child: Text(
                      'Let\'s get to know you',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 24,
                        letterSpacing: -.4,
                        fontWeight: FontWeight.w400,
                        color: isDark
                            ? Color.fromRGBO(238, 202, 255, 1)
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
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
                      controller: _firstNameCtrl,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        border: InputBorder.none,
                        labelText: 'First Name',
                        labelStyle: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
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
                      controller: _lastNameCtrl,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        border: InputBorder.none,
                        labelText: 'Last Name',
                        labelStyle: TextStyle(
                          fontFamily: 'Inter',
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
                      if (_formKey.currentState!.validate()) {
                        widget.newUser.firstName = _firstNameCtrl.text;
                        widget.newUser.lastName = _lastNameCtrl.text;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CredentialsInput(newUser: widget.newUser),
                          ),
                        );
                      }
                    },
                    child: Icon(
                      Icons.chevron_right_outlined,
                      color: Theme.of(context).buttonColor,
                      size: 100,
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
}
