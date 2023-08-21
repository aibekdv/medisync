import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medisync/config/config.dart';
import 'package:medisync/feature/data/models/models.dart';
import 'package:medisync/feature/presentation/cubit/cubit.dart';
import 'package:medisync/feature/presentation/pages/pages.dart';
import 'package:medisync/feature/presentation/widgets/widgets.dart';
import 'package:medisync/generated/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final notificationService = NotificationService();

  bool deleting = false;

  String langCode = '';

  @override
  Widget build(BuildContext context) {
    langCode = Localizations.localeOf(context).languageCode;

    return Scaffold(
      // Pages
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [AppColors.primary, Color(0xffffffff)],
              stops: [0.7, 0.4],
              center: Alignment.topRight,
            ),
          ),
          child: IndexedStack(
            index: currentIndex,
            children: [
              // HomePage builder
              BlocBuilder<MedicationCubit, MedicationState>(
                builder: (context, state) {
                  bool isLoading = false;
                  List<MedicationModel> medications = [];

                  if (state is MedicationLoading) {
                    isLoading = true;
                  } else if (state is MedicationLoaded) {
                    medications = state.medications;
                    notificationService.scheduleMedicationReminders(
                      checkStatusSchedule(state.medications),
                      reminderDesc: S.of(context).itWasTimeToTakeTheMedicine,
                    );
                    isLoading = false;
                  } else if (state is MedicationError) {
                    isLoading = false;
                    return Center(
                      child: Text(state.errorMessage),
                    );
                  }
                  // HomePage
                  return SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
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
                                builder: (context, state) {
                                  return PopupMenuButton(
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
                                            context
                                                .read<LangCubit>()
                                                .changeLanguage('ky');
                                          },
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
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
                                            context
                                                .read<LangCubit>()
                                                .changeLanguage('ru');
                                          },
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
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
                                            context
                                                .read<LangCubit>()
                                                .changeLanguage('en');
                                          },
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
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
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        if (isLoading) _loadingWidget(),
                        if (medications.isNotEmpty)
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              children: [
                                ...medications.map(
                                  (e) => LongPressDraggable(
                                    data: e,
                                    onDragStarted: () =>
                                        setState(() => deleting = true),
                                    onDraggableCanceled: (_, __) =>
                                        setState(() => deleting = false),
                                    onDragEnd: (_) =>
                                        setState(() => deleting = false),
                                    feedback: Opacity(
                                      opacity: 0.8,
                                      child: MedicationItemWidget(
                                        medicationItem: e,
                                      ),
                                    ),
                                    child: MedicationItemWidget(
                                      medicationItem: e,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailPage(medItem: e),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (medications.isEmpty) _emptyMedicineWidget(context),
                      ],
                    ),
                  );
                },
              ),
              // About Page
              const AboutPage(),
            ],
          ),
        ),
      ),
      // Floating action button
      floatingActionButton: DragTarget<MedicationModel>(
        onAccept: (data) {
          context.read<MedicationCubit>().deleteMedication(data.id);
          toast(msg: S.of(context).deletedSuccessfully, isError: true);
        },
        builder: (context, _, __) => FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddMedicatePage(),
              ),
            );
          },
          backgroundColor: deleting ? Colors.red : AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: Icon(
            deleting ? Icons.delete : Icons.medication,
            color: Colors.white,
          ),
        ),
      ),
      // Floating action button location
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // Bottom navigation bar
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          onTap: (value) => setState(() => currentIndex = value),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Icon(
                  Icons.apps,
                  size: 26,
                ),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Icon(
                  Icons.apps,
                  color: AppColors.primary,
                  size: 26,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: 'About',
              icon: Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Icon(
                  CupertinoIcons.info_circle,
                  size: 30,
                ),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Icon(
                  CupertinoIcons.info_circle,
                  color: AppColors.primary,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Loading indicator
  Expanded _loadingWidget() {
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      ),
    );
  }

  // Empty widget
  Expanded _emptyMedicineWidget(BuildContext context) {
    return Expanded(
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
    );
  }
}

checkStatusSchedule(List<MedicationModel> medics) {
  List<MedicationModel> res = [];
  for (var element in medics) {
    if (element.status == StatusType.schedule) {
      res.add(element);
    }
  }
  return res;
}
