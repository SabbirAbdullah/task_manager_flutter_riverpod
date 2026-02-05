import 'package:go_router/go_router.dart';
import '../../features/auth/view/forgot_password_page.dart';
import '../../features/auth/view/login_page.dart';
import '../../features/auth/view/register_page.dart';
import '../../features/todo/view/todo_page.dart';
import '../../shared/di/storage/hive_service.dart';


final router = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final token = HiveService.getToken();
    if (token == null && state.matchedLocation != '/login' && state.matchedLocation != '/register' && state.matchedLocation != '/forgot') {
      return '/login';
    }
    return null;
  },
  routes: [
    GoRoute(path: '/login', builder: (context, state) => LoginPage()),
    GoRoute(path: '/register', builder: (context, state) => RegisterPage()),
    GoRoute(path: '/forgot', builder: (context, state) => ForgotPasswordPage()),
    GoRoute(path: '/', builder: (context, state) => TodoPage()),
  ],
);
