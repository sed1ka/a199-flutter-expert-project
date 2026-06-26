import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:tv/presentation/pages/home_tv_page.dart';
import 'package:watchlist/presentation/watchlist_page.dart';

class CustomDrawer extends StatelessWidget {
  final String currentRoute;

  const CustomDrawer({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(AppAssets.logo),
              backgroundColor: Colors.grey.shade900,
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
            ),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Movies'),
            selected: currentRoute == HomeMoviePage.ROUTE_NAME,
            onTap: () {
              if (currentRoute == HomeMoviePage.ROUTE_NAME) {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacementNamed(context, HomeMoviePage.ROUTE_NAME);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('TV Series'),
            selected: currentRoute == HomeTvPage.ROUTE_NAME,
            onTap: () {
              if (currentRoute == HomeTvPage.ROUTE_NAME) {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacementNamed(context, HomeTvPage.ROUTE_NAME);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text('Watchlist'),
            selected: currentRoute == WatchlistPage.ROUTE_NAME,
            onTap: () {
              Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
            },
            selected: currentRoute == AboutPage.ROUTE_NAME,
            leading: Icon(Icons.info_outline),
            title: Text('About'),
          ),
        ],
      ),
    );
  }
}
