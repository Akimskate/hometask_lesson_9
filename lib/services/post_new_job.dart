import 'dart:convert';
import 'package:hometask_lesson_9/endpoints_constants.dart';
import 'package:http/http.dart' as http;

class PostJobService {
  Future<dynamic> postJobs(
    String title,
    String description,
    String city,
    String companyId,
  ) async {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.jobsEndpoint);
    var response = await http.post(url,
        body: jsonEncode(<String, dynamic>{
          'title': title,
          'description': description,
          'city': city,
          'companyId': companyId,
        }),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        });


    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to post data');
    }
  }


}
