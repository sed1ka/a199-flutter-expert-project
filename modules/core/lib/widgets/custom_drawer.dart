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
      key: const ValueKey('main_drawer'),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(
                AppAssets.logo,
                package: AppAssets.package,
              ),
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
            selected: currentRoute == HomeMoviePage.routeName,
            onTap: () {
              if (currentRoute == HomeMoviePage.routeName) {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacementNamed(context, HomeMoviePage.routeName);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('TV Series'),
            selected: currentRoute == HomeTvPage.routeName,
            onTap: () {
              if (currentRoute == HomeTvPage.routeName) {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacementNamed(context, HomeTvPage.routeName);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text('Watchlist'),
            selected: currentRoute == WatchlistPage.routeName,
            onTap: () {
              Navigator.pushNamed(context, WatchlistPage.routeName);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutPage.routeName);
            },
            selected: currentRoute == AboutPage.routeName,
            leading: Icon(Icons.info_outline),
            title: Text('About'),
          ),
        ],
      ),
    );
  }
}
