import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forestvpn_test/repositories/news/repository.dart';
import 'package:forestvpn_test/routes.dart';

void main() {
  runApp(const ForestVPNTestApp());
}

class ForestVPNTestApp extends StatelessWidget {
  const ForestVPNTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AbstractNewsRepository>(
      create: (context) => MockNewsRepository(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ForestVPN test',
        initialRoute: Routes.mainScreen,
        routes: Routes.getRoutes(),
      ),
    );
  }
}
