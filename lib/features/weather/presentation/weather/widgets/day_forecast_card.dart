import 'package:flutter/material.dart';

import '../../../../../core/utils/date_time_util.dart';
import '../../../../../widgets/app_image.dart';
import '../../../../../widgets/base_loading_card.dart';
import '../../../domain/entities/weather/day_weather_item.dart';

part 'day_forecast_loading.dart';

class DayForecastCard extends StatelessWidget {
  final DayWeatherItem? day;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final String unitSymbol;
  const DayForecastCard({
    super.key,
    required this.day,
    this.margin,
    this.width,
    required this.unitSymbol,
  });

  @override
  Widget build(BuildContext context) {
    return day?.isEmpty == true
        ? DayForecastLoading(
            margin: margin,
          )
        : Container(
            margin: margin,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFFE2E2E2),
                width: 1.5, // Border width
              ),
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
              color: Color(0xFFFFFFFF).withOpacity(0.4),
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFFFFF),
                  Color(0xFFFFFFFF).withOpacity(0.7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 1.0], // Gradient stops
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  day?.dateTime != null
                      ? DateTimeUtil.getStringFromDate(
                          day!.dateTime!,
                          DateTimeFormatConstants.day,
                        )
                      : '',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                AppImage(
                  imageUrl: day?.weather?.firstOrNull?.iconUrl ?? '',
                  placeholderWidget: Icon(
                    Icons.wb_sunny_rounded,
                    color: Colors.white,
                    size: width,
                  ),
                  width: width,
                ),
                Text(
                  '${day?.minTemperature} - ${day?.maxTemperature} $unitSymbol',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          );
  }
}
