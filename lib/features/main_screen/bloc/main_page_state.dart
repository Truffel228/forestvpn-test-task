// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:forestvpn_test/repositories/news/models/article.dart';

class MainPageState {
  MainPageState({
    required this.loading,
    required this.latestArticles,
    required this.featuredArticles,
  });
  factory MainPageState.initial() => MainPageState(
        loading: true,
        latestArticles: [],
        featuredArticles: [],
      );
  final bool loading;
  final List<Article> featuredArticles;
  final List<Article> latestArticles;

  MainPageState copyWith({
    bool? loading,
    List<Article>? featuredArticles,
    List<Article>? latestArticles,
  }) {
    return MainPageState(
      loading: loading ?? this.loading,
      featuredArticles: featuredArticles ?? this.featuredArticles,
      latestArticles: latestArticles ?? this.latestArticles,
    );
  }
}
