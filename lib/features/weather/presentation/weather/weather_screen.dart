import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/utils/date_time_util.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/weather/temperature_unit.dart';
import '../../../../widgets/error_card.dart';
import '../../domain/entities/geo/city_item.dart';
import '../../domain/entities/weather/day_weather_item.dart';
import '../../domain/entities/weather/weather_info_request.dart';
import 'events/get_weather_info_event.dart';
import 'events/refresh_weather_info_event.dart';
import 'weather_bloc.dart';
import 'weather_state.dart';
import 'widgets/day_forecast_card.dart';
import 'widgets/main_weather_card.dart';

part 'widgets/landscape_weather_screen.dart';
part 'widgets/portrait_weather_screen.dart';

final GetIt sl = GetIt.instance;

class WeatherScreen extends StatelessWidget {
  final CityItem city;
  WeatherScreen({
    super.key,
    required this.city,
  });

  final RefreshController refreshController = RefreshController();

  final bloc = sl<WeatherBloc>();

  @mustCallSuper
  WeatherBloc onCreate(BuildContext context) {
    return bloc
      ..add(GetWeatherInfoEvent(WeatherInfoRequest(
        latitude: city.latitude,
        longitude: city.latitude,
      )));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: onCreate(context),
      child: BlocConsumer<WeatherBloc, WeatherState>(listener: (c, s) {
        if (s is LoadedState || s is ErrorState) {
          refreshController.refreshCompleted();
        }
      }, builder: (c, s) {
        return buildScreen(c, s);
      }),
    );
  }

  Widget buildScreen(BuildContext context, WeatherState state) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                  ),
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            S.current.select_temperature,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ListTile(
                                title: Text(S.current.celsius),
                                trailing: Radio<TemperatureUnit>(
                                  value: TemperatureUnit.metric,
                                  groupValue: state.unit,
                                  onChanged: (TemperatureUnit? value) {
                                    if (value != null) {
                                      bloc.add(RefreshWeatherInfoEvent(WeatherInfoRequest(
                                        latitude: city.latitude,
                                        longitude: city.latitude,
                                        units: value,
                                      )));
                                      Navigator.pop(context);
                                    }
                                  },
                                ),
                              ),
                              ListTile(
                                title: Text(S.current.fahrenheit),
                                trailing: Radio<TemperatureUnit>(
                                  value: TemperatureUnit.standard,
                                  groupValue: state.unit,
                                  onChanged: (TemperatureUnit? value) {
                                    if (value != null) {
                                      bloc.add(RefreshWeatherInfoEvent(WeatherInfoRequest(
                                        latitude: city.latitude,
                                        longitude: city.latitude,
                                        units: value,
                                      )));
                                      Navigator.pop(context);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF29B2D0),
              Color(0xFF33AADD),
              Color(0xFF2DC8EA),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SmartRefresher(
          primary: false,
          enablePullDown: true,
          enablePullUp: false,
          header: CustomHeader(
            refreshStyle: RefreshStyle.UnFollow,
            builder: (BuildContext context, RefreshStatus? mode) {
              return Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  CircularProgressIndicator(),
                ],
              );
            },
          ),
          controller: refreshController,
          onRefresh: () {
            bloc.add(RefreshWeatherInfoEvent(WeatherInfoRequest(
              latitude: city.latitude,
              longitude: city.latitude,
              units: state.unit,
            )));
          },
          child: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              if (state is ErrorState) {
                return ErrorCard(
                    message: state.error,
                    onPressed: () {
                      bloc.add(RefreshWeatherInfoEvent(WeatherInfoRequest(
                        latitude: city.latitude,
                        longitude: city.latitude,
                      )));
                    });
              }
              switch (orientation) {
                case Orientation.portrait:
                  return PortraitWeatherScreen(
                    currentWeather: state.weatherInfo?.current,
                    daily: state.weatherInfo?.daily,
                    unitSymbol: state.unitSymbol,
                  );
                case Orientation.landscape:
                  return LandscapeWeatherScreen(
                    currentWeather: state.weatherInfo?.current,
                    daily: state.weatherInfo?.daily,
                    unitSymbol: state.unitSymbol,
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
