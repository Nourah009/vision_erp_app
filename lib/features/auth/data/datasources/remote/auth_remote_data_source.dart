import 'package:vision_erp_app/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // final http.Client client;

  // AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> login(String email, String password) async {
    // This is a mock implementation.
    // In a real application, you would make an API call here.
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'test@test.com' && password == 'password') {
      return const UserModel(id: '1', name: 'Test User', email: 'test@test.com');
    } else {
      throw Exception('Invalid credentials');
    }
  }
}
