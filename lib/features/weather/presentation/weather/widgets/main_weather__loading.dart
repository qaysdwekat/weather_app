part of 'main_weather_card.dart';

class MainWeatherLoading extends StatelessWidget with BaseLoadingCard {
  const MainWeatherLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: buildShimmer(
            context,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildContainer(
                  context,
                  height: 14,
                  width: width * 0.5,
                ),
                SizedBox(
                  height: 8,
                ),
                buildContainer(
                  context,
                  height: 14,
                  width: width * 0.25,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        buildShimmer(
          context,
          Container(
            padding: EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
              color: Color(0xFF104084).withOpacity(0.4),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 16,
                ),
                buildContainer(
                  context,
                  height: height * 0.2,
                  width: width * 0.5,
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                ),
                SizedBox(
                  height: 24,
                ),
                buildContainer(
                  context,
                  height: 16,
                  width: width * 0.5,
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 24,
        ),
        buildShimmer(
          context,
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
              color: Color(0xFF104084).withOpacity(0.4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildShimmer(
                        context,
                        AppImage(
                          imageUrl: 'assets/icons/pressure.svg',
                        ),
                      ),
                      buildShimmer(
                        context,
                        buildContainer(
                          context,
                          height: 10,
                          width: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildShimmer(
                        context,
                        AppImage(
                          imageUrl: 'assets/icons/humidity.svg',
                        ),
                      ),
                      buildShimmer(
                        context,
                        buildContainer(
                          context,
                          height: 10,
                          width: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildShimmer(
                        context,
                        AppImage(
                          imageUrl: 'assets/icons/wind.svg',
                        ),
                      ),
                      buildShimmer(
                        context,
                        buildContainer(
                          context,
                          height: 10,
                          width: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                // Text('Humidity: '),
                // Text('Wind: '),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
