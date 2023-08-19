// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Your medical ally`
  String get tagline {
    return Intl.message(
      'Your medical ally',
      name: 'tagline',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get continueWithGoogle {
    return Intl.message(
      'Continue with Google',
      name: 'continueWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with your google account to access the app.`
  String get loginDescription {
    return Intl.message(
      'Sign in with your google account to access the app.',
      name: 'loginDescription',
      desc: '',
      args: [],
    );
  }

  /// `About medicine`
  String get aboutMedicine {
    return Intl.message(
      'About medicine',
      name: 'aboutMedicine',
      desc: '',
      args: [],
    );
  }

  /// `Add medicine`
  String get addMedicine {
    return Intl.message(
      'Add medicine',
      name: 'addMedicine',
      desc: '',
      args: [],
    );
  }

  /// `Medicine name`
  String get medicineName {
    return Intl.message(
      'Medicine name',
      name: 'medicineName',
      desc: '',
      args: [],
    );
  }

  /// `Dosage`
  String get dosage {
    return Intl.message(
      'Dosage',
      name: 'dosage',
      desc: '',
      args: [],
    );
  }

  /// `Time of receipt`
  String get timeOfReceipt {
    return Intl.message(
      'Time of receipt',
      name: 'timeOfReceipt',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Enter the name of the drug`
  String get enterTheNameOfTheDrug {
    return Intl.message(
      'Enter the name of the drug',
      name: 'enterTheNameOfTheDrug',
      desc: '',
      args: [],
    );
  }

  /// `Choose time`
  String get selectTime {
    return Intl.message(
      'Choose time',
      name: 'selectTime',
      desc: '',
      args: [],
    );
  }

  /// `It was time to take the medicine`
  String get itWasTimeToTakeTheMedicine {
    return Intl.message(
      'It was time to take the medicine',
      name: 'itWasTimeToTakeTheMedicine',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days {
    return Intl.message(
      'Days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `Monday`
  String get monday {
    return Intl.message(
      'Monday',
      name: 'monday',
      desc: '',
      args: [],
    );
  }

  /// `Thuesday`
  String get thuesday {
    return Intl.message(
      'Thuesday',
      name: 'thuesday',
      desc: '',
      args: [],
    );
  }

  /// `Wednesday`
  String get wednesday {
    return Intl.message(
      'Wednesday',
      name: 'wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Thursday`
  String get thursday {
    return Intl.message(
      'Thursday',
      name: 'thursday',
      desc: '',
      args: [],
    );
  }

  /// `Friday`
  String get friday {
    return Intl.message(
      'Friday',
      name: 'friday',
      desc: '',
      args: [],
    );
  }

  /// `Sunday`
  String get sunday {
    return Intl.message(
      'Sunday',
      name: 'sunday',
      desc: '',
      args: [],
    );
  }

  /// `Saturday`
  String get saturday {
    return Intl.message(
      'Saturday',
      name: 'saturday',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get thisFieldIsRequired {
    return Intl.message(
      'This field is required',
      name: 'thisFieldIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Example: 1-Monday etc.`
  String get exampleWeekDay {
    return Intl.message(
      'Example: 1-Monday etc.',
      name: 'exampleWeekDay',
      desc: '',
      args: [],
    );
  }

  /// `My medicines`
  String get myMedicines {
    return Intl.message(
      'My medicines',
      name: 'myMedicines',
      desc: '',
      args: [],
    );
  }

  /// `No medicines were found.`
  String get noDrugsFound {
    return Intl.message(
      'No medicines were found.',
      name: 'noDrugsFound',
      desc: '',
      args: [],
    );
  }

  /// `Please, enter the required informations.`
  String get pleaseEnterTheRequiredInformation {
    return Intl.message(
      'Please, enter the required informations.',
      name: 'pleaseEnterTheRequiredInformation',
      desc: '',
      args: [],
    );
  }

  /// `Please, select the time for your medicine.`
  String get pleaseSelectTheTimeForYourMedicine {
    return Intl.message(
      'Please, select the time for your medicine.',
      name: 'pleaseSelectTheTimeForYourMedicine',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Select days`
  String get selectWeekday {
    return Intl.message(
      'Select days',
      name: 'selectWeekday',
      desc: '',
      args: [],
    );
  }

  /// `MediSync is a simple and user-friendly mobile app that helps people manage their medication schedule effectively, ensuring they never miss a dose.\n\nThis application will serve as a personal assistant, sending timely medication reminders based on the user's prescribed dosage and time of administration.\n\nMediSync aims to simplify drug management by promoting treatment adherence and improving overall treatment outcomes.`
  String get aboutText {
    return Intl.message(
      'MediSync is a simple and user-friendly mobile app that helps people manage their medication schedule effectively, ensuring they never miss a dose.\n\nThis application will serve as a personal assistant, sending timely medication reminders based on the user\'s prescribed dosage and time of administration.\n\nMediSync aims to simplify drug management by promoting treatment adherence and improving overall treatment outcomes.',
      name: 'aboutText',
      desc: '',
      args: [],
    );
  }

  /// `Edit the medicine`
  String get editMedicine {
    return Intl.message(
      'Edit the medicine',
      name: 'editMedicine',
      desc: '',
      args: [],
    );
  }

  /// `Changed successfully`
  String get changedSuccessfully {
    return Intl.message(
      'Changed successfully',
      name: 'changedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Created successfully`
  String get createdSuccessfully {
    return Intl.message(
      'Created successfully',
      name: 'createdSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Deleted successfully`
  String get deletedSuccessfully {
    return Intl.message(
      'Deleted successfully',
      name: 'deletedSuccessfully',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ky'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
