import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:turismo_cartagena/article_injection.dart';
import 'package:turismo_cartagena/domain/models/place.model.dart';
import 'package:turismo_cartagena/presentation/bloc/places/places_bloc.dart';
import 'package:turismo_cartagena/presentation/global/widgets/all-widgets.dart' as Widgets;
import 'package:turismo_cartagena/presentation/modules/places/widgets/card-places.dart';

class MapView extends StatelessWidget {
  final bool showAppBar;
  final int categoryId;

  const MapView({super.key, required this.showAppBar, required this.categoryId});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => PlacesBloc(sl())..add(GetPlaceByCategoryEvent(id: categoryId)),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<PlacesBloc, PlacesState>(
            builder: (context, state) {
              List<Marker> markers = [];
              if(state is LoadingGetPlaceByCategory){
                return CircularProgressIndicator();
              }

              if (state is SuccessGetPlaceByCategory) {
                List<PlaceModel> places = state.placeModel;

                markers = places.map((place) {
                  return Marker(
                    point: LatLng(place.latitud, place.longitud),
                    width: 50,
                    height: 50,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0), // Ajusta el borde si lo deseas
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8, // Ancho del 80% de la pantalla
                                height: MediaQuery.of(context).size.height * 0.4, // Alto del 60% de la pantalla
                                child: PlaceCard(place: place, autoPlay: true,),
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.location_on_sharp,
                        size: 30,
                        color: Colors.red,
                      ), // Aquí puedes cambiar a un icono que prefieras
                    ),
                  );
                }).toList();
              }

              return Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    if (showAppBar)
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Widgets.AppBarCustom(textTitle: "Mapa"),
                      ),
                    Expanded(
                      child: FlutterMap(
                        options: MapOptions(
                          initialCenter: LatLng(10.42455283436972, -75.54906879770333),
                          initialZoom: 14.5,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.app',
                            maxNativeZoom: 19,
                          ),
                          MarkerLayer(markers: markers),
                          RichAttributionWidget(
                            attributions: [
                              TextSourceAttribution(
                                'OpenStreetMap contributors',
                                onTap: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
