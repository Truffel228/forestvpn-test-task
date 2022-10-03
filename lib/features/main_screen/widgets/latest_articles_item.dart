import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:forestvpn_test/repositories/news/models/article.dart';

class LatestArticlesItem extends StatelessWidget {
  const LatestArticlesItem({
    Key? key,
    required this.article,
    required this.onItemTap,
  }) : super(key: key);
  final Article article;
  final void Function(String) onItemTap;

  String _calculateDaysAgo(DateTime date) =>
      DateTime.now().difference(date).inDays.toString();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onItemTap(article.id),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: article.readed ? const Color(0xFFF5F5F5) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(2, 2),
              blurRadius: 3,
            ),
          ],
        ),
        height: 103,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: article.imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${_calculateDaysAgo(article.publicationDate)} days ago',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xFF9A9A9A),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
