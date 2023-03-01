import 'package:flutter/material.dart';
import 'package:sunrise_sunset_calc/sunrise_sunset_calc.dart';

class weatherData extends StatelessWidget {
  final String title;
  final int temperature;
  final String iconCode;
  final int humidity;
  final int sunrise;
  final int sunset;
  final String wind;
  final int dt;
  final int timezone;

  weatherData({
    Key? key,
    required this.title,
    required this.temperature,
    required this.iconCode,
    required this.humidity,
    required this.sunrise,
    required this.sunset,
    required this.wind,
    required this.dt,
    required this.timezone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(45),
      child: Center(
        child: Column(
          textDirection: TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$temperature°C', 
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w300,
                  fontSize: 40
                  ),
                ),
                Image.asset('assets/icons/sun.png')
              ],
            ),
            Text('Feels like $title°C',
            style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: 0,
                  height: 80,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/icons/sunrise.png'),
                  Text('$sunrise',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                  SizedBox(
                    width: 60,
                    height: 0,
                  ),
                  Image.asset('assets/icons/sunset.png'),
                  Text('00:00',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                ],
              ),
              SizedBox(
                width: 0,
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/icons/humidity.png'),
                  Text('$humidity%',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  ),
                  SizedBox(
                    width: 45,
                    height: 0,
                  ),
                  Image.asset('assets/icons/fresh_air.png'),
                  Text('$wind',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}


  // var sunriseSunset = getSunriseSunset(60, 60, Duration(hours: 1, minutes: 1), DateTime.now());
  // final moonLanding = DateTime.parse('1969-07-20 20:18:04Z');

  //  date: new DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: false),
// DateFormat.Hm().format(weather.sunrise)