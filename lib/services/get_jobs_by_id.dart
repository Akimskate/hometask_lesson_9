import 'package:hometask_lesson_9/endpoints_constants.dart';
import 'package:hometask_lesson_9/models/vacancies.dart';
import 'package:http/http.dart' as http;

class GetJobsByIdService {
  Future<List<Job>> getJobsById(int companyId) async {
    var url = Uri.parse(
        ApiConstants.baseUrl + '/companies' + '/$companyId' + ApiConstants.jobsEndpoint);
    var response = await http.get(url);
    
    print(url);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      List<Job> result = jobsFromJson(response.body).result;
      return result;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
