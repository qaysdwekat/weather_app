import 'package:flutter/material.dart';

import '../../../../../widgets/base_loading_card.dart';

part 'day_forecast_loading.dart';

class DayForecastCard extends StatelessWidget {
  final String title;
  final Widget icon;
  final bool isEmpty;
  final String description;

  const DayForecastCard({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
    this.isEmpty = false,
  });

  @override
  Widget build(BuildContext context) {
    return isEmpty
        ? DayForecastLoading()
        : Container(
            margin: EdgeInsets.only(right: 12),
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
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                icon,
                Text(
                  description,
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
