part of 'day_forecast_card.dart';

class DayForecastLoading extends StatelessWidget with BaseLoadingCard {
  final EdgeInsetsGeometry? margin;

  const DayForecastLoading({
    super.key,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Container(
      margin: margin,
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
          SizedBox(
            height: 12,
          ),
          buildShimmer(
            context,
            buildContainer(
              context,
              height: 45,
              width: width * 0.12,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          buildShimmer(
              context,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
