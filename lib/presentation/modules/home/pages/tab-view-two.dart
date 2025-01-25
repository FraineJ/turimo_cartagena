import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_cartagena/core/di/article_injection.dart';
import 'package:turismo_cartagena/domain/models/place.model.dart';
import 'package:turismo_cartagena/generated/l10n.dart';
import 'package:turismo_cartagena/presentation/bloc/places/places_bloc.dart';
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
                child: const Column(
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
