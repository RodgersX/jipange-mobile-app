// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';

// import '../db/db_connect.dart';
import '../providers/providers.dart';
import 'screens.dart';

// ignore: use_key_in_widget_constructors
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;

    Future.delayed(const Duration(seconds: 3), () {
      if (auth.currentUser == null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LogIn()),
          (route) => false,
        );
      } else {
        Provider.of<CategoriesProv>(context, listen: false).fetchCategories();

        Provider.of<TransactionProv>(context, listen: false)
            .fetchTransactions();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
          (route) => false,
        );
      }
    });

    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * .7,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('assets/images/logo.png'),
              Text(
                'Jipange',
                style: TextStyle(
                  fontSize: 30,
                  color: isDark
                      ? const Color(0xFF9367C6)
                      : const Color(0xFF461E58),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 80),
              LoadingBouncingLine.circle(
                size: 30,
                backgroundColor: const Color(0xFF461E58),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
