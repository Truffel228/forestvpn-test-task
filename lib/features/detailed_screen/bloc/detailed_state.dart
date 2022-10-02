part of 'detailed_bloc.dart';

@immutable
abstract class DetailedState {
  const DetailedState(this.detailedPageState);
  final DetailedPageState detailedPageState;
}

class DetailedMainState extends DetailedState {
  const DetailedMainState(DetailedPageState detailedPageState)
      : super(detailedPageState);
}

class DetailedFatalErrorState extends DetailedState {
  const DetailedFatalErrorState(DetailedPageState detailedPageState)
      : super(detailedPageState);
}

class DetailedErrorState extends DetailedState {
  const DetailedErrorState(DetailedPageState detailedPageState)
      : super(detailedPageState);
}
