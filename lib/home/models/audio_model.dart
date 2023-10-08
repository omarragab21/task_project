// To parse this JSON data, do
//
//     final audioModel = audioModelFromJson(jsonString);

import 'dart:convert';

AudioModel audioModelFromJson(String str) => AudioModel.fromJson(json.decode(str));

String audioModelToJson(AudioModel data) => json.encode(data.toJson());

class AudioModel {
  List<AudioFile>? audioFiles;

  AudioModel({
    this.audioFiles,
  });

  factory AudioModel.fromJson(Map<String, dynamic> json) => AudioModel(
        audioFiles: json["audio_files"] == null
            ? []
            : List<AudioFile>.from(json["audio_files"]!.map((x) => AudioFile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "audio_files":
            audioFiles == null ? [] : List<dynamic>.from(audioFiles!.map((x) => x.toJson())),
      };
}

class AudioFile {
  int? id;
  int? chapterId;
  double? fileSize;
  Format? format;
  String? audioUrl;

  AudioFile({
    this.id,
    this.chapterId,
    this.fileSize,
    this.format,
    this.audioUrl,
  });

  factory AudioFile.fromJson(Map<String, dynamic> json) => AudioFile(
        id: json["id"],
        chapterId: json["chapter_id"],
        fileSize: json["file_size"],
        format: formatValues.map[json["format"]]!,
        audioUrl: json["audio_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chapter_id": chapterId,
        "file_size": fileSize,
        "format": formatValues.reverse[format],
        "audio_url": audioUrl,
      };
}

enum Format { MP3 }

final formatValues = EnumValues({"mp3": Format.MP3});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
