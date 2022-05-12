// ignore: file_names
// ignore: file_names
// ignore: file_names

// ignore_for_file: deprecated_member_use, unused_field

import 'package:app1/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// relative imports
import './Category/expenditure_categories.dart';
import '../db/db_connect.dart';
import '../models/models.dart';
import '../providers/classifier.dart';
import '../providers/dark_theme_provider.dart';
import '../widgets/widgets.dart';

// ignore: use_key_in_widget_constructors
class Homepage extends StatefulWidget {
  static const routeName = '/homepage';

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<List<Transaction>> transactions;

  final DbProvider _dbProvider = DbProvider.db;

  late Classifier _classifier;
  bool modelLoaded = false;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      // Provider.of<CategoriesProv>(context, listen: false).fetchCategories();

      // Provider.of<TransactionProv>(context, listen: false).fetchTransactions();
    });

    transactions = _dbProvider.getAllTransactions();
    _classifier = Classifier();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: MainDrawer(
          anyWidget: homepage(context, _screenWidth, _screenHeight),
          backgroundClr: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget homepage(context, screenWidth, screenHeight) {
    double _marginLeft = screenWidth * .094;
    double _marginRight = screenWidth * .094;

    return Padding(
      padding: EdgeInsets.only(left: _marginLeft, right: _marginRight),
      child: SingleChildScrollView(
        child: Column(
          children: [
            welcomeMessage(context, screenHeight),
            HomeOverview(),
            FutureBuilder<List<Transaction>>(
                future: transactions,
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? MoneyTabs(
                          transactions: snapshot.data!,
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                })
          ],
        ),
      ),
    );
  }

  Widget welcomeMessage(context, screenHeight) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;
    String profileName = 'George';

    return Container(
      // height: screenHeight * .106,
      alignment: Alignment.center,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight * .042),
          child: Column(
            children: [
              Text(
                'Good Afternoon',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontFamily: 'Inter',
                  fontSize: 20,
                ),
              ),
              Text(
                profileName,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 32,
                  color: isDark
                      ? const Color(0xFF9367C6)
                      : const Color(0xFF461E58),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
// ignore: use_key_in_widget_constructors
class MoneyTabs extends StatelessWidget {
  final List<Transaction> transactions;

  const MoneyTabs({
    Key? key,
    required this.transactions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;

    double totalOut = 0.0;
    double totalIn = 0.0;

    for (int i = 0; i < transactions.length; i++) {
      if (transactions[i].incomeOrExpense == 'in') {
        totalIn += transactions[i].amount;
      } else if (transactions[i].incomeOrExpense == 'out') {
        totalOut += transactions[i].amount;
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        HomeGestureDetector(
          percent: .8,
          barClr: isDark
              ? const Color.fromRGBO(56, 221, 63, 1)
              : const Color.fromRGBO(81, 122, 83, 1),
          backgroundcolor: isDark
              ? const Color.fromRGBO(50, 119, 49, 0.64)
              : const Color.fromRGBO(167, 240, 165, 1),
          textcolor: isDark
              ? const Color.fromRGBO(148, 255, 152, 1)
              : const Color.fromRGBO(81, 122, 83, 1),
          prefixcolor: isDark
              ? const Color.fromRGBO(148, 255, 152, 1)
              : const Color.fromRGBO(81, 122, 83, 1),
          title: 'Money In',
          amount: totalIn.toStringAsFixed(0),
          tapHandler: () {
            // route to categories for money in
            Navigator.of(context).pushNamed(
              ExpenditureCategories.routeName,
              arguments: ScreenArguments(totalIn.toStringAsFixed(0), 'in'),
            );
          },
        ),
        Flexible(
          child: HomeGestureDetector(
            percent: .5,
            barClr: isDark
                ? const Color.fromRGBO(252, 210, 128, 1)
                : const Color.fromRGBO(220, 20, 60, 1),
            backgroundcolor: isDark
                ? const Color.fromRGBO(89, 45, 45, 1)
                : const Color.fromRGBO(255, 189, 209, 1),
            textcolor: isDark
                ? const Color.fromRGBO(211, 87, 87, 1)
                : const Color.fromRGBO(220, 20, 60, 1),
            prefixcolor: isDark
                ? const Color.fromRGBO(211, 87, 87, 1)
                : const Color.fromRGBO(220, 20, 60, 1),
            title: 'Money Out',
            amount: totalOut.toStringAsFixed(0),
            tapHandler: () {
              Navigator.of(context).pushNamed(
                ExpenditureCategories.routeName,
                arguments: ScreenArguments(totalOut.toStringAsFixed(0), 'out'),
              );
            },
          ),
        ),
      ],
    );
  }
}
