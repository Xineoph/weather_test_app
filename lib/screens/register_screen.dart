import 'package:flutter/material.dart';
import 'package:weather_test_app/screens/login_screen.dart';
import 'package:weather_test_app/screens/weather_result_screen.dart';
import 'package:weather_test_app/shared_preferences.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  String? _email;
  String? _password;
  String? _rePassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPassword =
      false; // переменная для хранения состояния видимости пароля в форме регистрации

  //читаем данные пользователя
  @override
  void initState() {
    super.initState();
    _email = UserPreferences().getUserEmail() ?? '';
    _password = UserPreferences().getUserPassword() ?? '';
    _rePassword = UserPreferences().getUserRePassword() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5),
      ),
      alignment: Alignment.center,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildEmailText(),
              buildEmailField(),
              const SizedBox(
                height: 25,
              ),
              buildPasswordText(),
              buildPasswordField(),
              const SizedBox(
                height: 25,
              ),
              buildRePasswordText(),
              buildRePasswordField(),
              const SizedBox(
                height: 50,
              ),
              buildElevatedButtonRegister(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmailText() {
    return const Text(
      'Email',
      style: TextStyle(
        fontFamily: 'Inter-SemiBold',
        fontSize: 16,
        color: Color(0xFF000000),
      ),
    );
  }

  Widget buildEmailField() {
    return TextFormField(
      initialValue: _email,
      decoration: const InputDecoration(
        border: InputBorder.none,
        fillColor: Color(0xFFD9D9D9),
        filled: true,
        //hintText: 'example@mail.com',
        hintStyle: TextStyle(
          fontFamily: 'Inter-SemiBold',
          fontSize: 16,
          color: Color(0xFF000000),
        ),
      ),
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

  Widget buildPasswordText() {
    return const Text(
      'Password',
      style: TextStyle(
        fontFamily: 'Inter-SemiBold',
        fontSize: 16,
        color: Color(0xFF000000),
      ),
    );
  }

  Widget buildPasswordField() {
    return TextFormField(
      initialValue:
          _password, //хранит значение, сохранненное в SharedPreferences
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: const Color(0xFFD9D9D9),
        filled: true,
        //hintText: '******',
        hintStyle: const TextStyle(
          fontFamily: 'Inter-SemiBold',
          fontSize: 16,
          color: Color(0xFF000000),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _showPassword ? Icons.visibility : Icons.visibility_off,
          ), //изменение отображения пароля в текстовом поле
          onPressed: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
        ),
      ),
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

  Widget buildRePasswordText() {
    return const Text(
      'RePassword',
      style: TextStyle(
        fontFamily: 'Inter-SemiBold',
        fontSize: 16,
        color: Color(0xFF000000),
      ),
    );
  }

  Widget buildRePasswordField() {
    return TextFormField(
      initialValue: _rePassword,
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: const Color(0xFFD9D9D9),
        filled: true,
        //hintText: '******',
        hintStyle: const TextStyle(
          fontFamily: 'Inter-SemiBold',
          fontSize: 16,
          color: Color(0xFF000000),
        ),
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
        if (_password != null && value != _password) {
          return 'Incorrect password';
        }
        return null;
      },
      onChanged: (value) => setState(() => _rePassword = value),
    );
  }

  Widget buildElevatedButtonRegister() {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await UserPreferences().setUserEmail(_email!);
            await UserPreferences().setUserPassword(_password!);
            await UserPreferences().setUserRePassword(_rePassword!);
            // если форма прошла валидацию,
            //данные пользователя сохраняются в SharedPreferences
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Registration completed'),
                backgroundColor: Color(0xFF17E444),
              ),
            ); //всплывающее сообщение пользователю: регистрация завершена
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return const WeatherWidget();
              }),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF17E444),
          fixedSize: const Size(184, 40),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        child: const Text(
          'Register',
          style: TextStyle(
            fontFamily: 'Inter-SemiBold',
            color: Color(0xFF1A1717),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
