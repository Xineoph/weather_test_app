import 'package:flutter/material.dart';
import 'package:weather_test_app/common/colors.dart';
import 'package:weather_test_app/common/routes.dart';
import 'package:weather_test_app/common/spacers.dart';
import 'package:weather_test_app/common/text_styles.dart';
import 'package:weather_test_app/helpers/preferences/shared_preferences.dart';
import 'package:weather_test_app/ui/widgets/button_widget.dart';
import 'package:weather_test_app/ui/widgets/common_text_widgets.dart';
import 'package:weather_test_app/common/decoration_text_form.dart';

/// Страница регистрации пользователя
///
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String _email;
  late String _password;
  late String _rePassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Переменная для хранения состояния видимости пароля в форме регистрации
  bool _showPassword = false;
  bool _isPressed = false;

  /// Читаем сахраненные данные пользователя
  @override
  void initState() {
    super.initState();
    _email = UserPreferences().getUserEmail() ?? '';
    _password = UserPreferences().getUserPassword() ?? '';
    _rePassword = UserPreferences().getUserRePassword() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.mainBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.only(
            top: 182,
            left: 30,
            right: 30,
            bottom: 30,
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                buildEmailText(),
                buildEmailField(),
                sizedBoxHeight25,
                buildPasswordText(),
                buildPasswordField(),
                sizedBoxHeight25,
                buildRePasswordText(),
                buildRePasswordField(),
                sizedBoxHeight50,
                buildElevatedButtonRegister(),
                sizedBoxHeight55,
                buildAlreadHaveAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Форма ввода электроного адреса пользователя
  Widget buildEmailField() {
    return TextFormField(
      // Показываем значение, сохранненное в SharedPreferences
      initialValue: '', //_email,
      decoration: inputDecorationTextForm(),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter your email address';
        }
        if (!value.contains('@') || !value.contains('.')) {
          return 'Enter a valid email address';
        }
        return null;
      },
      onChanged: (value) => setState(() => _email = value),
    );
  }

  /// Форма ввода пароля
  Widget buildPasswordField() {
    return TextFormField(
      //показываем значение, сохранненное в SharedPreferences
      initialValue: '', //_password,
      decoration: inputDecorationTextForm().copyWith(
        suffixIcon: IconButton(
          icon: Icon(
            _showPassword ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
        ),
      ),
      // Изменение видимости пароля в текстовом поле
      obscureText: !_showPassword,
      // maxLength: 10,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter a password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
      onChanged: (value) => setState(() => _password = value),
    );
  }

  /// Форма ввода подтверждения пароля
  Widget buildRePasswordField() {
    return TextFormField(
      // Показываем значение, сохранненное в SharedPreferences
      initialValue: '', //_rePassword,
      decoration: inputDecorationTextForm().copyWith(
        suffixIcon: IconButton(
          icon: Icon(
            _showPassword ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
        ),
      ),
      obscureText: !_showPassword,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Repeat the password';
        }
        if (value != _password) {
          return 'Incorrect password';
        }
        return null;
      },
      onChanged: (value) => setState(() => _rePassword = value),
    );
  }

  /// Кнопка подтверждения регистрации пользователя
  Widget buildElevatedButtonRegister() {
    return buildElevatedButton(
      'Register',
      () async {
        if (_formKey.currentState!.validate()) {
          // Показываем сообщение, если пользователь с таким email уже зарегистрирован
          final existingEmail = UserPreferences().getUserEmail();
          if (existingEmail == _email) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'User with this email is already registered',
                    style: textStyleInter16White(),
                  ),
                ),
                backgroundColor: CustomColors.redColor,
              ),
            );
          } else {
            // Если форма прошла валидацию,
            // данные пользователя сохраняются в SharedPreferences
            await UserPreferences().setUserEmail(_email);
            await UserPreferences().setUserPassword(_password);
            await UserPreferences().setUserRePassword(_rePassword);

            Navigator.pushNamed(context, Routes.main);

            // Всплывающее сообщение пользователю: регистрация завершена
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Registration completed',
                  style: textStyleInter16White(),
                ),
                backgroundColor: CustomColors.buttonColor,
              ),
            );
          }
        }
      },
    );
  }

  /// Кнопка перехода на страницу авторизации пользователя
  Widget buildAlreadHaveAccountText() {
    return GestureDetector(
      onTap: () async {
        setState(() {
          _isPressed = true;
        });
        Navigator.pushNamed(context, Routes.login);
      },
      child: Center(
        child: Text(
          'ALREADY HAVE EN ACCOUNT',
          style: _isPressed ? textStyleInter16Green() : textStyleInter16Black(),
        ),
      ),
    );
  }
}
