import 'package:dio/dio.dart';
import 'package:sprout_contact/models/user_model.dart';

class UserService {
  static const String url = "https://reqres.in/api/users?per_page=12";
  Future<List<User>> getallUser() async {
    try {
      final Response response = await Dio().get(url);
      final List<User> users = [];
      (response.data['data'] as List<dynamic>).forEach((user) {
        users.add(User.fromJson(user));
      });
      print(users);
      return users;
    } catch (error) {
      throw Exception(error);
    }
  }
}
