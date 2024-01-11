import 'package:flutter/material.dart';
import 'package:weather_test_app/common/decoration_text_form.dart';

/// Класс SearchForm - виджет текстового поля для ввода города
class SearchForm extends StatefulWidget {
  final Function(String) onSearch;
  // Обязательноый параметр onSearch это функция onSearch,
  // которая вызывается при подтверждении ввода в текстовом поле.
  const SearchForm({Key? key, required this.onSearch}) : super(key: key);

  @override
  createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  // Создается экземпляр TextEditingController с именем _cityController,
  // который используется для управления текстовым полем.
  final _cityController = TextEditingController();

  @override
  void dispose() {
    // Очищение контроллера при уничтожении виджета (dispose).
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Center(
        child: Container(
          width: 500,
          child: TextField(
            // контроллер для управления значением ввода
            controller: _cityController,
            decoration: inputDecorationTextForm().copyWith(
              hintText: 'Weather search',
            ),
            // При подтверждении ввода вызывается функция
            // widget.onSearch(city), передавая введенный город.
            onSubmitted: (String city) {
              widget.onSearch(city);
              // Очищение поля ввода после подтверждения ввода.
              _cityController.clear();
            },
          ),
        ),
      ),
    );
  }
}
