import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../model/user.model.dart';

class AuthService {
  static Future<bool> registerUser(User user) async {
    var regBody = user.toJson();

    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}register'));
    request.fields.addAll(regBody);
    request.files.add(
        await http.MultipartFile.fromPath(
            'resume', user.resume!.path
        )
    );

    try {
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseBody);
      if (response.statusCode == 201) {
        print('User registered successfully!');
      } else {
        print(jsonResponse['message']);
      }
      return jsonResponse['status'];
    } catch(e) {
      print('Registration error : ${e}');
      return false;
    }
  }

  static Future<dynamic> loginUser(String email, String password) async {
    var regBody = {
      "email": email,
      "password": password
    };

    var response = await http.post(
        Uri.parse('${baseUrl}login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody)
    );

    var res = jsonDecode(response.body);

    return res;
  }
}