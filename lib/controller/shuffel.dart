import 'dart:math';

class Song {
  String uri;

  Song({required this.uri});
}

void shuffleSongs(List<Song> songs) {
  final random = Random();

  for (int i = songs.length - 1; i > 0; i--) {
    int randomIndex = random.nextInt(i + 1);

    Song temp = songs[i];
    songs[i] = songs[randomIndex];
    songs[randomIndex] = temp;
  }
}

List<Song> data = [
  Song(uri: 'song1.mp3'),
  Song(uri: 'song2.mp3'),
  Song(uri: 'song3.mp3'),
  // Add more songs here
];
