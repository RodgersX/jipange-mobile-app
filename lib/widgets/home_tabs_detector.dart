import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

// relative imports
import '../providers/dark_theme_provider.dart';

class HomeGestureDetector extends StatelessWidget {
  final Color backgroundcolor;
  final Color textcolor;
  final Color prefixcolor;
  final double percent;
  final String title;
  final String amount;
  final VoidCallback tapHandler;
  final Color barClr;

  const HomeGestureDetector(
      {required this.backgroundcolor,
      required this.textcolor,
      required this.percent,
      required this.barClr,
      required this.prefixcolor,
      required this.title,
      required this.amount,
      required this.tapHandler,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;

    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      child: Container(
        width: _screenWidth * .389,
        height: _screenHeight * .219,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(14.0)),
          color: backgroundcolor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(
                  left: _screenWidth * .058,
                  top: _screenHeight * .028,
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: isDark
                        ? Colors.white
                        : const Color.fromRGBO(75, 75, 75, 1),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: _screenHeight * .0344,
                left: _screenWidth * .058,
              ),
              child: Row(
                children: [
                  Text(
                    'Ksh. ',
                    style: TextStyle(
                      color: prefixcolor,
                      fontSize: 13,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      amount,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: textcolor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: LinearPercentIndicator(
                lineHeight: 4,
                percent: percent,
                progressColor: barClr,
              ),
            ),
            const SizedBox(height: 7)
          ],
        ),
      ),
      onTap: tapHandler,
    );
  }
}
