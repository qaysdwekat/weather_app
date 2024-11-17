part of 'day_forecast_card.dart';

class DayForecastLoading extends StatelessWidget with BaseLoadingCard {
  const DayForecastLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Container(
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withOpacity(0.8),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(8.0),
        color: Color(0xFFFFFFFF).withOpacity(0.6),
        gradient: LinearGradient(
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFFFFFFF).withOpacity(0.7),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 1.0],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildShimmer(
            context,
            buildContainer(
              context,
              height: 10,
              width: 40,
            ),
          ),
          buildShimmer(
            context,
            buildContainer(
              context,
              height: 45,
              width: width * 0.12,
            ),
          ),
          buildShimmer(
              context,
              Row(
                children: [
                  buildContainer(
                    context,
                    height: 10,
                    width: 30,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  buildContainer(
                    context,
                    height: 10,
                    width: 30,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
