import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medisync/config/config.dart';
import 'package:medisync/feature/presentation/cubit/cubit.dart';
import 'package:medisync/feature/presentation/pages/pages.dart';

import 'widgets/lang_item_widget.dart';

class LangPage extends StatelessWidget {
  const LangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.primary,
            gradient: LinearGradient(
              colors: [Color(0xff00bf63), Color(0xff009d8e)],
              stops: [0.1, 0.9],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Choose",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "your language",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 265,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.3,
                    shrinkWrap: true,
                    children: [
                      LangItemWidget(
                        onTap: () {
                          context.read<LangCubit>().changeLanguage('ky');
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                            (route) => false,
                          );
                        },
                        imgPath: 'assets/icons/ky.png',
                        langTitle: 'Кыргызча',
                      ),
                      LangItemWidget(
                        onTap: () {
                          context.read<LangCubit>().changeLanguage('en');
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                            (route) => false,
                          );
                        },
                        imgPath: 'assets/icons/en.png',
                        langTitle: 'English',
                      ),
                      LangItemWidget(
                        onTap: () {
                          context.read<LangCubit>().changeLanguage('ru');
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                            (route) => false,
                          );
                        },
                        imgPath: 'assets/icons/ru.png',
                        langTitle: 'Русский',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
