import 'package:bloc/bloc.dart';
import 'package:forestvpn_test/features/main_screen/bloc/main_page_state.dart';
import 'package:forestvpn_test/repositories/news/abstract_news_repository.dart';
import 'package:forestvpn_test/repositories/news/models/article.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc({
    required AbstractNewsRepository newsRepository,
  })  : _newsRepository = newsRepository,
        super(
          MainMainState(
            MainPageState.initial(),
          ),
        ) {
    on<MainInitEvent>(onMainInitEvent);
    on<MainReadAllEvent>(onMainReadAllEvent);
  }

  final AbstractNewsRepository _newsRepository;

  void onMainInitEvent(event, emit) async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    final List<Article> featuredArticles =
        await _newsRepository.getFeaturedArticles();
    final List<Article> latestArticles =
        await _newsRepository.getLatestArticles();
    emit(
      MainMainState(
        state.mainPageState.copyWith(
          loading: false,
          featuredArticles: featuredArticles,
          latestArticles: latestArticles,
        ),
      ),
    );
  }

  void onMainReadAllEvent(event, emit) {
    final List<Article> readFeaturedArticles = [];
    final List<Article> readLatestArticles = [];
    for (var element in state.mainPageState.featuredArticles) {
      readFeaturedArticles.add(
        element.copyWith(readed: true),
      );
    }
    for (var element in state.mainPageState.latestArticles) {
      readLatestArticles.add(
        element.copyWith(readed: true),
      );
    }
    emit(
      MainMainState(
        state.mainPageState.copyWith(
          featuredArticles: readFeaturedArticles,
          latestArticles: readLatestArticles,
        ),
      ),
    );
  }
}
