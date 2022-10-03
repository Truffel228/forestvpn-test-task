import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailedSliverAppBar extends StatelessWidget {
  const DetailedSliverAppBar({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
        background: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(12),
          ),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: const Color(0xFFE5E5E5),
            ),
            errorWidget: (context, url, error) => Container(
              color: const Color(0xFFE5E5E5),
            ),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'SF Pro Display',
            fontWeight: FontWeight.w400,
            fontSize: 28,
          ),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(12),
        ),
      ),
      shadowColor: Colors.black.withOpacity(0.4),
      elevation: 10,
      forceElevated: true,
    );
  }
}
