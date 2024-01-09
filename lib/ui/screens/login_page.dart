import 'package:flutter/material.dart';
import 'package:weather_test_app/common/colors.dart';
import 'package:weather_test_app/common/routes.dart';
import 'package:weather_test_app/common/spacers.dart';
import 'package:weather_test_app/common/text_styles.dart';
import 'package:weather_test_app/helpers/shared_preferences.dart';
import 'package:weather_test_app/ui/widgets/button_widget.dart';
import 'package:weather_test_app/ui/widgets/common_text_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _email;
  late String _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _isPressed = false;

  // автоматическоe заполнениe сохраненных данных пользователя
  @override
  void initState() {
    super.initState();
    _email = UserPreferences().getUserEmail() ?? '';
    _password = UserPreferences().getUserPassword() ?? '';
  }

  bool _checkData(String email, String password) {
    final savedEmail = UserPreferences().getUserEmail();
    final savedPassword = UserPreferences().getUserPassword();
    return email == savedEmail && password == savedPassword;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
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
                sizedBoxHeight50,
                buildElevatedButtonLogin(),
                sizedBoxHeight150,
                buildNewAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmailField() {
    return TextFormField(
      //хранит значение, сохранненное в SharedPreferences
      initialValue: _email,
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

  Widget buildPasswordField() {
    return TextFormField(
      initialValue: _password,
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
          return 'Enter a password';
        }
        if (value != _password) {
          return 'Incorrect password';
        }
        return null;
      },
      onChanged: (value) => setState(() => _password = value),
    );
  }

  Widget buildElevatedButtonLogin() {
    return buildElevatedButton(
      'Login',
      () async {
        if (_formKey.currentState!.validate()) {
          if (_checkData(_email, _password)) {
            Navigator.pushNamed(context, Routes.main);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Successful authorization'),
                backgroundColor: CustomColors.buttonColor,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Incorrect email or password'),
                backgroundColor: CustomColors.redColor,
              ),
            );
          }
        }
      },
    );
  }

  Widget buildNewAccountText() {
    return GestureDetector(
      onTap: () async {
        setState(() {
          _isPressed = true;
        });
        Navigator.pushNamed(context, Routes.register);
      },
      child: Center(
        child: Text(
          'CREATE NEW ACCOUNT',
          style: _isPressed ? textStyleInter16Green() : textStyleInter16Black(),
        ),
      ),
    );
  }
}
