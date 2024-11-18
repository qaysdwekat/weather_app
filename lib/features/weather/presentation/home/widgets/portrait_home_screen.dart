part of '../home_screen.dart';

class PortraitHomeScreen extends StatelessWidget {
  final DayWeatherItem? currentWeather;
  final List<DayWeatherItem>? daily;

  const PortraitHomeScreen({
    super.key,
    this.currentWeather,
    this.daily,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.only(
        top: 128.0,
        right: 12,
        left: 12,
        bottom: 12,
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              child: MainWeatherCard(
                weather: currentWeather,
                width: min(size.height, size.width) * 0.8,
              ),
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
                  itemCount: daily?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final day = daily?[index];
                    return DayForecastCard(
                      day: day,
                      margin: EdgeInsets.only(right: 12),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
