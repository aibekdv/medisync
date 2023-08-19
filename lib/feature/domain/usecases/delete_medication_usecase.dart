import 'package:medisync/feature/domain/repositories/medicate_repository.dart';

final class DeleteMedicationUseCase {
  final MedicateRepository repository;

  DeleteMedicationUseCase({required this.repository});

  Future<void> call(String id) {
    return repository.deleteMedication(medicationId: id);
  }
}
