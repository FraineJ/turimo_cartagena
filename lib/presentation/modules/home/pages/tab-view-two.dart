import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turismo_cartagena/article_injection.dart';
import 'package:turismo_cartagena/domain/models/event.model.dart';
import 'package:turismo_cartagena/domain/models/place.model.dart';
import 'package:turismo_cartagena/generated/l10n.dart';
import 'package:turismo_cartagena/presentation/bloc/event/event_bloc.dart';
import 'package:turismo_cartagena/presentation/bloc/places/places_bloc.dart';
import 'package:turismo_cartagena/presentation/global/widgets/button-outlined.dart';
import 'package:turismo_cartagena/presentation/global/widgets/skeleton-card-buys.dart';
import 'package:turismo_cartagena/presentation/global/widgets/skeleton.dart';
import 'package:turismo_cartagena/presentation/modules/events/widgets/card-events.dart';
import 'package:turismo_cartagena/presentation/global/utils/all.dart' as UTILS;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:turismo_cartagena/presentation/modules/places/widgets/card-places.dart';


class TabViewTwoHome extends StatefulWidget {
  const TabViewTwoHome({super.key});

  @override
  State<TabViewTwoHome> createState() => _TabViewOneHomeState();
}

class _TabViewOneHomeState extends State<TabViewTwoHome> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      PlacesBloc(sl())
        ..add(GetAllPlaceByCategoryEvent()),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<PlacesBloc, PlacesState>(
            builder: (context, state) {
              if (state is LoadingGetPlaceByCategory) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is ErrorGetPlaceByCategory) {

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(S.current.errorServer))
                );
              }

              if(state is SuccessGetPlaceByCategory){
                List<PlaceModel> places = state.placeModel;

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: places.length,
                    itemBuilder: (context, index) {
                      return PlaceCard(place: places[index], autoPlay: false,);
                    },
                  ),
                );
              }

              return Container(
                child: Column(
                  children: [
                     CircularProgressIndicator(),

                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
