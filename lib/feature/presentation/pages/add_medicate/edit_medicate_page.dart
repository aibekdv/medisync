import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medisync/config/config.dart';
import 'package:medisync/feature/data/models/models.dart';
import 'package:medisync/feature/domain/entities/entities.dart';
import 'package:medisync/feature/presentation/cubit/medication/medication_cubit.dart';
import 'package:medisync/feature/presentation/pages/add_medicate/widgets/widgets.dart';
import 'package:medisync/feature/presentation/pages/pages.dart';
import 'package:medisync/feature/presentation/widgets/widgets.dart';
import 'package:medisync/generated/l10n.dart';

class EditMedicatePage extends StatefulWidget {
  final MedicationEntity medItem;

  const EditMedicatePage({super.key, required this.medItem});

  @override
  State<EditMedicatePage> createState() => _EditMedicatePageState();
}

class _EditMedicatePageState extends State<EditMedicatePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  final _notesController = TextEditingController();

  List<TimeOfDay> selectedTimes = [];
  bool isSelectedTime = false;
  List<WeekdayEntity> weekdays = [];
  List<WeekdayEntity> selectedDays = [];

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.medItem.name;
    _dosageController.text = widget.medItem.dosage;
    _notesController.text = widget.medItem.notes;

    selectedTimes.addAll(widget.medItem.times);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _dosageController.dispose();
    _notesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      var selectedDaysEdit = widget.medItem.selectedDays;

      for (var i = 0; i < weekdays.length; i++) {
        for (var j = 0; j < selectedDaysEdit.length; j++) {
          if (weekdays[i].id == selectedDaysEdit[j]) {
            weekdays[i].checked = true;
            selectedDays.add(weekdays[i]);
          }
        }
      }
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          S.of(context).editMedicine,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: _createMedication,
            icon: const Icon(
              Icons.done,
              size: 28,
            ),
            color: Colors.white,
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                CustomInputWidget(
                  labelText: S.of(context).medicineName,
                  hinText: S.of(context).enterTheNameOfTheDrug,
                  controller: _nameController,
                  inputType: TextInputType.text,
                  validator: (value) =>
                      value!.isEmpty ? S.of(context).thisFieldIsRequired : null,
                ),
                const SizedBox(height: 15),
                CustomInputWidget(
                  labelText: S.of(context).dosage,
                  hinText: "mg | мг",
                  controller: _dosageController,
                  inputType: TextInputType.text,
                  validator: (value) =>
                      value!.isEmpty ? S.of(context).thisFieldIsRequired : null,
                ),
                const SizedBox(height: 15),
                CustomInputWidget(
                  labelText: S.of(context).notes,
                  isMoreText: true,
                  controller: _notesController,
                  inputType: TextInputType.text,
                  validator: (value) =>
                      value!.isEmpty ? S.of(context).thisFieldIsRequired : null,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    // Day of receipt
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  S.of(context).days,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: selectWeekdayModal,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                minimumSize: const Size(50, 30),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        if (selectedDays.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              ...selectedDays.map(
                                (e) => DayContainerWidget(
                                  onTap: () {
                                    selectedDays.remove(e);
                                    for (var i = 0; i < weekdays.length; i++) {
                                      if (e.id == weekdays[i].id) {
                                        weekdays[i].checked = false;
                                      }
                                    }
                                    setState(() {});
                                  },
                                  titleDay: e.name,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    const Divider(),
                    // Time of receipt
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.schedule,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  S.of(context).time,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: _selectTimeOfDay,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                minimumSize: const Size(50, 30),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        // Item time container widget
                        if (selectedTimes.isNotEmpty)
                          Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 10,
                            runSpacing: 13,
                            children: [
                              ...selectedTimes.map(
                                (e) => TimeContainerWidget(
                                  onTap: () {
                                    selectedTimes.remove(e);
                                    setState(() {});
                                  },
                                  timeOfDay: e,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  selectWeekdayModal() {
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(
            S.of(context).selectWeekday,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          actionsPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(S.of(context).cancel),
            ),
            TextButton(
              onPressed: _saveSelectedDays,
              child: Text(S.of(context).save),
            ),
          ],
          content: SizedBox(
              width: double.infinity,
              height: 250,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...weekdays.map(
                      (weekday) => CheckboxListTile(
                        title: Text(
                          weekday.name,
                          style: const TextStyle(color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                        activeColor: Colors.white,
                        checkColor: Colors.black,
                        value: weekday.checked,
                        contentPadding: const EdgeInsets.all(0),
                        onChanged: (newValue) {
                          weekday.checked = !weekday.checked;
                          setState(() {});
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        side: MaterialStateBorderSide.resolveWith(
                          (states) =>
                              const BorderSide(width: 1.0, color: Colors.black),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  void _saveSelectedDays() {
    Navigator.pop(context);

    setState(() {
      selectedDays.clear();
      for (var e in weekdays) {
        if (e.checked == true) {
          selectedDays.add(e);
        }
      }
    });
  }

  _selectTimeOfDay() async {
    final timeNow = await pickTime();
    if (timeNow != null) {
      selectedTimes.add(timeNow);

      setState(() {});
    } else if (selectedTimes.isNotEmpty) {
      return;
    } else {
      toast(
        // ignore: use_build_context_synchronously
        msg: S.of(context).pleaseSelectTheTimeForYourMedicine,
        isError: true,
      );
      return;
    }
  }

  Future<TimeOfDay?> pickTime() async {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  _createMedication() async {
    if (selectedTimes.isNotEmpty && selectedDays.isNotEmpty) {
      if (_formKey.currentState!.validate()) {
        // Sort selected days
        List<int> sortDays = [];
        for (var element in selectedDays) {
          sortDays.add(element.id);
        }

        // Edit medication with cubit
        context.read<MedicationCubit>().updateMedication(
              widget.medItem.id,
              MedicationModel(
                id: widget.medItem.id,
                name: _nameController.text,
                dosage: _dosageController.text,
                times: selectedTimes,
                selectedDays: sortDays,
                notes: _notesController.text,
                status: StatusType.schedule,
              ),
            );
        // And close the page
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (route) => false,
        );
        // show toast
        toast(msg: S.of(context).changedSuccessfully);
      }
    } else {
      toast(
        msg: S.of(context).pleaseEnterTheRequiredInformation,
        isError: true,
      );
    }
  }
}
