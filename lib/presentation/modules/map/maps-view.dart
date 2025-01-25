import 'dart:io';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turismo_cartagena/core/di/article_injection.dart';
import 'package:turismo_cartagena/domain/models/place.model.dart';
import 'package:turismo_cartagena/generated/l10n.dart';
import 'package:turismo_cartagena/presentation/bloc/places/places_bloc.dart';
import 'package:turismo_cartagena/presentation/modules/map/maps-google.dart';
import 'package:turismo_cartagena/presentation/modules/places/place-detail.dart';

class MapViewComponent extends StatefulWidget {
  MapViewComponent({super.key});

  @override
  State<MapViewComponent> createState() => _MapViewComponentState();
}

class _MapViewComponentState extends State<MapViewComponent> {
  CustomInfoWindowController controllerCustomInfoWindow = new CustomInfoWindowController();
  Set<Marker> markers = {};
  BitmapDescriptor? customIcon;

  Future<void> _loadCustomMarkerIcon() async {
    if(Platform.isIOS){
      customIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        'assets/images/icon-location-ios.png',
      );
    } else {
      customIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        'assets/images/icon-location.png',
      );
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadCustomMarkerIcon();
  }


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
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(S.current.errorServer)),
                  );
                });
              }


              if(state is SuccessGetPlaceByCategory){
                List<PlaceModel> places = state.placeModel;

                for (int i = 0; i < places.length; i++) {
                  markers.add(
                    Marker(
                      markerId: MarkerId(i.toString()), // Unique identifier for each marker
                      icon: customIcon ?? BitmapDescriptor.defaultMarker, // Use custom icon if loaded
                      position: LatLng(places[i].latitud, places[i].longitud), // Marker position
                      onTap: () {
                        controllerCustomInfoWindow.addInfoWindow!(
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => PlaceDetailScreen(place: places[i]))
                              );
                            },
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: 250, // Define el ancho del container
                                      decoration:  BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.only(
                                            topLeft:  Radius.circular(12.0),
                                            topRight: Radius.circular(12.0)
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 2), // Sombra debajo del contenedor
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          if (places[i].imagesUrl != null && places[i].imagesUrl!.isNotEmpty)
                                            ClipRRect(
                                              borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
                                              child: Image.network(
                                                places[i].imagesUrl![0],
                                                height: 125,
                                                width: 250,
                                                fit: BoxFit.cover,
                                                loadingBuilder: (context, child, loadingProgress) {
                                                  if (loadingProgress == null) return child;
                                                  return Container(
                                                    height: 125,
                                                    width: 250,
                                                    color: Colors.grey[200], // Placeholder color
                                                    child: Center(child: CircularProgressIndicator()),
                                                  );
                                                },
                                                errorBuilder: (context, error, stackTrace) {
                                                  return Container(
                                                    height: 125,
                                                    width: 250,
                                                    color: Colors.grey,
                                                    child: Icon(Icons.error, color: Colors.red),
                                                  );
                                                },
                                              ),
                                            )
                                          else
                                            ClipRRect(
                                              borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
                                              child: Image.asset(
                                                "assets/images/logo-app.png",
                                                fit: BoxFit.cover,
                                                height: 125,
                                                width: 250,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft:  Radius.circular(12.0),
                                        bottomRight: Radius.circular(12.0)
                                    ),
                                  ),
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), // Añadir más padding
                                  child: Text(
                                    places[i].name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          LatLng(places[i].latitud, places[i].longitud), // Info window position
                        );
                      },
                    ),
                  );
                }
              }

              return Container(
                child: Column(
                  children: [
                    Expanded(
                      child: MapGoogle(
                        isBarSearch: false,
                        markers: markers,
                        controllerCustomInfoWindow: controllerCustomInfoWindow,
                      ),
                    )
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
