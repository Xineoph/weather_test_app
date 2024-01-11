import 'package:flutter/material.dart';
import 'package:weather_test_app/common/colors.dart';
import 'package:weather_test_app/common/spacers.dart';
import 'package:weather_test_app/common/text_styles.dart';
import 'package:weather_test_app/helpers/location_sevice.dart';
import 'package:weather_test_app/data/weather_data.dart';
import 'package:weather_test_app/data/weather_service.dart';
import 'package:weather_test_app/ui/widgets/weather_card.dart';
import 'package:weather_test_app/ui/widgets/weather_search_form.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _weatherService = WeatherService();
  final _locationService = LocationService();
  String _city = '';
  WeatherData? _weatherData;
  BoxDecoration? background;
  String? imageAsset;
  Color? backgroundColor;

  @override
  void initState() {
    super.initState();
    _getCurrentPositionAndWeather();
  }

  @override
  Widget build(BuildContext context) {
    _setWeatherBackgroundAndIcon();
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 30,
              bottom: 30,
              left: 10,
              right: 10,
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Форма поиска города
                SearchForm(onSearch: _changeCity),
                sizedBoxHeight50,
                // Если искомый город не найден,
                // выдаем соответствующее сообщение пользователю
                if (_city.isNotEmpty && _weatherData == null) ...[
                  Text(
                    'Sorry, we couldn\'t find information for "$_city".\nPlease try another city.',
                    textAlign: TextAlign.center,
                    style: textStyleInter16Black(),
                  ),
                  // Название искомого города
                ] else if (_city.isNotEmpty) ...[
                  FittedBox(
                    // Название города умещается в одну строку
                    fit: BoxFit.scaleDown,
                    child: Text(
                      // Название города заглаными буквами
                      _city.toUpperCase(),
                      style: textStyleInter40Black().copyWith(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  sizedBoxHeight70,
                  // Отображение данных о погоде, полученных из API
                  if (imageAsset != null && _weatherData != null)
                    WeatherCard(
                      weatherData: _weatherData,
                      imageAsset: imageAsset,
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

// Проверяем условия погоды и устанавливаем соответствующий фон и изображение
  void _setWeatherBackgroundAndIcon() {
    if (_weatherData != null) {
      final weatherIcon = _weatherData!.weatherIcon.toLowerCase();
      if (weatherIcon.contains('clear')) {
        backgroundColor = CustomColors.sunnyBackgroundColor;
        imageAsset = 'assets/icons/sun.png';
      }
      if (weatherIcon.contains('rain')) {
        backgroundColor = CustomColors.rainyBackgroundColor;
        imageAsset = 'assets/icons/rainy.png';
      }
      if (weatherIcon.contains('snow')) {
        backgroundColor = CustomColors.snowyBackgroundColor;
        imageAsset = 'assets/icons/snowfall.png';
      }
      if (weatherIcon.contains('cloud')) {
        backgroundColor = CustomColors.cloudyBackgroundColor;
        imageAsset = 'assets/icons/clouds.png';
      }
    } else {
      // Если информация о погоде не найдена,
      // устанавливаем стандартный фон и не устанавливаем изображение
      backgroundColor = CustomColors.mainBackgroundColor;
      imageAsset = null;
    }
  }

  /// Метод вызывается при изменении города в поисковой форме.
  /// Он отправляет запрос на получение данных о погоде
  /// по заданному городу и обновляет состояние приложения.
  void _changeCity(String city) async {
    // Ожидание получения данных о погоде по заданному городу
    // с использованием метода getWeatherByName из объекта _weatherService.
    // Полученные данные декодируются и сохраняются в переменной dataDecoded.
    final dataDecoded = await _weatherService.getWeatherByName(city);
    // Вызов метода для обновления состояния приложения данными о погоде.
    _updateData(dataDecoded);
    // Обновление состояния переменной _city новым значением (название города).
    setState(() {
      _city = city;
    });
  }

  /// Вызываем два метода для получения текущего местоположения
  /// и данных о погоде по координатам
  Future<void> _getCurrentPositionAndWeather() async {
    // Ожидание получения текущего местоположения.
    await _getCurrentPosition();
    // Ожидание получения информации о местоположении
    // (название города) и данные о погоде по координатам.
    await _getCityAndWeatherFromLatLong();
  }

  /// Пытаемся полученить текущее местоположение.
  Future<void> _getCurrentPosition() async {
    try {
      // Ожидание получения текущего местоположения с использованием
      // метода getCurrentPosition из объекта _locationService.
      final position = await _locationService.getCurrentPosition();
      // Обновление состояния переменной _locationService.position
      // новым значением (текущее местоположение).
      setState(() {
        _locationService.position = position;
      });
      // В случае недоступности текущего местоположения:
    } catch (e) {
      // выводим в консоль сообщение
      print('Current position is not available now');
      // и вызываем метод для изменения города на "DUBLIN".
      _changeCity('DUBLIN');
    }
  }

  /// Пробуем получить информацию о местоположении
  /// (название города) и данные о погоде по координатам.
  Future<void> _getCityAndWeatherFromLatLong() async {
    // Проверка, что текущее местоположение доступно.
    // Если нет, то метод завершается.
    if (_locationService.position == null) return;
    try {
      // Ожидание получения информации о местоположении (название города)
      // с использованием метода getPlace из объекта _locationService.
      // Полученные данные сохраняются в переменной place.
      final place = await _locationService.getPlace(_locationService.position!);
      // Ожидание получения данных о погоде по координатам
      // с использованием метода getWeatherByCoord из объекта _weatherService.
      // Полученные данные декодируются и сохраняются в переменной dataDecoded.
      final dataDecoded =
          await _weatherService.getWeatherByCoord(_locationService.position!);
      // Вызов метода для обновления состояния приложения данными о погоде.
      _updateData(dataDecoded);
      // Обновление состояния переменной _city новым значением (название города).
      // В случае, если название города отсутствует, используется пустая строка.
      setState(() {
        _city = place.locality ?? '';
      });
    } catch (e) {
      print(e);
    }
  }

  /// Обновляем состояние приложения данными о погоде, полученными из API.
  void _updateData(weatherData) {
    setState(() {
      // Если данные о погоде не равны null, создается новый объект WeatherData
      // с использованием фабричного метода fromJson, и этот объект присваивается _weatherData.
      if (weatherData != null) {
        _weatherData = WeatherData.fromJson(weatherData);
      } else {
        // В противном случае, _weatherData устанавливается в null.
        _weatherData = null;
      }
    });
  }
}
