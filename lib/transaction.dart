import 'package:flutter/foundation.dart';

class Transaction{
  String id;
  String title;
  double amount;
  DateTime date;

  // set up the constructor, these are in key-value pairs because of the {} used.
  Transaction({required this.id, required this.title, required this.amount, required this.date});
}