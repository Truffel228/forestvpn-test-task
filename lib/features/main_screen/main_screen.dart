import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forestvpn_test/features/main_screen/bloc/main_bloc.dart';
import 'package:forestvpn_test/repositories/news/abstract_news_repository.dart';
import 'package:forestvpn_test/repositories/news/models/article.dart';
import 'package:forestvpn_test/routes.dart';

import 'widgets/widgets.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  List<Widget> _buildLatestArticles({
    required List<Article> latestArticles,
    required void Function(String) onItemTap,
  }) {
    final List<Widget> latestArticlesItems = List.generate(
      latestArticles.length,
      (index) => LatestArticlesItem(
        article: latestArticles[index],
        onItemTap: onItemTap,
      ),
    );
    return latestArticlesItems;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainBloc(
        newsRepository: context.read<AbstractNewsRepository>(),
      )..add(MainInitEvent()),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          backgroundColor: const Color(0xFFF9F9F9),
          body: BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              if (state.mainPageState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  const MainSliverAppBar(),
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        /// Carousel slider with title
                        Carousel(
                          articles: state.mainPageState.featuredArticles,
                          title: 'Featured',
                        ),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.only(left: 28),
                          child: Text(
                            'Latest news',
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      _buildLatestArticles(
                        latestArticles: state.mainPageState.latestArticles,
                        onItemTap: (id) => Navigator.of(context)
                            .pushNamed(Routes.deatailedScreen, arguments: id),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
