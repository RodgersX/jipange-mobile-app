import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// relative imports
import './specific_category_info.dart';
import '../../widgets/widgets.dart';
import '../../db/db_connect.dart';
import '../../providers/dark_theme_provider.dart';

// ignore: must_be_immutable
class PanelWidget extends StatelessWidget {
  final String listTitle;
  final String tag;

  // ignore: use_key_in_widget_constructors
  PanelWidget(this.listTitle, this.tag);

  final DbProvider _dbProvider = DbProvider.db;

  _dateConverter(String date) {
    DateTime txDate = DateTime.parse(date);
    var formattedDate = DateFormat.yMMMMd('en_US').format(txDate);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<DarkThemeProvider>(context).darkTheme;
    final transactions = _dbProvider.fetchtransactions;

    final filterTransactionsOut = [];
    final filterTransactionsIn = [];

    for (int i = 0; i < transactions.length; i++) {
      if (transactions[i].category == listTitle) {
        if (transactions[i].incomeOrExpense == 'out') {
          filterTransactionsOut.add(transactions[i]);
        } else {
          filterTransactionsIn.add(transactions[i]);
        }
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          CategoryBuildDragHandle(
            '$listTitle',
          ),
          const SizedBox(
            height: 23,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tag == 'in'
                  ? filterTransactionsIn.length
                  : filterTransactionsOut.length,
              itemBuilder: (ctx, i) {
                return InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        color: isDark
                            ? const Color.fromRGBO(92, 75, 9, 1)
                            : const Color.fromRGBO(255, 246, 209, 1),
                        borderRadius: BorderRadius.circular(25)),
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(6),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: const AssetImage(
                            'assets/images/logo-placeholder.png'),
                        backgroundColor: Colors.purple[100],
                      ),
                      title: Text(
                        tag == 'in'
                            ? filterTransactionsIn[i]
                                .sourceOrRecipients
                                .toString()
                            : filterTransactionsOut[i]
                                .sourceOrRecipients
                                .toString(),
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      subtitle: Text(
                        tag == 'in'
                            ? _dateConverter(filterTransactionsIn[i].date)
                            : _dateConverter(filterTransactionsOut[i].date),
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      trailing: tag == 'in'
                          ? Text(
                              '${filterTransactionsIn[i].amount.toStringAsFixed(0)} /-',
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            )
                          : Text(
                              '${filterTransactionsOut[i].amount.toStringAsFixed(0)} /-',
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                    ),
                  ),
                  onTap: () {
                    final amount = tag == 'in'
                        ? filterTransactionsIn[i].amount.toStringAsFixed(0)
                        : filterTransactionsOut[i].amount.toStringAsFixed(0);
                    final title = tag == 'in'
                        ? filterTransactionsIn[i].sourceOrRecipients
                        : filterTransactionsOut[i].sourceOrRecipients;

                    Navigator.of(context).pushNamed(
                      CategoryItem.routeName,
                      arguments: SpecificCatArgs(amount, tag, title),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
