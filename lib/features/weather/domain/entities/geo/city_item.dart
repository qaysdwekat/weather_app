import 'package:equatable/equatable.dart';

class CityItem extends Equatable {
  final String? latitude;
  final String? longitude;
  final String? name;
  final bool isEmpty;

  const CityItem({
    required this.latitude,
    required this.longitude,
    required this.name,
    this.isEmpty = false,
  });

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        name,
        isEmpty,
      ];

  factory CityItem.empty() => CityItem(
        latitude: null,
        longitude: null,
        name: null,
        isEmpty: true,
      );
}
