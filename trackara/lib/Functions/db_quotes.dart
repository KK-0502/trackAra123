import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trackara/Model/QuotesModel/quotesModel.dart';

ValueNotifier<Quotesmodel?> quotesNotify = ValueNotifier(null);

Future<void>quotesAdding(Quotesmodel value)async{
    final quotesBoxDB= await Hive.openBox<Quotesmodel>("quotes_db");
    quotesBoxDB.put("quotes", value);
    quotesNotify.value=value;
    quotesNotify.notifyListeners();
}

Future<void>quotesget()async{
  final quotesBoxDB= await Hive.openBox<Quotesmodel>("quotes_db");
  final qutoesValue = quotesBoxDB.get('userProfile');
  quotesNotify.value = qutoesValue;
  quotesNotify.notifyListeners();
}