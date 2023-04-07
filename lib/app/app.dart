import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_app/features/account/providers/account_provider.dart';
import 'package:smart_home_app/features/auth/providers/auth_provider.dart';
import 'package:smart_home_app/features/auth/providers/forgot_password_provider.dart';
import 'package:smart_home_app/features/auth/providers/login_provider.dart';
import 'package:smart_home_app/features/auth/providers/register_provider.dart';
import 'package:smart_home_app/utils/router/router.dart';

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  MyApp._internal();
  int appState = 0;
  static final MyApp instance = MyApp._internal();

  factory MyApp() => instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        ChangeNotifierProvider.value(
          value: LoginProvider(),
        ),
        ChangeNotifierProvider.value(
          value: RegisterProvider(),
        ),
        ChangeNotifierProvider.value(
          value: AccountProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ForgotPasswordProvider(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.boardingRoute,
      ),
    );
  }
}
