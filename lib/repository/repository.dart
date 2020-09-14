import 'package:cinelatino/model/cast_response.dart';
import 'package:cinelatino/model/genre_response.dart';
import 'package:cinelatino/model/movie_detail_response.dart';
import 'package:cinelatino/model/movie_response.dart';
import 'package:cinelatino/model/person_response.dart';
import 'package:cinelatino/model/search.dart';
import 'package:cinelatino/model/video_response.dart';
import 'package:dio/dio.dart';

int page = 0;
bool cargando = false;

class MovieRepository {
  final String apiKey = "b0da6268dbbc36f997f4c6da1367962e";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();
  var getPopularUrl = '$mainUrl/movie/top_rated';
  var getMoviesUrl  = '$mainUrl/discover/movie';
  var getPlayingUrl = '$mainUrl/movie/now_playing';
  var getGenresUrl  = "$mainUrl/genre/movie/list";
  var getPersonsUrl = "$mainUrl/trending/person/week";
  var movieUrl      = "$mainUrl/movie";
  var searchMovie   = "$mainUrl/search/movie";

  Future<List<PeliculasSearch>> buscarPelicula(String query) async {
    var params = {
      "api_key" : apiKey,
      "language": "es-ES",
      "query"   : query,
    };
      Response response = await _dio.get(searchMovie, queryParameters: params);
        final pelicula = new Search.fromJson(response.data);
        return pelicula.results;
  }

  Future<MovieResponse> getMovies() async {
    var params = {"api_key": apiKey, "language": "es-ES", "page": 1};
    try {
      Response response =
          await _dio.get(getPopularUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieResponse> getPlayingMovies() async {
    var params = {"api_key": apiKey, "language": "es-ES", "page": 1};
    try {
      Response response =
          await _dio.get(getPlayingUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<GenreResponse> getGenres() async {
    var params = {"api_key": apiKey, "language": "es-ES"};
    try {
      Response response = await _dio.get(getGenresUrl, queryParameters: params);
      return GenreResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GenreResponse.withError("$error");
    }
  }

  Future<PersonResponse> getPersons() async {
    var params = {"api_key": apiKey};
    try {
      Response response =
          await _dio.get(getPersonsUrl, queryParameters: params);
      return PersonResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PersonResponse.withError("$error");
    }
  }

  getMovieByGenre(int id) async {
    
    if (cargando) return [];
    cargando = true; 
    page++;

    var params = {
      "api_key": apiKey,
      "language": "es-ES",
      "page": page,
      "with_genres": id
    };

    try {
      cargando = false;
      Response response = await _dio.get(getMoviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieDetailResponse> getMovieDetail(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "es-ES"
    };
    try {
      Response response = await _dio.get(movieUrl + "/$id", queryParameters: params);
      return MovieDetailResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieDetailResponse.withError("$error");
    }
  }

  Future<VideoResponse> getMovieVideos(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "es-ES"
    };
    try {
      Response response = await _dio.get(movieUrl + "/$id" + "/videos", queryParameters: params);
      return VideoResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return VideoResponse.withError("$error");
    }
  }

  Future<MovieResponse> getSimilarMovies(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "es-ES"
    };
    try {
      Response response = await _dio.get(movieUrl + "/$id" + "/similar", queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<CastResponse> getCasts(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "es-ES"
    };
    try {
      Response response = await _dio.get(movieUrl + "/$id" + "/credits", queryParameters: params);
      return CastResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CastResponse.withError("$error");
    }
  }
}
