import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioplayer = AudioPlayer();
  var playindex = 0.obs;
  var isplaying = false.obs;
  var duration = ''.obs;
  var position = ''.obs;
  var max = 0.0.obs;
  var value = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }

  updatePosition() {
    audioplayer.durationStream.listen((d) {
      duration.value = d.toString().split(".")[0];
      max.value = d!.inSeconds.toDouble();
    });
    audioplayer.positionStream.listen((p) {
      position.value = p.toString().split(".")[0];
      value.value = p.inSeconds.toDouble();
    });
  }

  changeDurationToseconds(seconds) {
    var duration = Duration(seconds: seconds);
    audioplayer.seek(duration);
  }

  playSong(String? uri, index) {
    playindex.value = index;
    try {
      audioplayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      audioplayer.play();
      isplaying(true);
      updatePosition();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  void repeatCurrentSong(String? uri, index) {
    if (isplaying.value) {
      final currentSongUri =
          audioplayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));

      audioplayer.seek(Duration.zero);
      playSong(currentSongUri as String?, playindex.value);
    }
  }

  void playAllSongs(List<SongModel> songs) {
    if (songs.isNotEmpty) {
      playindex.value = 0; // Start playing from the first song
      playSong(songs[playindex.value].uri, playindex.value);
    }
  }

  shuffleSongs(List<SongModel> songs) {
    songs.shuffle();
    playindex.value = 0; // Start playing from the first shuffled song
    playSong(songs[playindex.value].uri, playindex.value);
  }

  checkPermission() async {
    var perm = await Permission.storage.request();
    if (perm.isGranted) {
    } else {
      checkPermission();
    }
  }
}
