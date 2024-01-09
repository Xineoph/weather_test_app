import 'package:flutter/material.dart';
import 'package:weather_test_app/common/routes.dart';
import 'package:weather_test_app/ui/screens/home_page.dart';
import 'package:weather_test_app/helpers/shared_preferences.dart';
import 'package:weather_test_app/ui/screens/login_page.dart';
import 'package:weather_test_app/ui/screens/main_page.dart';
import 'package:weather_test_app/ui/screens/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Инициализация UserPreferences
  await UserPreferences().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather app',
      //theme: ThemeData(primarySwatch: Colors.grey),
      initialRoute: Routes.home,
      routes: {
        Routes.home: (_) => const MyHomePage(),
        Routes.main: (_) => const MainScreen(),
        Routes.register: (_) => const RegisterScreen(),
        Routes.login: (_) => const LoginScreen(),
      },
    );
  }
}
