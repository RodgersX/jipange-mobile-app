// ignore_for_file: deprecated_member_use

import 'package:app1/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// relative imports
import './cut_total_expenditure.dart';
import '../../widgets/widgets.dart';
import '../../providers/dark_theme_provider.dart';
import '../../db/db_connect.dart';

class MoneyOverview extends StatefulWidget {
  static const routeName = '/money-overview';

  @override
  State<MoneyOverview> createState() => _MoneyOverviewState();
}

class _MoneyOverviewState extends State<MoneyOverview> {
  late Future<List<Transaction>> transactions;
  final DbProvider _dbProvider = DbProvider.db;

  @override
  void initState() {
    transactions = _dbProvider.getAllTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MainDrawer(
          anyWidget: FutureBuilder<List<Transaction>>(
            future: transactions,
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return overviewpage(
                context: context,
                transactions: snapshot.data!,
              );
            },
          ),
          backgroundClr: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget overviewpage({
    required BuildContext context,
    required List<Transaction> transactions,
  }) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;

    double totalOut = 0.0;
    double totalIn = 0.0;

    for (var tx in transactions) {
      if (tx.incomeOrExpense == 'out') {
        totalOut += tx.amount;
      } else {
        totalIn += tx.amount;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .5,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Your ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Cashflow ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        color: isDark
                            ? const Color(0xFF9367C6)
                            : const Color.fromRGBO(127, 71, 153, 1),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Snapshot',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildRowText(
                      'Income: ',
                      totalIn.toStringAsFixed(0),
                      isDark
                          ? const Color(0xFF9367C6)
                          : const Color.fromRGBO(127, 71, 153, 1),
                    ),
                    _buildRowText(
                      'Expense: ',
                      totalOut.toStringAsFixed(0),
                      const Color.fromRGBO(39, 208, 168, 1),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * .9,
                    child: BudgetFlChart(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          _buildBudgetControl(context),
        ],
      ),
    );
  }

  Widget _buildRowText(String title, String text, Color color) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            color: Color.fromRGBO(196, 195, 195, 1),
          ),
        ),
        FittedBox(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBudgetControl(context) {
    return Column(
      children: [
        Text(
          'Take better control of your finances:',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Theme.of(context).accentColor,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            primary: const Color.fromRGBO(220, 193, 255, 1),
          ),
          child: Container(
            padding: const EdgeInsets.all(2),
            width: 70,
            height: 70,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color.fromRGBO(177, 82, 220, 0.58),
                width: 10,
              ),
            ),
            child: const FittedBox(
              child: Text(
                'Budget Now',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),
              ),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(CutExpenditure.routeName);
          },
        )
      ],
    );
  }
}
