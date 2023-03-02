import 'package:flutter/material.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({Key? key}) : super(key: key);

  @override
  State<WeatherWidget> createState() => _WeaterWidgetState();
}

class _WeaterWidgetState extends State<WeatherWidget> {
  final _textEditingController = TextEditingController();
  //String _city = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 55,
          right: 30,
          left: 30,
          bottom: 30,
        ),
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildWeatherField(),
          ],
        ),
      ),
    );
  }

  Widget buildWeatherField() {
    return TextField(
      controller: _textEditingController,
      style: const TextStyle(
        fontFamily: 'Inter-SemiBold',
        fontSize: 16,
        color: Color(0xFF000000),
      ),
      textAlign: (TextAlign.left),
      decoration: const InputDecoration(
        border: InputBorder.none,
        fillColor: Color(0xFFD9D9D9),
        filled: true,
        hintText: 'Weather search',
        hintStyle: TextStyle(
          fontFamily: 'Inter-SemiBold',
          fontSize: 16,
          color: Color(0xFF000000),
        ),
      ),
      keyboardType: TextInputType.text,
      onSubmitted: (String value) {
        setState(() {
          //_city = value;
          _textEditingController.clear();
        });
      },
    );
  }
}
