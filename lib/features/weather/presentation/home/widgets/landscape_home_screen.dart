part of '../home_screen.dart';

class LandscapeHomeScreen extends StatelessWidget {
  final DayWeatherItem? currentWeather;
  final List<DayWeatherItem>? daily;

  const LandscapeHomeScreen({
    super.key,
    this.currentWeather,
    this.daily,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        right: 48,
        left: 48,
        bottom: 16,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: MainWeatherCard(
              weather: currentWeather,
              width: min(size.height, size.width) * 0.35,
            ),
          ),
          SizedBox(
            width: 72,
          ),
          Expanded(
            child: SizedBox(
              child: ListView.builder(
                  itemCount: daily?.length ?? 0,
                  itemBuilder: (context, index) {
                    final day = daily?[index];
                    return DayForecastCard(
                      day: day,
                      margin: EdgeInsets.all(12),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
