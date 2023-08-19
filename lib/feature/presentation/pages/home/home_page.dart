import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medisync/config/config.dart';
import 'package:medisync/feature/data/models/models.dart';
import 'package:medisync/feature/presentation/cubit/medication/medication_cubit.dart';
import 'package:medisync/feature/presentation/pages/home/widgets/home_widget.dart';
import 'package:medisync/feature/presentation/pages/pages.dart';
import 'package:medisync/generated/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final notificationService = NotificationService();

  List<MedicationModel>? medications;

  @override
  Widget build(BuildContext context) {
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
              BlocBuilder<MedicationCubit, MedicationState>(
                builder: (context, state) {
                  bool isLoading = false;

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
                  return HomeWidget(
                    medications: medications ?? [],
                    isLoading: isLoading,
                  );
                },
              ),
              const AboutPage(),
            ],
          ),
        ),
      ),
      // Bottom navigation bar and floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddMedicatePage(),
            ),
          );
        },
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: const Icon(
          Icons.medication,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
