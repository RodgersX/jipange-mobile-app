import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// relative imports
import '../db/db_connect.dart';
import '../providers/dark_theme_provider.dart';

// ignore: use_key_in_widget_constructors
class HomeOverview extends StatefulWidget {
  @override
  State<HomeOverview> createState() => _HomeOverviewState();
}

class _HomeOverviewState extends State<HomeOverview> {
  final DbProvider _dbProvider = DbProvider.db;
  late double totalIn;
  late double totalOut;

  @override
  void initState() {
    totalIn = _dbProvider.totalInToday;
    totalOut = _dbProvider.totalOutToday;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;

    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;

    // double totalIn = _dbProvider.totalInToday;
    // double totalOut = _dbProvider.totalOutToday;

    return Container(
      margin: EdgeInsets.only(
        top: _screenHeight * .0422,
        bottom: _screenHeight * .055,
      ),
      height: _screenHeight * .341,
      // padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(14.0)),
        color: isDark
            ? const Color.fromRGBO(75, 66, 79, 1)
            : const Color.fromRGBO(242, 217, 253, 1),
      ),
      child: Column(
        children: [
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(
                left: _screenWidth * .05,
                right: _screenWidth * .05,
                top: _screenHeight * .015,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today\'s \nOverview',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      color: isDark
                          ? Colors.white
                          : const Color.fromRGBO(70, 30, 88, 1),
                    ),
                  ),
                  const Icon(
                    Icons.more_horiz,
                    color: Color.fromRGBO(103, 103, 103, 1),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: _screenWidth * .757,
            height: _screenHeight * .144,
            margin: EdgeInsets.only(
              top: _screenHeight * .09,
              bottom: _screenHeight * .015,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(14.0)),
              color: isDark
                  ? const Color.fromRGBO(101, 101, 101, 1)
                  : Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _moneys(
                  'Money In:',
                  'Ksh. ${totalIn.toStringAsFixed(0)}',
                  isDark
                      ? const Color.fromRGBO(157, 255, 156, 1)
                      : const Color.fromRGBO(4, 50, 121, 1),
                  context,
                ),
                _moneys(
                  'Money Out:',
                  'Ksh. ${totalOut.toStringAsFixed(0)}',
                  isDark
                      ? const Color.fromRGBO(255, 188, 167, 1)
                      : const Color.fromRGBO(183, 0, 228, 1),
                  context,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Column _moneys(String title, String amount, Color textcolor, context) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Inter',
              color:
                  isDark ? Colors.white : const Color.fromRGBO(75, 75, 75, 1),
            ),
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: textcolor,
          ),
        ),
      ],
    );
  }
}
