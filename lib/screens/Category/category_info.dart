import 'package:app1/db/db_connect.dart';
import 'package:flutter/material.dart';

// relative imports
import '../../Layouts/details_layout.dart';
import '../../widgets/widgets.dart';

class ScreenArgs {
  final String tag;
  final String catTitle;

  ScreenArgs(this.catTitle, this.tag);
}

// ignore: use_key_in_widget_constructors
class CategoryDetails extends StatelessWidget {
  static const routeName = '/category-details';

  final DbProvider _dbProvider = DbProvider.db;

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as ScreenArgs;

    return DetailsLayout(
      tag: routeArgs.tag,
      listTitle: routeArgs.catTitle,
      details: details(context),
      backgroundColor: const Color(0xFF461E58),
    );
  }

  Widget details(context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as ScreenArgs;
    final transactions = _dbProvider.fetchtransactions;

    // total spent per category
    double totalAmountIn = 0.0;
    double totalAmountOut = 0.0;

    for (int i = 0; i < transactions.length; i++) {
      if (transactions[i].category == routeArgs.catTitle) {
        if (transactions[i].incomeOrExpense == 'out') {
          totalAmountOut += transactions[i].amount;
        } else if (transactions[i].incomeOrExpense == 'in') {
          totalAmountIn += transactions[i].amount;
        }
      }
    }

    final mediaQuery = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          Text(
            routeArgs.tag == 'out'
                ? 'On ${routeArgs.catTitle}, you spent'
                : 'Your income from ${routeArgs.catTitle}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: mediaQuery.width * .05,
            ),
          ),
          Text(
            'Ksh. ${routeArgs.tag == 'out' ? totalAmountOut.toStringAsFixed(0) : totalAmountIn.toStringAsFixed(0)}',
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 30.0,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: CategoryFlChart(),
            ),
          ),
        ],
      ),
    );
  }
}
