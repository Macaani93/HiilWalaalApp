import 'package:shared_preferences/shared_preferences.dart';

Future<void> _saveLoginCredentials(String email, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('email', email);
  prefs.setString('password', password);
  prefs.setBool('isLoggedIn', true); // Set isLoggedIn to true
}
