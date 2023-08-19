import 'package:medisync/feature/domain/entities/entities.dart';
import 'package:medisync/feature/domain/repositories/medicate_repository.dart';

final class GetMedicationsUseCase {
  final MedicateRepository repository;

  GetMedicationsUseCase({required this.repository});

  Future<List<MedicationEntity>> call() {
    return repository.getAllMedications();
  }
}
