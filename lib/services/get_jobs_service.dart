import 'package:hometask_lesson_9/endpoints_constants.dart';
import 'package:hometask_lesson_9/models/vacancies.dart';
import 'package:http/http.dart' as http;

class GetJobsService {
  Future<List<Job>> getJobs() async {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.jobsEndpoint);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<Job> result = jobsFromJson(response.body).result;
      return result;
    } else {
      throw Exception('Failed to load data');  
    }
  }
}
