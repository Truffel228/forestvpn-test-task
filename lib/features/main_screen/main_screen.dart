import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forestvpn_test/features/main_screen/bloc/main_bloc.dart';
import 'package:forestvpn_test/features/main_screen/widgets/carousel.dart';
import 'package:forestvpn_test/features/main_screen/widgets/latest_articles_item.dart';
import 'package:forestvpn_test/repositories/news/abstract_news_repository.dart';
import 'package:forestvpn_test/repositories/news/models/article.dart';
import 'package:forestvpn_test/routes.dart';

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
          backgroundColor: const Color(0xFFE5E5E5),
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
                  SliverAppBar(
                    backgroundColor: const Color(0xFFE5E5E5),
                    leading: Align(
                      alignment: Alignment.centerLeft,
                      child: UnconstrainedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: InkWell(
                            onTap: () => Platform.isAndroid
                                ? SystemNavigator.pop()
                                : exit(0),
                            child: SvgPicture.asset(
                              'assets/icons/arrow_back.svg',
                              height: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: const Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    centerTitle: true,
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Center(
                          child: InkWell(
                            onTap: () => context
                                .read<MainBloc>()
                                .add(MainReadAllEvent()),
                            child: const Text(
                              'Mark all read',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 28),
                          child: Text(
                            'Featured',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Carousel(
                            articles: state.mainPageState.featuredArticles),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.only(left: 28),
                          child: Text(
                            'Latest news',
                            style: TextStyle(
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
