import 'package:flutter/material.dart';
import 'package:weather_app/widgets/app_image.dart';

import '../../../../../widgets/base_loading_card.dart';
import '../../../domain/entities/day_weather_item.dart';

part 'main_weather__loading.dart';

class MainWeatherCard extends StatelessWidget {
  final DayWeatherItem? weather;

  const MainWeatherCard({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return weather?.isEmpty == true
        ? MainWeatherLoading()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Showers',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 24,
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  color: Color(0xFF104084).withOpacity(0.4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: NetworkImage('https://openweathermap.org/img/wn/01d@4x.png'),
                      width: width * 0.4,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '20',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontSize: 64,
                                  color: const Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          TextSpan(text: ' '),
                          TextSpan(
                            text: '\u2103',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontSize: 48,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  color: Color(0xFF104084).withOpacity(0.4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppImage(
                            imageUrl: 'assets/icons/pressure.svg',
                          ),
                          Text(
                            '15 hPa',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppImage(
                            imageUrl: 'assets/icons/humidity.svg',
                          ),
                          Text(
                            '64%',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppImage(
                            imageUrl: 'assets/icons/wind.svg',
                          ),
                          Text(
                            '15 KM/H',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                    ),
                    // Text('Humidity: '),
                    // Text('Wind: '),
                  ],
                ),
              ),
            ],
          );
  }
}
