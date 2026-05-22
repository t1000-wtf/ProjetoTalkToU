import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:3000',
      headers: {'Content-Type': 'application/json'},
    ),
  );

  // REGISTER
  Future<bool> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '/register',
        data: {'username': username, 'email': email, 'password': password},
      );

      print(response.data);

      return true;
    } on DioException catch (e) {
      print(e.response?.data);

      return false;
    }
  }

  // LOGIN
  Future<bool> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '/login',
        data: {'username': username, 'password': password},
      );

      print(response.data);

      return true;
    } on DioException catch (e) {
      print(e.response?.data);

      return false;
    }
  }
}
