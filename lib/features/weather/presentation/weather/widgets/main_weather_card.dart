import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../widgets/app_image.dart';
import '../../../../../widgets/base_loading_card.dart';
import '../../../domain/entities/weather/day_weather_item.dart';

part 'main_weather__loading.dart';

class MainWeatherCard extends StatelessWidget {
  final DayWeatherItem? weather;
  final double? width;
  final String unitSymbol;
  const MainWeatherCard({
    super.key,
    required this.weather,
    this.width,
    required this.unitSymbol,
  });

  @override
  Widget build(BuildContext context) {
    return weather?.isEmpty == true
        ? MainWeatherLoading()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  weather?.title ?? '',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 28,
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  color: Color(0xFF104084).withOpacity(0.4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppImage(
                      imageUrl: weather?.iconUrl ?? '',
                      width: width,
                      fit: BoxFit.cover,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: weather?.temperature?.toStringAsFixed(2),
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontSize: 28,
                                  color: const Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          TextSpan(text: ' '),
                          TextSpan(
                            text: unitSymbol,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontSize: 20,
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
                            S.current.pressure(weather?.pressure ?? -1),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 14,
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
                            S.current.humidity(weather?.humidity ?? -1),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 14,
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
                            S.current.metric_wind_speed(weather?.windSpeed ?? -1),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
