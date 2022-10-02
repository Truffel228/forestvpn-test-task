part of 'main_bloc.dart';

@immutable
abstract class MainState {
  const MainState(this.mainPageState);
  final MainPageState mainPageState;
}

class MainMainState extends MainState {
  const MainMainState(MainPageState mainPageState) : super(mainPageState);
}
