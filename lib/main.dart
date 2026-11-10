import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_router.dart';
import 'features/auth/data/database/app_database.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/user_login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final AppDatabase database = AppDatabase();
  final UserLogin userLogin = UserLogin(
    authRepository: AuthRepositoryImpl(
      authRemoteDatasource: AuthRemoteDatasourceImpl(db: database),
    ),
  );
  final GoRouter router = createAppRouter(userLogin: userLogin);

  runApp(ProviderScope(child: MyApp(router: router)));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "J' Donuts",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: router,
    );
  }
}
