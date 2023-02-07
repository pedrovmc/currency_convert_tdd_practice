import 'package:currency_convert_tdd_practice/app/app_widget.dart';
import 'package:currency_convert_tdd_practice/app/injections.dart';
import 'package:flutter/material.dart';

void main() {
  Injections.registerInjections();
  runApp(const AppWidget());
}
