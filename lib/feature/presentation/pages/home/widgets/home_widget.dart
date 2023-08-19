import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medisync/config/config.dart';
import 'package:medisync/feature/domain/entities/medication_entity.dart';
import 'package:medisync/feature/presentation/cubit/lang/lang_cubit.dart';
import 'package:medisync/feature/presentation/pages/pages.dart';
import 'package:medisync/feature/presentation/widgets/widgets.dart';
import 'package:medisync/generated/l10n.dart';

class HomeWidget extends StatefulWidget {
  final List<MedicationEntity> medications;
  final bool isLoading;

  const HomeWidget({
    super.key,
    required this.medications,
    required this.isLoading,
  });

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String langCode = '';

  @override
  Widget build(BuildContext context) {
    langCode = Localizations.localeOf(context).languageCode;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).myMedicines,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                BlocBuilder<LangCubit, LangState>(
                  builder: (context, state) => PopupMenuButton(
                    color: Colors.white,
                    padding: const EdgeInsets.all(0),
                    enableFeedback: false,
                    shadowColor: AppColors.primary,
                    tooltip: "Language",
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                    icon: Row(
                      children: [
                        Text(
                          langCode.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          onTap: () {
                            context.read<LangCubit>().changeLanguage('ky');
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/ky.png",
                                width: 25,
                                height: 25,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "Кыргызча",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            context.read<LangCubit>().changeLanguage('ru');
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/ru.png",
                                width: 25,
                                height: 25,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "Русский",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            context.read<LangCubit>().changeLanguage('en');
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/en.png",
                                width: 25,
                                height: 25,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "English",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ];
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          if (widget.isLoading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ),
            ),
          if (widget.medications.isNotEmpty)
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  ...widget.medications.map(
                    (e) => MedicationItemWidget(
                      medicationItem: e,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(medItem: e),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          if (widget.medications.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          "assets/images/medicate.png",
                          width: 80,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        S.of(context).noDrugsFound,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ]),
              ),
            ),
        ],
      ),
    );
  }
}
