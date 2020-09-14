import 'package:cinelatino/model/movie.dart';

class MovieResponse {
  final List<Movie> movie;
  final String error;

  MovieResponse(this.movie, this.error);

  MovieResponse.fromJson(Map<String, dynamic> json)
      : movie =
            (json["results"] as List).map((i) => new Movie.fromJson(i)).toList(),
        error = "";

  MovieResponse.withError(String errorValue)
      : movie = List(),
        error = errorValue;
}