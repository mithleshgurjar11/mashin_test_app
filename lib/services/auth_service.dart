import '../core/api/api_client.dart';
import '../core/api/api_constants.dart';
import '../models/user_model.dart';

class AuthService {

  final ApiClient apiClient = ApiClient();

  Future signup(UserModel user) async {

    final response = await apiClient.post(
      ApiConstants.signup,
      user.toJson(),
    );

    return response.data;

  }

  Future login(String email, String password) async {

    final response = await apiClient.post(
      ApiConstants.login,
      {
        "username": email,
        "password": password
      },
    );

    return response.data;

  }

}