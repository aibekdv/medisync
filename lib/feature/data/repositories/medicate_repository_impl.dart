import 'package:medisync/feature/data/datasources/datasources.dart';
import 'package:medisync/feature/data/models/models.dart';
import 'package:medisync/feature/domain/repositories/medicate_repository.dart';

final class MedicateRepositoryImpl implements MedicateRepository {
  final MedicationDataSource remoteDataSource;

  MedicateRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> addMedication({
    required MedicationModel medication,
  }) async =>
      await remoteDataSource.addMedication(
        medication: medication,
      );

  @override
  Future<void> deleteMedication({
    required String medicationId,
  }) async {
    return await remoteDataSource.deleteMedication(
      medicationId: medicationId,
    );
  }

  @override
  Future<void> updateMedication({
    required String medicationId,
    required Map<String, dynamic> newData,
  }) async {
    return await remoteDataSource.updateMedication(
      medicationId: medicationId,
      newData: newData,
    );
  }

  @override
  Future<List<MedicationModel>> getAllMedications() async {
    return await remoteDataSource.getAllMedications();
  }
}
