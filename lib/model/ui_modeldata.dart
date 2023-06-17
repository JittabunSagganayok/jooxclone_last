import 'package:jooxclone_jittabun/data/dataforui.dart';

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
  final String uri1;
  final String title1;
  final String displaySubtitle1;
  final String artist1;
  final String artUri1;
  final String image1;

  final String uri2;
  final String title2;
  final String displaySubtitle2;
  final String artist2;
  final String artUri2;
  final String image2;

  final String uri3;
  final String title3;
  final String displaySubtitle3;
  final String artist3;
  final String artUri3;
  final String image3;

  SuggestData({
    required this.uri1,
    required this.title1,
    required this.displaySubtitle1,
    required this.artist1,
    required this.artUri1,
    required this.image1,
    required this.uri2,
    required this.title2,
    required this.displaySubtitle2,
    required this.artist2,
    required this.artUri2,
    required this.image2,
    required this.uri3,
    required this.title3,
    required this.displaySubtitle3,
    required this.artist3,
    required this.artUri3,
    required this.image3,
    // required this.title1,
    // required this.title2,
    // required this.title3,
    // required this.artist1,
    // required this.artist2,
    // required this.artist3,
    // required this.image1,
    // required this.image2,
    // required this.image3,
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
      // title1: data['title1'],
      // title2: data['title2'],
      // title3: data['title3'],
      // artist1: data['artist1'],
      // artist2: data['artist2'],
      // artist3: data['artist3'],
      // image1: data['image1'],
      // image2: data['image2'],
      // image3: data['image3'],
      uri1: data['uri1'],
      title1: data['title1'],
      displaySubtitle1: data['displaySubtitle1'],
      artist1: data['artist1'],
      artUri1: data['artUri1'],
      image1: data['image1'],

      uri2: data['uri2'],
      title2: data['title2'],
      displaySubtitle2: data['displaySubtitle2'],
      artist2: data['artist2'],
      artUri2: data['artUri2'],
      image2: data['image2'],

      uri3: data['uri3'],
      title3: data['title3'],
      displaySubtitle3: data['displaySubtitle3'],
      artist3: data['artist3'],
      artUri3: data['artUri3'],
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
