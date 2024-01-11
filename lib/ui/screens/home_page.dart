import 'package:flutter/material.dart';
import 'package:weather_test_app/ui/screens/login_page.dart';
import 'package:weather_test_app/ui/screens/register_page.dart';
import 'package:weather_test_app/helpers/preferences/shared_preferences.dart';

/// Страница аутентификации пользователя
///
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // переменная содержит инфу о наличии данных в SharedPreferences
  bool _hasData = true;

  // вызывается функция hasData() и ждем результат, используем метод then()
  // когда получен результат, устанавливается переменная _hasData
  // и перестраивается Scaffold
  @override
  void initState() {
    super.initState();
    hasData(_hasData).then((value) {
      setState(() {
        _hasData = value;
      });
    });
  }

// функция hasData() получает значения данных пользователя,
// проверяет их и обновляет значение переменной _hasData
// если хотя бы одно из значений null --> данных нет -->
// возвращает _hasData = false
  Future<bool> hasData(bool hasData) async {
    final email = UserPreferences().getUserEmail();
    final password = UserPreferences().getUserPassword();
    final rePassword = UserPreferences().getUserRePassword();
    return email != null && password != null && rePassword != null;
  }

  // если _hasData = true, показываем экран авторизации,
  // если _hasData = false, показываем экран регистрации
  @override
  Widget build(BuildContext context) {
    return _hasData ? const LoginScreen() : const RegisterScreen();
  }
}
