import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';
import 'package:tv/presentation/pages/tv_search_page.dart';

import '../blocs/on_the_air_tv_bloc.dart';
import '../blocs/popular_tv_bloc.dart';
import '../blocs/top_rated_tv_bloc.dart';
import 'on_the_air_tv_page.dart';

class HomeTVPage extends StatefulWidget {
  static const routeName = '/home-tv';

  const HomeTVPage({super.key});

  @override
  State<HomeTVPage> createState() => _HomeTVPageState();
}

class _HomeTVPageState extends State<HomeTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<OnTheAirTVBloc>().add(FetchOnTheAirTV());
        context.read<PopularTVBloc>().add(FetchPopularTV());
        context.read<TopRatedTVBloc>().add(FetchTopRatedTV());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(currentRoute: HomeTVPage.routeName),
      appBar: AppBar(
        title: Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, TVSearchPage.routeName);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'On The Air',
                onTap: () =>
                    Navigator.pushNamed(context, OnTheAirTVPage.routeName),
              ),
              BlocBuilder<OnTheAirTVBloc, OnTheAirTVState>(
                builder: (context, state) {
                  if (state is OnTheAirTVLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is OnTheAirTVHasData) {
                    return TVListWidget(state.result, section: 'OnTheAir');
                  } else {
                    return Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTVPage.routeName),
              ),
              BlocBuilder<PopularTVBloc, PopularTVState>(
                builder: (context, state) {
                  if (state is PopularTVLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is PopularTVHasData) {
                    return TVListWidget(state.result, section: 'Popular');
                  } else {
                    return Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTVPage.routeName),
              ),
              BlocBuilder<TopRatedTVBloc, TopRatedTVState>(
                builder: (context, state) {
                  if (state is TopRatedTVLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is TopRatedTVHasData) {
                    return TVListWidget(state.result, section: 'TopRated');
                  } else {
                    return Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: kHeading6),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TVListWidget extends StatelessWidget {
  final List<TV> tvs;
  final String section;

  const TVListWidget(this.tvs, {super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Padding(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              key: Key('${section}_tv_item_$index'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TVDetailPage.routeName,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${tv.posterPath}',
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}
