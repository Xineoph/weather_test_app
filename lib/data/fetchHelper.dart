import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_test_app/data/const.dart';

class FetchHelper {
  final String baseUrl;
  final String request;
  final String parameters;

  FetchHelper({
    this.baseUrl = Consts.baseUrl,
    this.request = Consts.getWeatherRequest,
    this.parameters = '',
  });

  Future<dynamic> getData() async {
    print('Request...');
    final fullUrl = '$baseUrl$request?$parameters&appid=${Consts.openWeatherMapKey}&units=metric';
    http.Response response = await http.get(Uri.parse(fullUrl));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print('Response:\n$body');
      return body;
    } else {
      print(response.statusCode);
    }
  }
}
