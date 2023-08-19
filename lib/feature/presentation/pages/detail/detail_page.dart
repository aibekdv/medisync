import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medisync/config/config.dart';
import 'package:medisync/feature/domain/entities/entities.dart';
import 'package:medisync/feature/presentation/cubit/medication/medication_cubit.dart';
import 'package:medisync/feature/presentation/pages/detail/widgets/widgets.dart';
import 'package:medisync/feature/presentation/pages/pages.dart';
import 'package:medisync/generated/l10n.dart';

class DetailPage extends StatefulWidget {
  final MedicationEntity medItem;

  const DetailPage({super.key, required this.medItem});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<WeekdayEntity> weekdays = [];
  String selectedDayString = '';
  String selectedTimeString = '';

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    if (weekdays.isEmpty) {
      weekdays = [
        WeekdayEntity(id: 1, name: S.of(context).monday, checked: false),
        WeekdayEntity(id: 2, name: S.of(context).thuesday, checked: false),
        WeekdayEntity(id: 3, name: S.of(context).wednesday, checked: false),
        WeekdayEntity(id: 4, name: S.of(context).thursday, checked: false),
        WeekdayEntity(id: 5, name: S.of(context).friday, checked: false),
        WeekdayEntity(id: 6, name: S.of(context).saturday, checked: false),
        WeekdayEntity(id: 7, name: S.of(context).sunday, checked: false),
      ];
      var selectedDay = widget.medItem.selectedDays;

      for (var i = 0; i < weekdays.length; i++) {
        for (var j = 0; j < selectedDay.length; j++) {
          if (weekdays[i].id == selectedDay[j]) {
            selectedDayString += "${weekdays[i].name}. ";
          }
        }
      }

      for (var time in widget.medItem.times) {
        selectedTimeString += "${localizations.formatTimeOfDay(time)}. ";
      }

      setState(() {});
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [AppColors.primary, Color(0xffffffff)],
                stops: [0.7, 0.4],
                center: Alignment.topRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.black,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      S.of(context).aboutMedicine,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                DetailItemWidget(
                  title1: S.of(context).medicineName,
                  title2: widget.medItem.name,
                ),
                DetailItemWidget(
                  title1: S.of(context).dosage,
                  title2: widget.medItem.dosage,
                ),
                DetailItemWidget(
                  title1: S.of(context).notes,
                  title2: widget.medItem.notes,
                ),
                DetailItemWidget(
                  title1: S.of(context).days,
                  title2: selectedDayString,
                ),
                DetailItemWidget(
                  title1: S.of(context).timeOfReceipt,
                  title2: selectedTimeString,
                ),
                const SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditMedicatePage(
                                medItem: widget.medItem,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          minimumSize: Size(
                            MediaQuery.of(context).size.width / 2.3,
                            50,
                          ),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await context
                              .read<MedicationCubit>()
                              .deleteMedication(
                                widget.medItem.id,
                              );
                          // ignore: use_build_context_synchronously
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                            (route) => false,
                          );
                          //show toast
                          toast(
                            msg: S.of(context).deletedSuccessfully,
                            isError: true,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize:
                              Size(MediaQuery.of(context).size.width / 2.3, 50),
                        ),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
