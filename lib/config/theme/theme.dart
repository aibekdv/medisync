import 'package:flutter/material.dart';
import 'package:medisync/config/constants/primary_color.dart';

ThemeData theme = ThemeData(
  primarySwatch: neoprimary,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: "Roboto",
  useMaterial3: true,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  ),
);
