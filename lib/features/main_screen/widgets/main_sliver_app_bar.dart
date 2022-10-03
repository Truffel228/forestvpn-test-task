import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forestvpn_test/features/main_screen/bloc/main_bloc.dart';

class MainSliverAppBar extends StatelessWidget {
  const MainSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color(0xFFF9F9F9),
      leading: Align(
        alignment: Alignment.centerLeft,
        child: UnconstrainedBox(
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: InkWell(
              onTap: () => Platform.isAndroid ? SystemNavigator.pop() : exit(0),
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
          fontFamily: 'SF Pro Display',
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
              onTap: () => context.read<MainBloc>().add(MainReadAllEvent()),
              child: const Text(
                'Mark all read',
                style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
