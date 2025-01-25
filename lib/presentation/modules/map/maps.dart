import 'dart:io';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turismo_cartagena/core/di/article_injection.dart';
import 'package:turismo_cartagena/domain/models/partner.model.dart';
import 'package:turismo_cartagena/presentation/bloc/partner/partner_bloc.dart';
import 'package:turismo_cartagena/presentation/bloc/places/places_bloc.dart';
import 'package:turismo_cartagena/core/widgets/all-widgets.dart' as Widgets;
import 'package:turismo_cartagena/presentation/modules/map/maps-google.dart';
import 'package:turismo_cartagena/presentation/modules/partner/partner-detail.dart';


class MapView extends StatefulWidget {
  final bool showAppBar;
  final String categoryId;

  const MapView({super.key, required this.showAppBar, required this.categoryId});

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Set<Marker> markers = {};
  final _customInfoWindowController = CustomInfoWindowController();
  BitmapDescriptor? customIcon;
  Position? originLatLng;
  Future<Position?>? _currentPositionFuture;

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

  Future<Position?> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        originLatLng = position;
      });
      return position;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error getting location: $e')),
        );
      }
      return null;
    }
  }


  @override
  void initState() {
    super.initState();
    _loadCustomMarkerIcon();
    _currentPositionFuture = _getCurrentLocation(); // Inicializa la posición actual
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PartnerBloc(sl())..add(GetPartnerByCategoryEvent(id: widget.categoryId)),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<PartnerBloc, PartnersState>(
            builder: (context, state) {

              if (state is LoadingGetPlaceByCategory) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is SuccessGetPartnerByCategory) {
                List<PartnersModel> partners = state.partnerModel;


                for (int i = 0; i < partners.length; i++) {
                  markers.add(
                    Marker(
                      markerId: MarkerId(i.toString()), // Unique identifier for each marker
                      icon: customIcon ?? BitmapDescriptor.defaultMarker, // Use custom icon if loaded
                      position: LatLng(partners[i].latitud, partners[i].longitud), // Marker position
                      onTap: () {
                        _customInfoWindowController.addInfoWindow!(
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                    create: (context) => PartnerBloc(sl()),
                                    child: PartnerDetailScreen(partners: partners[i])
                                ),
                              ));
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
                                          if (partners[i].imagesUrl != null && partners[i].imagesUrl!.isNotEmpty)
                                            ClipRRect(
                                              borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
                                              child: Image.network(
                                                partners[i].imagesUrl![0],
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
                                    partners[i].name,
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
                          LatLng(partners[i].latitud, partners[i].longitud), // Info window position
                        );
                      },
                    ),
                  );
                }
              }

              return Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    if (widget.showAppBar)
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Widgets.AppBarCustom(textTitle: "Mapa"),
                      ),
                    Expanded(
                      child:  MapGoogle(
                        markers: markers,
                        controllerCustomInfoWindow: _customInfoWindowController,
                        isBarSearch: false,
                      )
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
