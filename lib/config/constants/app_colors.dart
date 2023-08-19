import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final class AppColors {
  static const Color primary = Color(0xff00BF63);
  static const Color grey = Colors.grey;
}

void toast({required String msg, bool isError = false}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: isError ? Colors.red : AppColors.primary,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

class StatusType {
  static const schedule = 'schedule';
  static const complete = 'complete';
  static const missed = 'missed';
}
