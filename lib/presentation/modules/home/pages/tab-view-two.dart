import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:turismo_cartagena/core/di/article_injection.dart';
import 'package:turismo_cartagena/core/theme/sizes.dart';
import 'package:turismo_cartagena/domain/models/place.model.dart';
import 'package:turismo_cartagena/generated/l10n.dart';
import 'package:turismo_cartagena/presentation/bloc/places/places_bloc.dart';
import 'package:turismo_cartagena/presentation/modules/places/widgets/card-places.dart';
import 'package:turismo_cartagena/core/utils/all.dart' as UTILS;
import 'package:turismo_cartagena/core/widgets/all-widgets.dart' as WIDGET;


class TabViewTwoHome extends StatefulWidget {
  final Position? originLatLng;
  const TabViewTwoHome({super.key, required this.originLatLng});

  @override
  State<TabViewTwoHome> createState() => _TabViewOneHomeState();
}

class _TabViewOneHomeState extends State<TabViewTwoHome> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlacesBloc(sl())..add(GetAllPlaceByCategoryEvent()),
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<PlacesBloc, PlacesState>(
            listener: (context, state) {
              if (state is ErrorGetPlaceByCategory) {

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(S.current.errorServer)),
                  );
                });
              }
            },
            child: BlocBuilder<PlacesBloc, PlacesState>(
              builder: (context, state) {
                if (state is LoadingGetPlaceByCategory) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is ErrorGetPlaceByCategory) {

                  return   Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: WIDGET.NoDataWidget(
                          network: true,
                          svgPath: "https://storaga-turismo-gooway.s3.us-east-1.amazonaws.com/categories/destacado/beach.svg",
                          title: "No se encontraron lugares",
                          description: "No pudimos obtener la información de los lugares en este momento. Verifique su conexión e inténtelo nuevamente.",
                        ),

                      ),
                      SizedBox(height: AppSizes.marginMedium),
                      WIDGET.RegistrationButton(
                        color: Colors.green,
                        width: 190,
                        text: S.current.retry,
                        onPressed: () {
                          context.read<PlacesBloc>().add(GetAllPlaceByCategoryEvent());
                        },
                      ),
                    ],
                  );
                }

                if (state is SuccessGetPlaceByCategory) {
                  List<PlaceModel> places = state.placeModel;
                  places = _getNearbyPlaces(places);

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: places.length,
                      itemBuilder: (context, index) {
                        return PlaceCard(
                          place: places[index],
                          autoPlay: false,
                        );
                      },
                    ),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  List<PlaceModel> _getNearbyPlaces(List<PlaceModel> places) {
    return places
      ..sort((a, b) {
        double distanceA = UTILS.Utils.haversineDistanceKilometers(
          widget.originLatLng?.latitude ?? 0,
          widget.originLatLng?.longitude ?? 0,
          a.latitud,
          a.longitud,
        );
        double distanceB = UTILS.Utils.haversineDistanceKilometers(
          widget.originLatLng?.latitude ?? 0,
          widget.originLatLng?.longitude ?? 0,
          b.latitud,
          b.longitud,
        );
        return distanceA.compareTo(distanceB);
      }
      );
  }
}
