import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_test_app/data/const.dart';

/// Класс-помощник для выполнения запросов к API OpenWeatherMap
/// с предварительно установленными параметрами или параметрами по умолчанию.
class FetchHelper {
  final String baseUrl;
  final String request;
  final String openWeatherMapKey;
  final String parameters;

  FetchHelper({
    this.baseUrl = Consts.baseUrl,
    this.request = Consts.getWeatherRequest,
    this.openWeatherMapKey = Consts.openWeatherMapKey,
    this.parameters = '',
  });

  /// Метод выполняет HTTP-запрос к API OpenWeatherMap для получения данных о погоде.
  Future getWeatherData() async {
    // Вывод строки "Request..." в консоль для отслеживания начала выполнения запроса.
    print('Request...');
    // сборка полного URL для запроса
    final fullUrl =
        '$baseUrl$request?$parameters&appid=$openWeatherMapKey&units=metric';

    // Выполнение HTTP-GET-запроса по указанному URL с использованием пакета http.
    // await - выполнение программы приостанавливается до завершения запроса
    http.Response response = await http.get(Uri.parse(fullUrl));
    // проверка: статус код 200 - успешное выполнение HTTP-запроса
    if (response.statusCode == 200) {
      // Если запрос успешен, то тело ответа (переменная body),
      // полученное в виде строки, декодируется из JSON
      // в Dart-объект с помощью функции jsonDecode.
      final body = jsonDecode(response.body);
      // Тело ответа выводится в консоль для отладки или просмотра полученных данных.
      print('Response:\n$body');
      // В случае успешного выполнения запроса и получения данных,
      // метод getWeatherData возвращает объект body -
      // декодированные данные о погоде в формате Dart.
      return body;
      // Если статус код ответа не равен 200, в консоль
      // выводится статус код для отладки или обработки ошибок.
    } else {
      print(response.statusCode);
    }
  }
}
