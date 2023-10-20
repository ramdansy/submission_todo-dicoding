import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:submission_todo/common/app_constant.dart';
import 'package:submission_todo/common/app_text.dart';
import 'package:submission_todo/pages/login_page.dart';

void main() => initializeDateFormatting("id_ID", null)
    .then((value) => runApp(const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData.light().copyWith(
        primaryColor: AppConstant.colorsPrimary,
        textTheme: AppText.textTheme,
      ),
      home: const LoginPage(),
    );
  }
}
