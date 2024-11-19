import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../widgets/error_card.dart';
import 'cities_bloc.dart';
import 'cities_state.dart';
import 'events/fetch_cities_event.dart';
import 'widgets/city_card.dart';

final GetIt sl = GetIt.instance;

class CitiesScreen extends StatelessWidget {
  CitiesScreen({super.key});

  final RefreshController refreshController = RefreshController();

  final bloc = sl<CitiesBloc>();

  @mustCallSuper
  CitiesBloc onCreate(BuildContext context) {
    return bloc..add(FetchCitiesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: onCreate(context),
      child: BlocConsumer<CitiesBloc, CitiesState>(listener: (c, s) {
        if (s is LoadedState || s is ErrorState) {
          refreshController.refreshCompleted();
        }
      }, builder: (c, s) {
        return buildScreen(c, s);
      }),
    );
  }

  Widget buildScreen(BuildContext context, CitiesState state) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 64),
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
            bloc.add(FetchCitiesEvent());
          },
          child: Builder(
            builder: (context) {
              if (state is ErrorState) {
                return ErrorCard(
                    message: state.error,
                    onPressed: () {
                      bloc.add(FetchCitiesEvent());
                    });
              }
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 56,
                    ),
                  ),
                  SliverList.builder(
                      itemCount: state.cities.length,
                      itemBuilder: (_, index) {
                        final city = state.cities[index];
                        return CityCard(
                          city: city,
                        );
                      }),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
