// import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' hide Transaction;
import 'package:path/path.dart';

// relative imports
import '../models/transactions.dart';

class DbProvider {
  static Database? _database; // 'static' has only one instance

  // singleton
  static final DbProvider db = DbProvider._();
  DbProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'Jipange4.db');
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: _onCreate,
    );
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      create table if not exists $transactionsTable (
        id integer not null unique,
        user_id text,
        date text,
        time text,
        income_or_expense text,
        source_or_recipients text,
        amount double,
        category text
      )
    ''');
  }

// money in transactions
  List<Transaction> transactions = [];

  // final List<Transaction> _todaytransactions = [];

  //list of money out categories
  Set outCategories = {};

  // list of money in categories
  Set inCategories = {};

  List<String> get catTitlesOut => [...outCategories];

  List<String> get catTitlesIn => [...inCategories];

  List<Transaction> get fetchtransactions => [...transactions];

  // List<Transaction> get todayTransactions => [..._todaytransactions];

  double totalInToday = 0.0;
  double totalOutToday = 0.0;

  createTransaction(Transaction tx) async {
    try {
      final db = await database;

      // ignore: unrelated_type_equality_checks
      var res = await db!.insert(transactionsTable, tx.toJson()); // or toMap()
      debugPrint('response: ${res.toString()}');
      // debugPrint('record added to db');
      return res;
    } catch (err) {
      throw Exception(err);
    }
  }

  groupTxByCategory() {
    groupBy(transactions, (Transaction t) {
      if (t.incomeOrExpense == 'in') {
        inCategories.add(t.category);
      } else {
        outCategories.add(t.category);
      }
    });
  }

  Future<List<Transaction>> getAllTransactions() async {
    try {
      final db = await database;
      var res = await db!.query(transactionsTable, orderBy: 'id ASC');

      // ignore: unnecessary_null_comparison
      transactions = res.isNotEmpty
          ? res.map((tx) => Transaction.fromJson(tx)).toList()
          : [];

      groupTxByCategory();
      getTodayTransactions();
      // debugPrint(transactions.toString());
      return transactions;
    } catch (err) {
      throw Exception(err);
    }
  }

  getTodayTransactions() async {
    for (int i = 0; i < transactions.length; i++) {
      DateTime txDate = DateTime.parse(transactions[i].date);
      DateTime today = DateTime.now();
      var diff = today.difference(txDate).inDays;

      // var _todaytransactions = [];

      if (diff == 0) {
        // _todaytransactions.add(transactions[i]);
        if (transactions[i].incomeOrExpense == 'in') {
          totalInToday += transactions[i].amount;
        }
        if (transactions[i].incomeOrExpense == 'out') {
          totalOutToday += transactions[i].amount;
        }
      }
    }
  }

  Future close() async {
    final db = await database;
    await db!.close();
  }
}

// transactions.forEach((tx) {
    //   DateTime txDate = DateTime.parse(tx.date);
    //   DateTime today = DateTime.now();
    //   var diff = today.difference(txDate).inDays;

    //   var _todaytransactions = [];

    //   if (diff == 0) {
    //     _todaytransactions.add(tx);
    //     if (tx.incomeOrExpense == 'out') {
    //       totalOutToday += tx.amount;
    //     } else {
    //       totalInToday += tx.amount;
    //     }
    //   }
    // });