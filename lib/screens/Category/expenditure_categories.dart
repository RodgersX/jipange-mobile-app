// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

// relative imports
import '../../widgets/widgets.dart';

class ScreenArguments {
  final String amount;
  final String tag;

  ScreenArguments(this.amount, this.tag);
}

// ignore: use_key_in_widget_constructors
class ExpenditureCategories extends StatelessWidget {
  static const routeName = '/expenditure-category';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: MainDrawer(
          anyWidget: categories(context),
          backgroundClr: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget categories(context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          expense(context),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              routeArgs.tag == 'out'
                  ? 'Browse your spending by:'
                  : 'Browse your income by:',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          Expanded(
            child: ExpenditureListWidget(routeArgs.tag),
          )
        ],
      ),
    );
  }

  Align expense(context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              routeArgs.tag == 'out' ? 'You have Spent' : 'Your Total Income',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                color: Theme.of(context).accentColor,
              ),
            ),
            Text(
              "Ksh. ${routeArgs.amount}",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 28,
                color: Theme.of(context).errorColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
