part of 'lang_cubit.dart';

sealed class LangState extends Equatable {
  const LangState();

  @override
  List<Object> get props => [];
}

final class LangInitial extends LangState {}

final class ChangeLangLoading extends LangState {}

final class ChangeLang extends LangState {
  final Locale locale;

  const ChangeLang({required this.locale});
}
