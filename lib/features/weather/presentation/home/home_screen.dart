import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/utils/date_time_util.dart';
import '../../domain/entities/day_weather_item.dart';
import '../../domain/entities/weather_info_request.dart';
import 'events/get_weather_info_event.dart';
import 'events/refresh_weather_info_event.dart';
import 'home_bloc.dart';
import 'home_state.dart';
import 'widgets/day_forecast_card.dart';
import 'widgets/error_card.dart';
import 'widgets/main_weather_card.dart';

part 'widgets/landscape_home_screen.dart';
part 'widgets/portrait_home_screen.dart';

final GetIt sl = GetIt.instance;

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final RefreshController refreshController = RefreshController();

  final bloc = sl<HomeBloc>();

  @mustCallSuper
  HomeBloc onCreate(BuildContext context) {
    return bloc
      ..add(GetWeatherInfoEvent(WeatherInfoRequest(
        latitude: '49.0131',
        longitude: '8.4043',
      )));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: onCreate(context),
      child: BlocConsumer<HomeBloc, HomeState>(listener: (c, s) {
        if (s is LoadedState || s is ErrorState) {
          refreshController.refreshCompleted();
        }
      }, builder: (c, s) {
        return buildScreen(c, s);
      }),
    );
  }

  Widget buildScreen(BuildContext context, HomeState state) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          state.weatherInfo?.current?.dateTime != null
              ? DateTimeUtil.getStringFromDate(state.weatherInfo!.current!.dateTime!, DateTimeFormatConstants.day)
              : '',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 24,
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.w600,
              ),
        ),
        backgroundColor: Colors.transparent,
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
              latitude: '49.0131',
              longitude: '8.4043',
            )));
          },
          child: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              if (state is ErrorState) {
                return ErrorCard(
                    message: state.error,
                    onPressed: () {
                      bloc.add(RefreshWeatherInfoEvent(WeatherInfoRequest(
                        latitude: '49.0131',
                        longitude: '8.4043',
                      )));
                    });
              }
              switch (orientation) {
                case Orientation.portrait:
                  return PortraitHomeScreen(
                    currentWeather: state.weatherInfo?.current,
                    daily: state.weatherInfo?.daily,
                  );
                case Orientation.landscape:
                  return LandscapeHomeScreen(
                    currentWeather: state.weatherInfo?.current,
                    daily: state.weatherInfo?.daily,
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
