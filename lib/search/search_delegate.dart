import 'package:cinelatino/model/search.dart';
import 'package:cinelatino/repository/repository.dart';
import 'package:cinelatino/screens/search_screen.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  MovieRepository movieRepository = new MovieRepository();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro Appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del Appbar
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder<List<PeliculasSearch>>(
      future: movieRepository.buscarPelicula(query),
      builder: (BuildContext context,
          AsyncSnapshot<List<PeliculasSearch>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;

          return ListView(
            children: peliculas.map((pelicula) {
              return ListTile(
                leading: Image(
                  image: NetworkImage((pelicula.posterPath != null)
                      ? ("https://image.tmdb.org/t/p/w300/" +
                          pelicula.posterPath)
                      : "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRIvKqBwu4OsBFfTsP1qRyzAuqeKqjX-ZJP6w&usqp=CAU"),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(movie: pelicula),
                    ),
                  );
                },
              );
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder<List<PeliculasSearch>>(
      future: movieRepository.buscarPelicula(query),
      builder: (BuildContext context,
          AsyncSnapshot<List<PeliculasSearch>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;

          return ListView(
            children: peliculas.map((pelicula) {
              return ListTile(
                leading: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage((pelicula.posterPath != null)
                      ? ("https://image.tmdb.org/t/p/w300/" +
                          pelicula.posterPath)
                      : "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRIvKqBwu4OsBFfTsP1qRyzAuqeKqjX-ZJP6w&usqp=CAU"),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(movie: pelicula),
                    ),
                  );
                },
              );
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
