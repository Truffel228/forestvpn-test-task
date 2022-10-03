import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:forestvpn_test/repositories/news/models/article.dart';
import 'package:forestvpn_test/routes.dart';

class Carousel extends StatelessWidget {
  const Carousel({
    Key? key,
    required this.articles,
    required this.title,
  }) : super(key: key);
  final List<Article> articles;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 28),
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w400,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 20),
        CarouselSlider.builder(
          options: CarouselOptions(
              height: MediaQuery.of(context).size.width * 0.8,
              enableInfiniteScroll: false,
              viewportFraction: 1,
              pageSnapping: true),
          itemCount: articles.length,
          itemBuilder: (context, index, realIndex) {
            return _CarouselItem(
              article: articles[index],
            );
          },
        ),
      ],
    );
  }
}

class _CarouselItem extends StatelessWidget {
  const _CarouselItem({
    Key? key,
    required this.article,
  }) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: article.imageUrl,
      imageBuilder: (context, imageProvider) => InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed(Routes.deatailedScreen, arguments: article.id),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(5, 5),
                blurRadius: 8,
              ),
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          height: MediaQuery.of(context).size.width * 0.8 - 15,
          margin: const EdgeInsets.only(left: 28, right: 28, bottom: 15),
          width: double.infinity,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 40),
                  child: Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        height: MediaQuery.of(context).size.width * 0.8 - 15,
        margin: const EdgeInsets.only(left: 28, right: 28, bottom: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
