import 'package:flutter/material.dart';
import 'package:thozhil_flutter_app/screens/dashboard_screen.dart';
import 'package:thozhil_flutter_app/screens/login_screen.dart';
import 'package:thozhil_flutter_app/util/user_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  runApp(
    const MainApp()
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserPreferences.getLoggedIn() ? DashboardScreen() : LoginScreen()
    );
  }
}
