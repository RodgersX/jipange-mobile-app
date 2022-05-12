// @dart=2.9

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/providers.dart';
import './screens/screens.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePref.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => themeChangeProvider,
        ),
        ChangeNotifierProvider(
          create: (_) => TransactionProv(),
        ),
        ChangeNotifierProvider(
          create: (_) => AdvisorsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoriesProv(),
        )
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (ctx, _, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Jipange App',
            initialRoute: '/',
            routes: {
              '/': (ctx) => Home(),
              LogIn.routeName: (ctx) => LogIn(),
              Homepage.routeName: (ctx) => Homepage(),
              ExpenditureCategories.routeName: (ctx) => ExpenditureCategories(),
              MoneyOverview.routeName: (ctx) => MoneyOverview(),
              AdvisorsList.routeName: (ctx) => AdvisorsList(),
              AdvisorView.routeName: (ctx) => AdvisorView(),
              CutExpenditure.routeName: (ctx) => CutExpenditure(),
              ProfilePage.routeName: (ctx) => ProfilePage(),
              CategoryDetails.routeName: (ctx) => CategoryDetails(),
              CategoryItem.routeName: (ctx) => CategoryItem(),
              MessageAdvisor.routeName: (ctx) => MessageAdvisor(),
              BudgetCategories.routeName: (ctx) => BudgetCategories(),
              ResetPage.routeName: (ctx) => ResetPage(),
            },
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
          );
        },
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Splash();
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
