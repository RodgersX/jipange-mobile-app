import 'dart:math';

import 'package:flutter/material.dart';

// relative imports
import '../../screens/Category/category_info.dart';
import '../../db/db_connect.dart';

// ignore: must_be_immutable
class ExpenditureListWidget extends StatelessWidget {
  final String tag;

  ExpenditureListWidget(this.tag, {Key? key}) : super(key: key);
  final DbProvider _dbProvider = DbProvider.db;

  @override
  Widget build(BuildContext context) {
    final categoriesIn = _dbProvider.catTitlesIn;
    final categoriesOut = _dbProvider.catTitlesOut;

    return Container(
      margin: const EdgeInsets.only(top: 7),
      height: MediaQuery.of(context).size.height * .65,
      child: Container(
        height: MediaQuery.of(context).size.height * .65,
        margin: const EdgeInsets.only(top: 7.0),
        child: Row(
          children: [
            Expanded(
              child: LeftElements(
                tag,
                categoriesOut,
                categoriesIn,
              ),
            ),
            Expanded(
              child: RightElements(
                tag,
                categoriesOut,
                categoriesIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class LeftElements extends StatelessWidget {
  final String tag;
  final List categoriesOut;
  final List categoriesIn;

  const LeftElements(this.tag, this.categoriesOut, this.categoriesIn,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 28),
      child: ListView.builder(
        itemCount: tag == 'in' ? categoriesIn.length : categoriesOut.length,
        itemBuilder: (ctx, i) {
          if (i % 2 == 0) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 3),
              child: GestureDetector(
                child: Chip(
                  labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                  label: Container(
                    width: 130,
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    alignment: Alignment.center,
                    child: FittedBox(
                      child: Text(
                        tag == 'in' ? categoriesIn[i] : categoriesOut[i],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                  backgroundColor: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                  // Colors.blue[100],
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    CategoryDetails.routeName,
                    arguments: ScreenArgs(
                      tag == 'in' ? categoriesIn[i] : categoriesOut[i],
                      tag,
                    ),
                  );
                },
              ),
            );
          } else {
            return const SizedBox(height: 0);
          }
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class RightElements extends StatelessWidget {
  final String tag;
  final List categoriesOut;
  final List categoriesIn;

  const RightElements(this.tag, this.categoriesOut, this.categoriesIn,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 64),
      child: ListView.builder(
        itemCount: tag == 'in' ? categoriesIn.length : categoriesOut.length,
        itemBuilder: (ctx, i) {
          if (i % 2 != 0) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 3),
              child: GestureDetector(
                child: Chip(
                  labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                  label: Container(
                    width: 130,
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    alignment: Alignment.center,
                    child: FittedBox(
                      child: Text(
                        tag == 'in' ? categoriesIn[i] : categoriesOut[i],
                        style: const TextStyle(fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                  backgroundColor: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    CategoryDetails.routeName,
                    arguments: ScreenArgs(
                      tag == 'in' ? categoriesIn[i] : categoriesOut[i],
                      tag,
                    ),
                  );
                },
              ),
            );
          } else {
            return const SizedBox(height: 0);
          }
        },
      ),
    );
  }
}
