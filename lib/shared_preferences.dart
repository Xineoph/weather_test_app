import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
//переменная для сохранения preferences
  static SharedPreferences? _preferences;

//ключ для текстового поля
  final _keyUserEmail = 'userEmail';
  final _keyUserPassword = 'userPassword';
  final _keyUserRePassword = 'userRePassword';

//инициализация preferences
  Future init() async => _preferences = await SharedPreferences.getInstance();

//задаем значения ключам
  Future setUserEmail(String userEmail) async =>
      await _preferences?.setString(_keyUserEmail, userEmail);
  Future setUserPassword(String userPassword) async =>
      await _preferences?.setString(_keyUserPassword, userPassword);
  Future setUserRePassword(String userRePassword) async =>
      await _preferences?.setString(_keyUserRePassword, userRePassword);

//читаем значения
  String? getUserEmail() => _preferences?.getString(_keyUserEmail);
  String? getUserPassword() => _preferences?.getString(_keyUserPassword);
  String? getUserRePassword() => _preferences?.getString(_keyUserRePassword);

//удаляем значения
  Future<bool>? deleteUserEmail() => _preferences?.remove(_keyUserEmail);
  Future<bool>? deleteUserPassword() => _preferences?.remove(_keyUserPassword);
  Future<bool>? deleteUserRePassword() =>
      _preferences?.remove(_keyUserRePassword);
}
