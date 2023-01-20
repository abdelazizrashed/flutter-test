import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? preferences;

Future<void> sharedPrefAuth() async {
  preferences = await SharedPreferences.getInstance();
}

Future<bool> saveUserToken(String userToken) =>
    preferences!.setString('userToken', userToken);
Future<bool> removeUserToken() => preferences!.remove('userToken');
String? getUserToken() => preferences!.getString('userToken');

Future<bool> saveUserId(int userToken) =>
    preferences!.setInt('userId', userToken);
Future<bool> removeUserId() => preferences!.remove('userId');
int? getUserId() => preferences!.getInt('userId');

Future<bool> saveName(String name) => preferences!.setString('name', name);
Future<bool> removeName() => preferences!.remove('name');
String? getName() => preferences!.getString('name');

Future<bool> saveEmail(String email) => preferences!.setString('email', email);
Future<bool> removeEmail() => preferences!.remove('email');
String? getEmail() => preferences!.getString('email');

Future<bool> saveMobile(String mobile) =>
    preferences!.setString('mobile', mobile);
Future<bool> removeMobile() => preferences!.remove('mobile');
String? getMobile() => preferences!.getString('mobile');

Future<bool> saveImage(String image) => preferences!.setString('image', image);
Future<bool> removeImage() => preferences!.remove('image');
String? getImage() => preferences!.getString('image');
