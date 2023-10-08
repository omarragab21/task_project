import 'package:task_project/core/dio_services.dart';
import 'package:task_project/home/models/audio_model.dart';

class HomeApis {
  Future<AudioModel?> getAudioFormApis() async {
    DioServices dioServices = DioServices();
    AudioModel audioModel = AudioModel();
    String url = 'https://api.quran.com/api/v4/chapter_recitations/1';
    try {
      var response = await dioServices.dio.get(url);
      if (response.statusCode == 200) {
        audioModel = AudioModel.fromJson(response.data);
        return audioModel;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
