import 'package:flutter/material.dart';

const String transactionsTable = 'TransactionsTable';

class Transaction with ChangeNotifier {
  final int id;
  final String userId;
  final double amount;
  final String date;
  final String time;
  final String category;
  final String sourceOrRecipients;
  final String incomeOrExpense;

  Transaction({
    required this.id,
    required this.userId,
    required this.amount,
    required this.date,
    required this.category,
    required this.sourceOrRecipients,
    required this.incomeOrExpense,
    required this.time,
  });

  static Transaction fromJson(Map<String, dynamic> json) {
    return Transaction(
      amount: json['amount'],
      category: json['category'],
      time: json['time'],
      date: json['date'],
      sourceOrRecipients: json['source_or_recipients'],
      id: json['id'],
      incomeOrExpense: json['income_or_expense'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "source_or_recipients": sourceOrRecipients,
        "income_or_expense": incomeOrExpense,
        "date": date,
        "time": time,
        "amount": amount,
        "category": category,
      };
}
