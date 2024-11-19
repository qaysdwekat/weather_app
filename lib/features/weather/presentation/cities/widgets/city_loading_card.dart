part of 'city_card.dart';

class CityLoadingCard extends StatelessWidget with BaseLoadingCard {
  const CityLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Color(0xFF104084).withOpacity(0.4),
      ),
      margin: EdgeInsets.only(right: 12, left: 12, bottom: 12),
      child: buildShimmer(
          context,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildContainer(
                context,
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              buildContainer(
                context,
                height: 10,
                width: width * 0.5,
              ),
            ],
          )),
    );
  }
}
