import 'package:flutter/material.dart';

const MaterialColor neoprimary =
    MaterialColor(_neoprimaryPrimaryValue, <int, Color>{
  50: Color(0xFFE5ECFC),
  100: Color(0xFFBFCFF8),
  200: Color(0xFF95B0F3),
  300: Color(0xFF6A90EE),
  400: Color(0xFF4A78EA),
  500: Color(_neoprimaryPrimaryValue),
  600: Color(0xFF2558E3),
  700: Color(0xFF1F4EDF),
  800: Color(0xFF1944DB),
  900: Color(0xFF0F33D5),
});

const int _neoprimaryPrimaryValue = 0xFF2A60E6;

const MaterialColor neoprimaryAccent =
    MaterialColor(_neoprimaryAccentValue, <int, Color>{
  100: Color(0xFFFFFFFF),
  200: Color(_neoprimaryAccentValue),
  400: Color(0xFF9CAAFF),
  700: Color(0xFF8295FF),
});

const int _neoprimaryAccentValue = 0xFFCFD6FF;
