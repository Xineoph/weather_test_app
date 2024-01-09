import 'package:flutter/material.dart';
import 'package:weather_test_app/common/spacers.dart';
import 'package:weather_test_app/common/text_styles.dart';
import 'package:weather_test_app/data/weather_data.dart';

class WeatherCard extends StatelessWidget {
  final WeatherData? weatherData;
  final String? imageAsset;

  const WeatherCard({Key? key, this.weatherData, this.imageAsset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${weatherData!.temperature}°C',
                  style: textStyleInter40Black(),
                ),
                sizedBoxWidth50,
                Image.asset(
                  imageAsset!,
                  height: 150,
                  width: 150,
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Feel like ${weatherData!.feelsLike} °C',
                  style: textStyleInter20Black(),
                ),
              ],
            ),
          ],
        ),
        sizedBoxHeight70,
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/icons/sunrise.png',
                      height: 45,
                      width: 45,
                    ),
                    sizedBoxWidth25,
                    Text(
                      weatherData!.getFormattedSunrise(),
                      style: textStyleInter20Black(),
                    ),
                  ],
                ),
                sizedBoxHeight50,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/icons/humidity.png',
                      height: 45,
                      width: 45,
                    ),
                    sizedBoxWidth25,
                    Text(
                      '${weatherData!.humidity}%',
                      style: textStyleInter20Black(),
                    ),
                  ],
                ),
              ],
            ),
            sizedBoxWidth50,
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/icons/sunset.png',
                      height: 45,
                      width: 45,
                    ),
                    sizedBoxWidth25,
                    Text(
                      weatherData!.getFormattedSunset(),
                      style: textStyleInter20Black(),
                    ),
                  ],
                ),
                sizedBoxHeight50,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/icons/fresh_air.png',
                      height: 45,
                      width: 45,
                    ),
                    sizedBoxWidth25,
                    Text(
                      weatherData!.getWindDirectionString(),
                      style: textStyleInter20Black(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
