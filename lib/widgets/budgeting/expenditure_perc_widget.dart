import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

// relative imports
import '../../providers/dark_theme_provider.dart';
import '../../screens/Budgeting/category_budgeting.dart';

class CutExpenditurePerc extends StatelessWidget {
  final double totalExpensePerc = 58;

  const CutExpenditurePerc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;

    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .4,
          margin: const EdgeInsets.only(top: 18),
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 30),
          decoration: BoxDecoration(
              color: isDark
                  ? const Color.fromRGBO(75, 66, 79, 1)
                  : const Color.fromRGBO(242, 217, 253, 1),
              borderRadius: BorderRadius.circular(17)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'cut total spending by',
                style: TextStyle(
                  color: isDark
                      ? const Color(0xFF9367C6)
                      : const Color(0xFF461E58),
                  fontFamily: 'Poppins',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${totalExpensePerc.toStringAsFixed(0)}%',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: isDark
                      ? const Color(0xFF9367C6)
                      : const Color(0xFF461E58),
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              LinearPercentIndicator(
                percent: totalExpensePerc / 100,
                progressColor: isDark
                    ? const Color.fromRGBO(56, 221, 63, 1)
                    : const Color.fromRGBO(39, 141, 116, 1),
              )
            ],
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          'Or',
          style: TextStyle(
              fontFamily: 'Poppins', color: Color.fromRGBO(103, 103, 103, 1)),
        ),
        const SizedBox(height: 15),
        // ignore: deprecated_member_use
        FlatButton(
          child: const Text(
            'budget by category',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Color.fromRGBO(147, 103, 198, 1),
            ),
          ),
          onPressed: () {
            Navigator.of(context)
                .pushNamed(BudgetCategories.routeName, arguments: 'in');
          },
        )
      ],
    );
  }
}
