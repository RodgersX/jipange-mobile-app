import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

// relative paths
import '../providers/providers.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

// ignore: use_key_in_widget_constructors
class ProfilePage extends StatelessWidget {
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
        backgroundColor: const Color.fromRGBO(70, 30, 88, 1),
      ),
      body: Container(
        padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Center(
                child: Text(
                  'ACCOUNT',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 23,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue[50],
                  child: Text(
                    'G',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.lightBlue[200],
                      fontSize: 25,
                    ),
                  ),
                ),
                title: Text(
                  'George',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                subtitle: const Text(
                  '+254709876543',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.grey,
                  ),
                ),
                trailing: GestureDetector(
                  child: const Chip(
                    label: Text(
                      'Edit Picture',
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                    elevation: 4,
                    backgroundColor: Colors.white,
                  ),
                  onTap: () {},
                ),
              ),
              const SizedBox(height: 30),
              const ProfileSectionTitle('SETTINGS'),
              const ProfileListTile(
                  'MANAGE FINANCES', Icons.money_sharp, Colors.blue),
              BiometricSwitch(),
              ProfileListTile('CHANGE PASSWORD', Icons.lock, Colors.red[200]),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red[600],
                  child: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  'LOGOUT',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                onTap: () {
                  AuthenticationService().logout();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LogIn.routeName,
                    (route) => false,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Logged out successfully...')));
                },
              ),
              const SizedBox(height: 20),
              const ProfileSectionTitle('SUPPORT'),
              const ProfileListTile(
                'MAKE REQUEST',
                Icons.mail,
                Colors.blue,
              ),
              const ProfileListTile('CALL SUPPORT', Icons.phone, Colors.blue),
              const ProfileListTile('FAQ', Icons.book, Colors.blue),
              ProfileListTile('JIPANGE WEBSITE', Icons.web, Colors.purple[800]),
              const SizedBox(height: 20),
              const ProfileSectionTitle('SOCIAL'),
              SocialListTile(
                  'FACEBOOK', FontAwesomeIcons.facebookF, Colors.blue[800]),
              ProfileListTile(
                  'TWITTER', FontAwesomeIcons.twitter, Colors.blue[200]),
              ProfileListTile(
                  'YOUTUBE', FontAwesomeIcons.youtube, Colors.red[600]),
              const SizedBox(height: 20),
              const ProfileSectionTitle('ABOUT'),
              ProfileListTile('RATE US ON GOOGLE PLAY', Icons.rate_review,
                  Colors.purple[500]),
              ProfileListTile('TERMS AND CONDITIONS', Icons.text_format_rounded,
                  Colors.purple[500]),
              ProfileListTile(
                  'PRIVACY POLICY', Icons.policy, Colors.purple[500]),
              const SizedBox(height: 30),
              const ProfileSectionTitle('Jipange 1.0.0')
            ],
          ),
        ),
      ),
    );
  }
}
