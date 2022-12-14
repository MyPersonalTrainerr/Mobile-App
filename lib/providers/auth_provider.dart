import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:my_pt/models/http_error.dart';

class Auth with ChangeNotifier {
  String _token = '';

  bool get isAuth {
    return _token != '';
  }

  Future<void> signup(String email, String username, String password) async {
    const url = 'https://mypersonal-trainer-app.herokuapp.com/register/';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          "username": username,
          "email": email,
          "password1": password,
          "password2": password,
        },
      );
      final responseData = response.body;
      if (!responseData.contains("key")) {
        _token = '';
        throw HttpError(responseData);
      } else {
        _token = responseData;
      }
      notifyListeners();
      print("TOKEN IS: $_token");
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> signIn(String email, String password) async {
    const url = 'https://mypersonal-trainer-app.herokuapp.com/login/';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          "email": email,
          "password": password,
        },
      );
      final responseData = response.body;
      if (!responseData.contains("key")) {
        _token = '';
        throw HttpError(responseData);
      } else {
        _token = responseData;
      }
      print("TOKEN IS: $_token");
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
