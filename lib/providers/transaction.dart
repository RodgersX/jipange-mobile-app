import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// relative imports
import '../db/db_connect.dart';
import '../models/models.dart';

class TransactionProv with ChangeNotifier {
  final DbProvider _dpProv = DbProvider.db; // instance of sqlite
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> fetchTransactions() async {
    http.Client client = http.Client();
    final User user = auth.currentUser!;
    final uid = user.uid;
    final token = await user.getIdToken();

    try {
      var res = await client.post(
        Uri.http(serverUri, '/'),
        body: {
          'token': token,
          'uid': uid,
        },
      );
      // ignore: unnecessary_null_comparison
      if (res == Null) {
        debugPrint('Something wrong with your connection!');
      }

      Map<String, dynamic> data = jsonDecode(res.body);
      var allTransactions = data['transactions'];

      for (var tx in allTransactions) {
        print(tx);
        if (tx.userId == uid) {
          _dpProv.createTransaction(Transaction.fromJson(tx));
        } else {
          debugPrint('No transactions for you');
        }
      }
    } finally {
      client.close();
    }

    notifyListeners();
  }
}
