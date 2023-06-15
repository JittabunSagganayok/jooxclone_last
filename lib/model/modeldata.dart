import 'package:jooxclone_jittabun/data/data.dart';

class AlbumCard {
  final String title;
  final String description;
  final String image;

  AlbumCard({
    required this.title,
    required this.description,
    required this.image,
  });
}

class SuggestData {
  final String title1;
  final String title2;
  final String title3;
  final String artist1;
  final String artist2;
  final String artist3;
  final String image1;
  final String image2;
  final String image3;

  SuggestData({
    required this.title1,
    required this.title2,
    required this.title3,
    required this.artist1,
    required this.artist2,
    required this.artist3,
    required this.image1,
    required this.image2,
    required this.image3,
  });
}

class Artist {
  final String image;
  final String name;

  Artist({
    required this.image,
    required this.name,
  });
}

class DailyData {
  final String title;
  final String description;
  final String image;

  DailyData({
    required this.title,
    required this.description,
    required this.image,
  });
}

List<AlbumCard> getAlbumCardData() {
  return dataforalbumcard.map((data) {
    return AlbumCard(
      title: data['title'],
      description: data['description'],
      image: data['image'],
    );
  }).toList();
}

List<SuggestData> getSuggestData() {
  return dataforsuggest.map((data) {
    return SuggestData(
      title1: data['title1'],
      title2: data['title2'],
      title3: data['title3'],
      artist1: data['artist1'],
      artist2: data['artist2'],
      artist3: data['artist3'],
      image1: data['image1'],
      image2: data['image2'],
      image3: data['image3'],
    );
  }).toList();
}

List<Artist> getArtistsData() {
  return artists.map((data) {
    return Artist(
      image: data['image'],
      name: data['name'],
    );
  }).toList();
}

List<DailyData> getDailyData() {
  return datafordaily.map((data) {
    return DailyData(
      title: data['title'],
      description: data['description'],
      image: data['image'],
    );
  }).toList();
}
