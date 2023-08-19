import 'package:medisync/feature/data/models/models.dart';

abstract class MedicateRepository {
  Future<List<MedicationModel>> getAllMedications();
  Future<void> addMedication({
    required MedicationModel medication,
  });

  Future<void> deleteMedication({
    required String medicationId,
  });

  Future<void> updateMedication({
    required String medicationId,
    required Map<String, dynamic> newData,
  });
}
