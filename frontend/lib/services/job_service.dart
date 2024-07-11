import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thozhil_flutter_app/util/user_preferences.dart';
import '../model/job.model.dart';
import '../config.dart';
import '../util/applications.dart';

class JobService {
  static Future<List<Job>> getAllJobs(List<String> filters) async {
    http.Response response;

    if (filters.isNotEmpty) {
      var url = '${baseUrl}alljobs?role=${filters[0].toLowerCase()}&skill=${filters[1].toLowerCase()}&location=${filters[2].toLowerCase()}&salary=${filters[3]}'.replaceAll(" ", "+");
      response = await http.get(Uri.parse(url));
    } else {
      response = await http.get(Uri.parse('${baseUrl}alljobs'));
    }

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['jobs'];
      List<Job> jobs = data.map((json) => Job.fromJson(json)).toList();

      return jobs;
    } else {
      throw Exception('failed to load jobs');
    }
  }

  static Future<bool> applyJob(String jobID) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${UserPreferences.getToken()}'
    };
    var request = http.Request('POST', Uri.parse('${baseUrl}apply'));
    request.body = json.encode({
      "jobId": jobID
    });
    request.headers.addAll(headers);

    var response = await request.send();

    if (response.statusCode == 201) {
      return true;
    }

    return false;
  }

  static void getApplications() async {
    var response = await http.get(
        Uri.parse('${baseUrl}dashboard'),
        headers: {'Authorization': 'Bearer ${UserPreferences.getToken()}'},
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      var applications = Applications(
          applied: jsonResponse['applied'],
          pending: jsonResponse['pending'],
          rejected: jsonResponse['rejected'],
          accepted: jsonResponse['accepted']
      );

      UserPreferences.setApplied(jsonResponse['applied']);
      UserPreferences.setPending(jsonResponse['pending']);
      UserPreferences.setRejected(jsonResponse['rejected']);
      UserPreferences.setApproved(jsonResponse['accepted']);
    }
  }
}
