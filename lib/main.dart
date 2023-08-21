import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medisync/config/config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:medisync/feature/presentation/cubit/cubit.dart';
import 'package:medisync/feature/presentation/pages/pages.dart';
import 'package:medisync/service_locator.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final notificationService = NotificationService();
  await notificationService.initialize();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<LangCubit>()..getCachedLanguage(),
        ),
        BlocProvider(
          create: (context) => di.sl<MedicationCubit>()..loadMedications(),
        ),
      ],
      child: BlocBuilder<LangCubit, LangState>(
        builder: (context, state) {
          Locale? locale;

          if (state is ChangeLang) {
            locale = state.locale;
          }

          return MaterialApp(
            title: "MediSync",
            debugShowCheckedModeBanner: false,
            theme: theme,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: locale,
            home: di.sl<SharedPreferences>().getString("CASHED_LANG") == null
                ? const LangPage()
                : const HomePage(),
          );
        },
      ),
    );
  }
}
