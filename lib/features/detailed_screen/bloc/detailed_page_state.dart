// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:forestvpn_test/repositories/news/models/article.dart';

class DetailedPageState {
  DetailedPageState({this.article});
  final Article? article;

  factory DetailedPageState.initial() => DetailedPageState();

  DetailedPageState copyWith({
    Article? article,
  }) {
    return DetailedPageState(
      article: article ?? this.article,
    );
  }
}
