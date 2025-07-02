import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/utils/constants.dart';
import '../models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login(String email, String password);
  Future<AuthModel> register({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl({required this.apiService});

  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      final response = await apiService.post(
        ApiConstants.loginEndpoint,
        body: {
          'email': email,
          'password': password,
        },
      );

      return AuthModel.fromJson(response['data']);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }
  @override
  Future<AuthModel> register({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final response = await apiService.post(
        ApiConstants.registerEndpoint,
        body: {
          'name': name,
          'email': email,
          'phone_number': phoneNumber,
          'password': password,
          'password_confirmation': password,
          'role_id': 2,
        },
      );

      return AuthModel.fromJson(response['data']);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }
}