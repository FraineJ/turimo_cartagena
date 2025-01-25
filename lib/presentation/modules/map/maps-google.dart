import 'dart:io';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:turismo_cartagena/presentation/modules/map/utils/style-map.dart';

class MapGoogle extends StatefulWidget {
  Set<Marker> markers;
  Position? currentLocation;
  final CustomInfoWindowController controllerCustomInfoWindow;
  bool isBarSearch;

  MapGoogle({
    Key? key,
    required this.markers,
    required this.controllerCustomInfoWindow,
    this.currentLocation,
    required this.isBarSearch
  }) : super(key: key);

  @override
  State<MapGoogle> createState() => MapGoogleState();
}

class MapGoogleState extends State<MapGoogle> {
  GoogleMapController? _controller;
  BitmapDescriptor? _customIcon;
  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(3.426528, -76.547689),
    zoom: 13,
  );


  @override
  void initState() {
    super.initState();
    _initializeMap();
    _setCustomMarkerIcon();
    _getCurrentLocation();
  }

  Future<void> _setCustomMarkerIcon() async {
    if(Platform.isIOS){
      _customIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        'assets/images/icon-person-ios.png',
      );
    } else {
      _customIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        'assets/images/icon-person.png',
      );
    }

    setState(() {});

  }


  void _initializeMap() {
    if (_controller != null && _customIcon != null) {
      if (widget.currentLocation != null) {
        _updateMapCamera(widget.currentLocation!);
      }
    } else {
      print("Esperando a que el controlador o el icono se inicialicen...");
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Los permisos fueron denegados
        return;
      }
    }

    // Obtener la posición actual
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      widget.currentLocation = position;
      widget.markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: LatLng(position.latitude, position.longitude),
          icon: _customIcon ?? BitmapDescriptor.defaultMarker,
        ),
      );
    });

    if (_controller != null) {
      _updateMapCamera(position);
    }
  }

  Future<void> _updateMapCamera(Position position) async {
    _controller?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 10,
        ),
      ),
    );
  }


  // Establece el estilo del mapa
  Future<void> _setMapStyle() async {
    if (_controller != null) {
      try {
        await _controller!.setMapStyle(mapStyle);
      } catch (e) {
        print("Error al establecer el estilo del mapa: $e");
      }
    } else {
      print("Error: El controlador de GoogleMap no está inicializado.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
                widget.controllerCustomInfoWindow.googleMapController = controller;

                // Inicializar mapa solo después de que el controlador esté listo
                _initializeMap();
                _setMapStyle(); // Establecer estilo del mapa
              },
              onTap: (position) {
                widget.controllerCustomInfoWindow.hideInfoWindow?.call();
              },
              onCameraMove: (position) {
                widget.controllerCustomInfoWindow.onCameraMove?.call();
              },
              initialCameraPosition: _initialPosition,
              mapType: MapType.normal,
              myLocationEnabled: false, // Deshabilitar la posición predeterminada
              myLocationButtonEnabled: true,
              markers: widget.markers,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true
          ),
          CustomInfoWindow(
            controller: widget.controllerCustomInfoWindow,
            width: 200,
            height: 200,
            offset: 20,
          ),
          widget.isBarSearch ? Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                hintText: "Buscar lugar", // Ajusta el texto según sea necesario
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide:  BorderSide.none
                ),

                filled: true,
                fillColor: Colors.white, // Fondo blanco para que destaque sobre el mapa
              ),
              onChanged: (value) {
                //searchCustomer(value); // Implementa la lógica de búsqueda aquí
              },
            ),
          ) : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
