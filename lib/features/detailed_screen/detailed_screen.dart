import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forestvpn_test/features/detailed_screen/bloc/detailed_bloc.dart';
import 'package:forestvpn_test/repositories/news/abstract_news_repository.dart';

class DetailedScreen extends StatelessWidget {
  const DetailedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    return BlocProvider(
      create: (context) => DetailedBloc(
        newsRepository: context.read<AbstractNewsRepository>(),
      )..add(
          DetailedInitEvent(args),
        ),
      child: Scaffold(
        body: BlocConsumer<DetailedBloc, DetailedState>(
          listener: (context, state) {
            if (state is DetailedFatalErrorState) {
              Fluttertoast.showToast(msg: 'Fatal Error');
              Navigator.of(context).pop();
            }
            if (state is DetailedErrorState) {
              Fluttertoast.showToast(msg: 'Error');
            }
          },
          builder: (context, state) {
            if (state.detailedPageState.article == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  leading: UnconstrainedBox(
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: SvgPicture.asset(
                        'assets/icons/arrow_back.svg',
                        height: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  expandedHeight: MediaQuery.of(context).size.height * 0.5,
                  flexibleSpace: FlexibleSpaceBar(
                    background: CachedNetworkImage(
                      imageUrl: state.detailedPageState.article!.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: const Color(0xFFE5E5E5),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: const Color(0xFFE5E5E5),
                      ),
                    ),
                    title: Text(
                      state.detailedPageState.article!.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 28,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      state.detailedPageState.article!.description ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
