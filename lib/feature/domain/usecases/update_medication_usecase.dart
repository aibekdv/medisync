import 'package:medisync/feature/domain/repositories/medicate_repository.dart';

final class UpdateMedicationUseCase {
  final MedicateRepository repository;

  UpdateMedicationUseCase({required this.repository});

  Future<void> call({
    required String id,
    required Map<String, dynamic> newData,
  }) {
    return repository.updateMedication(medicationId: id, newData: newData);
  }
}
