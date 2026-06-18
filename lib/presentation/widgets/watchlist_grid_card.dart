import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:flutter/material.dart';

class WatchlistGridCard extends StatelessWidget {
  final Watchlist item;

  WatchlistGridCard(this.item);

  @override
  Widget build(BuildContext context) {
    final bool isMovie = item.type == 'movie';

    return InkWell(
      onTap: () {
        if (isMovie) {
          Navigator.pushNamed(
            context,
            MovieDetailPage.ROUTE_NAME,
            arguments: item.id,
          );
        } else {
          Navigator.pushNamed(
            context,
            TvDetailPage.ROUTE_NAME,
            arguments: item.id,
          );
        }
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: '$BASE_IMAGE_URL${item.posterPath}',
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title ?? '-',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kHeading6.copyWith(fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: isMovie ? Colors.blueAccent : Colors.redAccent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      isMovie ? 'MOVIE' : 'TV SERIES',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
