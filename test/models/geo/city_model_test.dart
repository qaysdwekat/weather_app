import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/weather/domain/entities/geo/city_item.dart';
import 'package:weather_app/models/geo/city_model.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final newCityModel = CityModel(
    name: 'Berlin',
    latitude: '52.5200',
    longitude: '13.4050',
  );

  test('should be a sublclass of CityModel entity', () async {
    //asset
    expect(newCityModel, isA<CityItem>());
  });

  group("fromJson", () {
    test("should return a valid model from the JSON", () async {
      //arrange
      final Map<String, dynamic> cityJson = json.decode(fixture('city.json'));
      //act
      final result = CityModel.fromJson(cityJson);
      //assert
      expect(result, newCityModel);
    });
  });

  group('toJson', () {
    test("should return a JSON map containing the proper data", () async {
      //arrange
      final result = newCityModel.toJson();
      //assert
      final expectedMap = json.decode(fixture('city.json'));
      expect(result, expectedMap);
    });
  });
}
