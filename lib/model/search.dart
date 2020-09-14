// To parse this JSON data, do
//
//     final search = searchFromJson(jsonString);

import 'dart:convert';

Search searchFromJson(String str) => Search.fromJson(json.decode(str));

String searchToJson(Search data) => json.encode(data.toJson());

class Search {
    Search({
        this.page,
        this.totalResults,
        this.totalPages,
        this.results,
    });

    int page;
    int totalResults;
    int totalPages;
    List<PeliculasSearch> results;

    factory Search.fromJson(Map<String, dynamic> json) => Search(
        page: json["page"],
        totalResults: json["total_results"],
        totalPages: json["total_pages"],
        results: List<PeliculasSearch>.from(json["results"].map((x) => PeliculasSearch.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "total_results": totalResults,
        "total_pages": totalPages,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class PeliculasSearch {
    PeliculasSearch({
        this.popularity,
        this.voteCount,
        this.video,
        this.posterPath,
        this.id,
        this.adult,
        this.backdropPath,
        this.originalLanguage,
        this.originalTitle,
        this.genreIds,
        this.title,
        this.voteAverage,
        this.overview,
        this.releaseDate,
    });

    double popularity;
    int voteCount;
    bool video;
    String posterPath;
    int id;
    bool adult;
    String backdropPath;
    OriginalLanguage originalLanguage;
    String originalTitle;
    List<int> genreIds;
    String title;
    double voteAverage;
    String overview;
    String releaseDate;

    factory PeliculasSearch.fromJson(Map<String, dynamic> json) => PeliculasSearch(
        popularity: json["popularity"].toDouble(),
        voteCount: json["vote_count"],
        video: json["video"],
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
        id: json["id"],
        adult: json["adult"],
        backdropPath: json["backdrop_path"] == null ? null : json["backdrop_path"],
        originalLanguage: originalLanguageValues.map[json["original_language"]],
        originalTitle: json["original_title"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        releaseDate: json["release_date"],
    );

    Map<String, dynamic> toJson() => {
        "popularity": popularity,
        "vote_count": voteCount,
        "video": video,
        "poster_path": posterPath == null ? null : posterPath,
        "id": id,
        "adult": adult,
        "backdrop_path": backdropPath == null ? null : backdropPath,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "title": title,
        "vote_average": voteAverage,
        "overview": overview,
        "release_date": releaseDate,
    };
}

enum OriginalLanguage { ES, EN, GL, ZH }

final originalLanguageValues = EnumValues({
    "en": OriginalLanguage.EN,
    "es": OriginalLanguage.ES,
    "gl": OriginalLanguage.GL,
    "zh": OriginalLanguage.ZH
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
