import 'package:jooxclone_jittabun/data/dataforplaylist.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class PositionData {
  const PositionData(
    this.position,
    this.bufferedPosition,
    this.duration,
  );
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}

class AudioData {
  final String uri;
  final MediaItem mediaItem;

  AudioData({required this.uri, required this.mediaItem});
}

//นำ list data จากไฟล์ data มาแปลงให้อ้างอิง model : class AudioData
List<AudioData> getAudioData() {
  return dataforaudio.map((data) {
    return AudioData(
      uri: data['uri'],
      mediaItem: MediaItem(
        id: data['id'],
        title: data['title'],
        displaySubtitle: data['displaySubtitle'],
        artist: data['artist'],
        //displayDescription: displayDescription,
        artUri: Uri.parse(data['artUri']),
      ),
    );
  }).toList();
}

//นำ list จาก getAudioData มาแปลงให้เป็นformat ConcatenatingAudioSource
class AudioModel {
  static ConcatenatingAudioSource getPlaylist() {
    //ทำ list จาก getAudioData ให้เป็น List<AudioSource> audioSources เพื่อใส่ใน ConcatenatingAudioSource
    final List<AudioData> audioDataList = getAudioData();
    final List<AudioSource> audioSources = audioDataList.map((audioData) {
      return AudioSource.uri(
        Uri.parse(audioData.uri),
        tag: audioData.mediaItem,
      );
    }).toList();

    return ConcatenatingAudioSource(children: audioSources);
  }
}

//อันเดิมที่ใช้ได้

// class AudioModel {
//   static ConcatenatingAudioSource getPlaylist() {
//     return ConcatenatingAudioSource(
//       children: [
//         AudioSource.uri(
//           Uri.parse('asset:///assets/audio/cupid.mp3'),
//           tag: MediaItem(
//             id: '0',
//             title: 'Cupid',
//             displaySubtitle: '0xffFFC0CB',
//             artist: 'FiftyFifty',
//             displayDescription: 'description1',
//             artUri: Uri.parse('https://img.pic.in.th/cupid.jpeg'),
//           ),
//         ),
//         AudioSource.uri(
//           Uri.parse('asset:///assets/audio/nightdancer.mp3'),
//           tag: MediaItem(
//             id: '1',
//             title: 'Night Dancer',
//             artist: 'Imase',
//             artUri: Uri.parse('https://img.pic.in.th/nightdancer.jpeg'),
//           ),
//         ),
//       ],
//     );
//   }
// }

//1.ทำไฟล์ data สำหรับ AudioSource.uri
//2. ทำ model แล้ว ทำ method get มาใช้ในไฟลนี้
