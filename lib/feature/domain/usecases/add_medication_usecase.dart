import 'package:medisync/feature/data/models/models.dart';
import 'package:medisync/feature/domain/repositories/medicate_repository.dart';

final class AddMedicationUseCase {
  final MedicateRepository repository;

  AddMedicationUseCase({required this.repository});

  Future<void> call(MedicationModel medication) {
    return repository.addMedication(medication: medication);
  }
}
