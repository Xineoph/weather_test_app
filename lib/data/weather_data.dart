import 'package:intl/intl.dart';

// /// Класс позволяет легко создавать объекты WeatherData из данных JSON,
// /// предоставляя удобный конструктор и фабричный метод.
class WeatherData {
  final String cityName;
  final String weatherIcon;
  final int temperature;
  final int feelsLike;
  final DateTime sunrise;
  final DateTime sunset;
  final int humidity;
  final String windDirection;
  final int timezone;

  WeatherData({
    required this.cityName,
    required this.weatherIcon,
    required this.temperature,
    required this.feelsLike,
    required this.sunrise,
    required this.sunset,
    required this.humidity,
    required this.windDirection,
    required this.timezone,
  });

  /// Метод для создания экземпляра класса WeatherData
  /// на основе декодированного JSON-объекта.
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cityName: json['name'],
      weatherIcon: json['weather'][0]['main'],
      temperature: (json['main']['temp'] as num).toInt(),
      feelsLike: (json['main']['feels_like'] as num).toInt(),
      sunrise:
          _convertTimestampToDateTime(json['sys']['sunrise'], json['timezone']),
      sunset:
          _convertTimestampToDateTime(json['sys']['sunset'], json['timezone']),
      humidity: json['main']['humidity'],
      windDirection: json['wind']['deg'].toString(),
      timezone: json['timezone'],
    );
  }

  /// Преобразование временной метки в DateTime с учетом временного пояса.
  // Статический (вспомогательный) метод принадлежит не объекту класса, а самому классу,
  // поэтому не требует создания экземпляра класса для его вызова
  static DateTime _convertTimestampToDateTime(int timestamp, int timezone) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true)
        .add(Duration(seconds: timezone));
  }

  /// Форматирование времени восхода с использованием intl
  String getFormattedSunrise() {
    return DateFormat.Hm().format(sunrise);
  }

  /// Форматирование времени заката с использованием intl
  String getFormattedSunset() {
    return DateFormat.Hm().format(sunset);
  }

  /// Конвертации градусов в буквенное направление ветра
  String getWindDirectionString() {
    const List<String> directions = [
      'N',
      'NE',
      'E',
      'SE',
      'S',
      'SW',
      'W',
      'NW'
    ];
    // Получение индекса ближайшего направления ветра
    final int index = ((int.parse(windDirection) + 22.5) % 360 / 45).floor();
    // Возвращение буквенного представления направления ветра
    return directions[index];
  }
}
