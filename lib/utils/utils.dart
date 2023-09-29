
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

void catchLog({required String message, 
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  String name = '',
  Object? error,
  StackTrace? stackTrace,
}){
  developer.log(message, name: name, error: error, stackTrace: stackTrace);
}

TextStyle generalFontConfig = const TextStyle(
             fontFamily: "MyFont",
             color: Colors.white,
          );

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

double screenHeigth(BuildContext context) => MediaQuery.of(context).size.height;

class NoParams{}