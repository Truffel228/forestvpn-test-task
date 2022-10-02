part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class MainInitEvent extends MainEvent {}

class MainReadAllEvent extends MainEvent {}
