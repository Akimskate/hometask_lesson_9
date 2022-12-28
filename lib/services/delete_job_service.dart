import 'package:hometask_lesson_9/endpoints_constants.dart';
import 'package:http/http.dart' as http;

class DeleteJobService {
  Future<dynamic> deleteJob(int id) async{
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.jobsEndpoint + '/$id');
    var response = await http.delete(url);

    if (response.statusCode == 200) {
      print('succsess');
    } else {
      throw "Sorry, something wrong";
    }

  }
}