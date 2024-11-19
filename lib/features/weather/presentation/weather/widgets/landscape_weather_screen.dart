part of '../weather_screen.dart';

class LandscapeWeatherScreen extends StatelessWidget {
  final DayWeatherItem? currentWeather;
  final List<DayWeatherItem>? daily;
  final String unitSymbol;
  final Function(DayWeatherItem) onTap;

  const LandscapeWeatherScreen({
    super.key,
    this.currentWeather,
    this.daily,
    required this.unitSymbol,
    required this.onTap,
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
      child: Column(
        children: [
          if (currentWeather?.dateTime != null)
            Text(
              currentWeather?.dateTime != null
                  ? DateTimeUtil.getStringFromDate(currentWeather!.dateTime!, DateTimeFormatConstants.day)
                  : '',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 24,
                    color: const Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w600,
                  ),
            ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: MainWeatherCard(
                    weather: currentWeather,
                    width: min(size.height, size.width) * 0.35,
                    unitSymbol: unitSymbol,
                  ),
                ),
                SizedBox(
                  width: 72,
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverList.builder(
                          itemCount: daily?.length ?? 0,
                          itemBuilder: (_, index) {
                            final day = daily?[index];
                            return InkWell(
                              onTap: () {
                                if (day != null) onTap.call(day);
                              },
                              child: DayForecastCard(
                                day: day,
                                margin: EdgeInsets.only(right: 12, left: 12, bottom: 12),
                                width: size.width * 0.1,
                                unitSymbol: unitSymbol,
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
