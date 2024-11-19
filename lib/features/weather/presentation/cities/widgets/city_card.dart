import 'package:flutter/material.dart';

import '../../../../../core/routes/app_navigate.dart';
import '../../../../../core/routes/route.dart';
import '../../../../../widgets/base_loading_card.dart';
import '../../../domain/entities/geo/city_item.dart';

part 'city_loading_card.dart';

class CityCard extends StatelessWidget {
  final CityItem city;
  const CityCard({
    super.key,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return city.isEmpty == true
        ? CityLoadingCard()
        : InkWell(
            onTap: () {
              AppNavigate.pushNamed(
                RouteList.weather,
                arguments: city,
              );
            },
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
                color: Color(0xFF104084).withOpacity(0.4),
              ),
              margin: EdgeInsets.only(right: 12, left: 12, bottom: 12),
              child: Text(
                city.name ?? '',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ),
          );
  }
}
