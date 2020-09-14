import 'package:cinelatino/search/search_delegate.dart';
import 'package:cinelatino/widgets/best_movies.dart';
import 'package:cinelatino/widgets/genres.dart';
import 'package:cinelatino/widgets/now_playing.dart';
import 'package:cinelatino/widgets/persons.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:cinelatino/style/theme.dart' as Style;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,
        leading: Icon(
          EvaIcons.menu2Outline,
          color: Colors.white,
        ),
        title: Text("Cine Latino"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: DataSearch()
                );
              },
              icon: Icon(
                EvaIcons.searchOutline,
                color: Colors.white,
              ))
        ],
      ),
      body: ListView(
        children: <Widget>[
          NowPlaying(),
          GenresScreen(),
          PersonsList(),
          BestMovies(),
        ],
      ),
    );
  }
}
