import 'package:flutter/material.dart';
import 'package:medisync/feature/domain/entities/entities.dart';

class MedicationModel extends MedicationEntity {
  MedicationModel({
    required super.id,
    required super.name,
    required super.dosage,
    required super.times,
    required super.selectedDays,
    required super.notes,
    required super.status,
  });
  factory MedicationModel.fromJson(Map<String, dynamic> json) {
    return MedicationModel(
      id: json['id'],
      dosage: json['dosage'],
      name: json['name'],
      notes: json['notes'],
      status: json['status'],
      times: (json['times'] as String).split(',').map((timeString) {
        final List<int> parts = timeString.split(':').map(int.parse).toList();
        return TimeOfDay(hour: parts[0], minute: parts[1]);
      }).toList(),
      selectedDays:
          (json['selectedDays'] as String).split(',').map(int.parse).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'dosage': dosage,
        'notes': notes,
        'status': status,
        'times': times
            .map((time) => '${time.hour}:${time.minute}')
            .toList()
            .join(','),
        'selectedDays': selectedDays.join(','),
      };
}
