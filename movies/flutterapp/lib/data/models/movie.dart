class Movie {
  final int id;
  final String title;
  final int year;
  final List<dynamic> genre;
  final double rating;
  final String director;
  final List<dynamic> actors;
  final String plot;
  final String poster;
  final String trailer;
  final int runtime;
  final String country;
  final String language;
  final String boxOffice;
  final String production;

  final String website;

  Movie.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        year = map['year'],
        rating = map['rating'],
        director = map['director'],
        plot = map['plot'],
        poster = map['poster'],
        trailer = map['trailer'],
        runtime = map['runtime'],
        country = map['country'],
        language = map['language'],
        boxOffice = map['boxOffice'],
        production = map['production'],
        website = map['website'],
        genre = map['genre'],
        actors = map['actors'] {
    /*   for(final i in map['genre']){
          genre.add(i);

        }
         for(final i in map['actors']){
          actors.add(i);

        } */
  }
}
