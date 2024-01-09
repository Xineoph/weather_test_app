import 'package:geolocator/geolocator.dart';
import 'package:weather_test_app/data/fetch_helper.dart';

/// Этот класс предоставляет методы для получения данных о погоде.
class WeatherService {
  ///  Получаем данные о погоде по текущему местоположению (координатам).
  Future<dynamic> getWeatherByCoord(Position position) async {
    // Извлечение широты и долготы из объекта Position.
    final lat = position.latitude;
    final lon = position.longitude;
    // Создание экземпляра класса FetchHelper с параметрами запроса,
    // содержащими координаты.
    FetchHelper fetchData = FetchHelper(parameters: 'lat=$lat&lon=$lon');
    // Вызов метода getWeatherData() у экземпляра FetchHelper
    // для получения данных о погоде.
    var decodedData = await fetchData.getWeatherData();
    // Возвращение раскодированных данных о погоде.
    return decodedData;
  }

  /// Получаем данные о погоде по заданному городу.
  Future<dynamic> getWeatherByName(String cityName) async {
    // Создание экземпляра класса FetchHelper с параметрами запроса,
    // содержащими название города.
    FetchHelper fetchData = FetchHelper(parameters: 'q=$cityName');
    // Вызов метода getWeatherData() у экземпляра FetchHelper
    // для получения данных о погоде.
    var decodedData = await fetchData.getWeatherData();
    // Возвращение раскодированных данных о погоде.
    return decodedData;
  }
}
