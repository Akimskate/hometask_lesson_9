import 'package:hometask_lesson_9/endpoints_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostNewCompanyService {
  Future<dynamic> postNewCompany(
    String name,
    String descripltion,
    String industry,
  ) async {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.companiesEndpoint);
    var response = await http.post(url,
        body: jsonEncode(<String, dynamic>{
          "name": name,
          "description": descripltion,
          "industry": industry
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
