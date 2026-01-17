import '../model/user_model.dart';
import 'auth_remote_datasource.dart';
import '../../../../core/storage/hive_service.dart';


class AuthRepository {
  final AuthRemoteDataSource remote;
  AuthRepository(this.remote);

  Future<UserModel> login(String email, String password) async {
    final res = await remote.login(email, password);
    final user = UserModel.fromJson(res.data);

    // Save token locally
    HiveService.saveToken(user.token);

    return user;
  }

  Future<UserModel> register(Map<String, dynamic> data) async {
    final res = await remote.register(data);
    final user = UserModel.fromJson(res.data);

    // Save token locally
    HiveService.saveToken(user.token);

    return user;
  }

  // ✅ Forget Password
  Future<void> forgetPassword(
    String email,
    String currentPassword,
    String newPassword,
  ) async {
    await remote.forgetPassword(email, currentPassword, newPassword);
  }

  void logout() {
    HiveService.clear(); // clears token
  }
}
