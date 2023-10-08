// ignore_for_file: prefer_final_fields, unused_field, unused_local_variable

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_cache/just_audio_cache.dart';
import 'package:task_project/home/models/audio_model.dart';
import 'package:task_project/home/services/home_apis.dart';

class HomeProvider extends ChangeNotifier {
  //*Varibales
  AudioModel _audioModel = AudioModel();
  List<AudioFile> _allAudio = [];
  List<AudioFile> _favouriteAudio = [];
  bool _isAudiosLoaded = false;
  AudioPlayer _player = AudioPlayer();
  int _playAudioIndex = -1;
  int _tempIndex = -1;
  bool _isDark = false;
  bool _isArabic = false;
  bool _audioIsLoading = false;

  //*Getters
  List<AudioFile> get allAudio => _allAudio;
  List<AudioFile> get favouriteAudio => _favouriteAudio;
  bool get isAudiosLoaded => _isAudiosLoaded;
  AudioPlayer get player => _player;
  int get playAudioIndex => _playAudioIndex;
  bool get isDark => _isDark;
  bool get isArabic => _isArabic;
  //*Setters
  set isDark(bool darkBoolen) {
    _isDark = darkBoolen;
    notifyListeners();
  }

  set isArabic(bool arabicBoolen) {
    _isArabic = arabicBoolen;
    notifyListeners();
  }

  //*Functions
  Future<void> getAllAudios() async {
    _allAudio = [];
    _audioModel = (await HomeApis().getAudioFormApis())!;
    for (int index = 0; index < 4; index++) {
      _allAudio.add(_audioModel.audioFiles![index]);
    }

    _isAudiosLoaded = true;
    notifyListeners();
  }

  bool isFavouriteAudio(AudioFile audioFile) {
    bool isExited = _favouriteAudio.contains(audioFile);

    return isExited;
  }

  void addAudioFavourite(AudioFile audioFile) {
    if (_favouriteAudio.contains(audioFile)) {
      _favouriteAudio.remove(audioFile);
      _player.stop();
    } else {
      _favouriteAudio.add(audioFile);
      _player.cacheFile(url: audioFile.audioUrl!);
    }

    notifyListeners();
  }

  void playAudio(String audioUri, int index) {
    _playAudioIndex = index;
    notifyListeners();
    if (_playAudioIndex != _tempIndex) {
      _tempIndex = _playAudioIndex;

      _player.stop();
      _player.dynamicSet(url: audioUri);
      _player.play();
      notifyListeners();
    } else if (_playAudioIndex == _tempIndex) {
      if (_player.playing) {
        _player.stop();
      } else {
        _player.play();
      }
    }
    notifyListeners();
  }
}
