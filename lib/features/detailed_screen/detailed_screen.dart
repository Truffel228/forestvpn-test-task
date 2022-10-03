import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forestvpn_test/features/detailed_screen/bloc/detailed_bloc.dart';
import 'package:forestvpn_test/features/detailed_screen/widgets/detailed_sliver_app_bar.dart';
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
        backgroundColor: const Color(0xFFF9F9F9),
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
                DetailedSliverAppBar(
                    title: state.detailedPageState.article!.title,
                    imageUrl: state.detailedPageState.article!.imageUrl),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      state.detailedPageState.article!.description ?? '',
                      style: const TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.black),
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
