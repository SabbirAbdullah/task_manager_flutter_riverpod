
import '../../../../shared/di/storage/hive_service.dart';
import '../remote/auth_remote_datasource.dart';
import '../model/user_model.dart';


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
