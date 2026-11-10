import 'package:go_router/go_router.dart';

import 'features/auth/domain/usecases/user_login.dart';
import 'features/auth/presentation/screens/login_page.dart';
import 'features/home/presentation/screens/home_page.dart';

GoRouter createAppRouter({required UserLogin userLogin}) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: 'login',
            builder: (context, state) => LoginPage(userLogin: userLogin),
          ),
        ],
      ),
    ],
  );
}
