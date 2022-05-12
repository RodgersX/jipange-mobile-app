import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

// ignore: use_key_in_widget_constructors
class BiometricSwitch extends StatefulWidget {
  @override
  _BiometricSwitchState createState() => _BiometricSwitchState();
}

class _BiometricSwitchState extends State<BiometricSwitch> {
  bool biometric = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;

    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.blue,
        child: Icon(Icons.fingerprint, color: Colors.white),
      ),
      title: Text(
        'FINGERPRINT',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
      subtitle: Text(
        biometric
            ? 'Turn off fingerprint sign in'
            : 'Turn on fingerprint sign in',
        style: const TextStyle(
          fontFamily: 'Inter',
          color: Colors.grey,
        ),
      ),
      trailing: Switch(
        activeColor: Theme.of(context).buttonColor,
        value: biometric,
        onChanged: (val) {
          setState(() {
            biometric = val;
          });
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class ProfileListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? color;

  const ProfileListTile(this.title, this.icon, this.color, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

class SocialListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? color;

  const SocialListTile(this.title, this.icon, this.color, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: FaIcon(
          icon,
          color: Colors.white,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

class ProfileSectionTitle extends StatelessWidget {
  final String text;

  const ProfileSectionTitle(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;

    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Poppins',
        color: isDark ? Colors.grey : Colors.black,
      ),
    );
  }
}
