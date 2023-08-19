import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:medisync/feature/data/models/models.dart';
import 'package:medisync/feature/domain/repositories/medicate_repository.dart';

part 'medication_state.dart';

class MedicationCubit extends Cubit<MedicationState> {
  final MedicateRepository repository;

  MedicationCubit(this.repository) : super(MedicationLoading());

  loadMedications() async {
    emit(MedicationLoading());
    try {
      final medications = await repository.getAllMedications();
      emit(MedicationLoaded(medications));
    } catch (e) {
      log(e.toString());
      emit(const MedicationError('Failed to load medications'));
    }
  }

  addMedication(MedicationModel medication) async {
    try {
      await repository.addMedication(medication: medication);
      await loadMedications();
    } catch (e) {
      emit(const MedicationError('Failed to add medication'));
    }
  }

  deleteMedication(String id) async {
    try {
      await repository.deleteMedication(medicationId: id);
      await loadMedications();
    } catch (e) {
      emit(const MedicationError('Failed to delete medication'));
    }
  }

  updateMedication(String id, MedicationModel updatedMedication) async {
    try {
      await repository.updateMedication(
        medicationId: id,
        newData: updatedMedication.toJson(),
      );
      await loadMedications();
    } catch (e) {
      emit(const MedicationError('Failed to update medication'));
    }
  }
}
