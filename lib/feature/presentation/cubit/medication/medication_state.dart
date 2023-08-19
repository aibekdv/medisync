part of 'medication_cubit.dart';

abstract class MedicationState extends Equatable {
  const MedicationState();

  @override
  List<Object> get props => [];
}

class MedicationInitial extends MedicationState {}

class MedicationLoading extends MedicationState {}

class MedicationLoaded extends MedicationState {
  final List<MedicationModel> medications;

  const MedicationLoaded(this.medications);
}

class MedicationError extends MedicationState {
  final String errorMessage;

  const MedicationError(this.errorMessage);
}
