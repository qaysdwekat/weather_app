part of '../weather_screen.dart';

class PortraitWeatherScreen extends StatelessWidget {
  final DayWeatherItem? currentWeather;
  final List<DayWeatherItem>? daily;
  final String unitSymbol;
  final Function(DayWeatherItem) onTap;

  const PortraitWeatherScreen({
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
      padding: EdgeInsets.only(
        top: Platform.isIOS ? 68 : 24.0,
        right: 12,
        left: 12,
        bottom: 12,
      ),
      child: CustomScrollView(
        slivers: [
          if (currentWeather?.dateTime != null)
            SliverToBoxAdapter(
              child: Text(
                currentWeather?.dateTime != null
                    ? DateTimeUtil.getStringFromDate(currentWeather!.dateTime!, DateTimeFormatConstants.day)
                    : '',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 24,
                      color: const Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w600,
                    ),
              ),
            )
          else
            SliverToBoxAdapter(child: SizedBox(height: 40)),
          SliverToBoxAdapter(
            child: MainWeatherCard(
              weather: currentWeather,
              width: min(size.height, size.width) * 0.45,
              unitSymbol: unitSymbol,
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
                    return InkWell(
                      onTap: () {
                        if (day != null) onTap.call(day);
                      },
                      child: DayForecastCard(
                        day: day,
                        margin: EdgeInsets.only(right: 12),
                        width: size.width * 0.14,
                        unitSymbol: unitSymbol,
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
