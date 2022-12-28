import 'package:hometask_lesson_9/endpoints_constants.dart';
import 'package:hometask_lesson_9/models/companies.dart';
import 'package:http/http.dart' as http;

class GetCompaniesService {
  Future<List<Company>> getCompanies() async {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.companiesEndpoint);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<Company> result = companiesFromJson(response.body).result;
      return result;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
