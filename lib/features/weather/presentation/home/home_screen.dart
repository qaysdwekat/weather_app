import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/features/weather/presentation/home/events/get_weather_info_event.dart';
import 'package:weather_app/features/weather/presentation/home/home_bloc.dart';

import '../../../../environments/config/config.dart';
import '../../../../widgets/app_image.dart';
import '../../domain/entities/weather_info_request.dart';
import 'home_state.dart';
import 'widgets/day_forecast_card.dart';
import 'widgets/main_weather_card.dart';

final GetIt sl = GetIt.instance;

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

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
      child: BlocConsumer<HomeBloc, HomeState>(
          listener: (c, s) {},
          builder: (c, s) {
            return buildScreen(c, s);
          }),
    );
  }

  Widget buildScreen(BuildContext context, HomeState state) {
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Friday',
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
        padding: const EdgeInsets.only(
          top: 128.0,
          right: 12,
          left: 12,
          bottom: 12,
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: MainWeatherCard(
                weather: state.weatherInfo?.current,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 72,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                    itemCount: state.weatherInfo?.daily?.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final day = state.weatherInfo?.daily?[index];
                      return DayForecastCard(
                        title: 'Fri',
                        description: '20 - 25 \u2103',
                        // '20 \u2109',
                        // '20 / 25 \u2103',
                        icon: AppImage(
                          imageUrl: Config().openweathermapImageUrl?.replaceAll('{icon}', '01d') ?? '',
                          placeholderWidget: Icon(
                            Icons.wb_sunny_rounded,
                            color: Colors.white,
                            size: width * 0.14,
                          ),
                          width: width * 0.14,
                        ),
                        isEmpty: day?.isEmpty == true,
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
