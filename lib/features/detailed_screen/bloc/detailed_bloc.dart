import 'package:bloc/bloc.dart';
import 'package:forestvpn_test/features/detailed_screen/bloc/detailed_page_state.dart';
import 'package:forestvpn_test/repositories/news/abstract_news_repository.dart';
import 'package:forestvpn_test/repositories/news/models/article.dart';
import 'package:meta/meta.dart';

part 'detailed_event.dart';
part 'detailed_state.dart';

class DetailedBloc extends Bloc<DetailedEvent, DetailedState> {
  DetailedBloc({required AbstractNewsRepository newsRepository})
      : _newsRepository = newsRepository,
        super(
          DetailedMainState(
            DetailedPageState.initial(),
          ),
        ) {
    on<DetailedInitEvent>(onDetailedInitEvent);
    on<DetailedErrorEvent>(onDetailedErrorEvent);
  }
  final AbstractNewsRepository _newsRepository;

  void onDetailedInitEvent(DetailedInitEvent event, emit) async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (event.args != null && event.args is String) {
      final Article article =
          await _newsRepository.getArticle(event.args! as String);
      emit(
        DetailedMainState(
          state.detailedPageState.copyWith(article: article),
        ),
      );
    } else {
      emit(
        DetailedFatalErrorState(state.detailedPageState),
      );
    }
  }

  void onDetailedErrorEvent(event, emit) {
    emit(
      DetailedErrorState(state.detailedPageState),
    );
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    add(DetailedErrorEvent());
    super.onError(error, stackTrace);
  }
}
