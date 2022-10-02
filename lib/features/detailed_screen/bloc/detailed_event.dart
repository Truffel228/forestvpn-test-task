part of 'detailed_bloc.dart';

@immutable
abstract class DetailedEvent {
  const DetailedEvent();
}

class DetailedInitEvent extends DetailedEvent {
  const DetailedInitEvent(this.args);
  final Object? args;
}

class DetailedErrorEvent extends DetailedEvent{}
