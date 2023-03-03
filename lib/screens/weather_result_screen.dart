
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_test_app/data/const.dart';
import 'package:weather_test_app/data/location_sevice.dart';
import 'package:weather_test_app/data/weather_service.dart';
import 'package:weather_test_app/helpers/colors.dart';
import 'package:weather_test_app/screens/search_form.dart';
import 'package:weather_test_app/screens/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _weatherService = WeatherService();
  final _locationService = LocationService();
  String _city = '';
  String _icon = '';
  int _temp = 0;
  int _hum = 0;
  int _sunrise = 0;
  int _sunset = 0;
  String _wind = '';
  Color _color = Colors.white;
  String _desc = '';
  Position? _position;
  int _dt = 0;
  int _timezone = 0;
  

  @override
  void initState() {
    super.initState();
    _getCurrentPositionAndWeather();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: _content,
        ),
      ),
    );
  }

  Widget get _content => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SearchForm(onSearch: _changeCity),
            Text(
              _city,
              style: const TextStyle(
                fontSize: 40,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300,
                fontFamily: 'Inter',
              ),
            ),
            if (_city != "")
              weatherData(
                title: _desc,
                temperature: _temp,
                iconCode: _icon,
                humidity: _hum,
                sunrise: _sunrise,
                sunset: _sunset,
                wind: _wind,
                dt: _dt,
                timezone: _timezone,
              )
          ],
        ),
      );

  void _changeCity(String city) async {
    final dataDecoded = await _weatherService.getWeatherByName(city);
    _updateData(dataDecoded);
    setState(() {
      _city = city;
    });
  }

  Future<void> _getCurrentPositionAndWeather() async {
    await _getCurrentPosition();
    await _getCityAndWeatherFromLatLong();
  }

  Future<void> _getCurrentPosition() async {
    try {
      final position = await _locationService.getCurrentPosition();
      setState(() {
        _position = position;
      });
    } catch(e) {
      print('Current position is not available now');
      _changeCity('DUBLIN');
    }
  }

  Future<void> _getCityAndWeatherFromLatLong() async {
    if (_position == null) return;
    try {
      final place = await _locationService.getPlace(_position!);
      //get weather info
      final dataDecoded = await _weatherService.getWeatherByCoord(_position!);
      _updateData(dataDecoded);
      setState(() {
        _city = place.locality ?? '';
      });
    } catch (e) {
      print(e);
    }
  }

  void _updateData(weatherData) {
    setState(() {
      if (weatherData != null) {
        _temp = weatherData['main']['temp'].toInt();
        _hum = weatherData['main']['humidity'].toInt();
        _sunrise = weatherData['sys']['sunrise'].toInt();
        _sunset = weatherData['sys']['sunset'].toInt();
        _wind = weatherData['wind']['deg'].toString();
        _icon = weatherData['weather'][0]['icon'];
        _desc = weatherData['main']['feels_like'].toString();
        _dt = weatherData['dt'];
        _timezone = weatherData['timezone'];
        // _color = _getBackgroundColor(_icon);
      } else {
        _temp = 0;
        _city = '';
        _icon = '0';
        _hum = 0;
        _sunrise = 0;
        _sunset = 0;
      }
    });
  }

//   Color _getBackgroundColor(String icon) {
//     if (icon == Image.asset('assets/icons/sun.png')) return CustomColors.sunnyColor;
//     return Colors.white;
//   }
}
