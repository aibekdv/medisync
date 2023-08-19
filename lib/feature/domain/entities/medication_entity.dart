import 'package:flutter/material.dart';

class MedicationEntity {
  final String id;
  final String name;
  final String dosage;
  final List<TimeOfDay> times;
  final List<int> selectedDays;
  final String notes;
  final String status;

  MedicationEntity({
    required this.id,
    required this.status,
    required this.name,
    required this.dosage,
    required this.notes,
    required this.times,
    required this.selectedDays,
  });
}
