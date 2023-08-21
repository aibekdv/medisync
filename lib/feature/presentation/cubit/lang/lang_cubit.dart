import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:medisync/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'lang_state.dart';

class LangCubit extends Cubit<LangState> {
  final SharedPreferences prefs;
  LangCubit(this.prefs) : super(LangInitial());

  // Change language and write to cache
  changeLanguage(String code) async {
    emit(ChangeLangLoading());
    try {
      await prefs.setString("CASHED_LANG", code);
      final langCode = prefs.getString("CASHED_LANG");
      emit(ChangeLang(locale: Locale(langCode ?? "en")));
    } catch (e) {
      throw CacheException();
    }
  }

  // Get language from cache
  getCachedLanguage() {
    emit(ChangeLangLoading());
    try {
      final langCode = prefs.getString("CASHED_LANG");
      if (langCode != null) {
        emit(ChangeLang(locale: Locale(langCode)));
      }
    } catch (e) {
      throw CacheException();
    }
  }
}
