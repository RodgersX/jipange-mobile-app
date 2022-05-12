import 'dart:math';

import 'package:app1/models/transactions.dart';
import 'package:flutter/material.dart';

// relative imports
import '../../db/db_connect.dart';

// ignore: must_be_immutable
// ignore: use_key_in_widget_constructors
class BudgetCategoryList extends StatelessWidget {
  
  final DbProvider _dbProvider = DbProvider.db;

  @override
  Widget build(BuildContext context) {
    final categoriesOut = _dbProvider.catTitlesOut;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: MediaQuery.of(context).size.height * .65,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 20,
          childAspectRatio: 4,
          mainAxisSpacing: 20,
        ),
        itemCount: categoriesOut.length,
        itemBuilder: (ctx, i) {
          return GestureDetector(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
              ),
              width: 80,
              alignment: Alignment.center,
              child: FittedBox(
                child: Text(
                  categoriesOut[i],
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            onTap: null,
          );
        },
      ),
    );
  }
}
