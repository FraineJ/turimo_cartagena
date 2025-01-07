import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turismo_cartagena/generated/l10n.dart';
import 'package:turismo_cartagena/presentation/modules/chat/chat-ana-ia.dart';
import 'package:turismo_cartagena/presentation/modules/favorite/favorite.dart';
import 'package:turismo_cartagena/presentation/modules/home/home.dart';
import 'package:turismo_cartagena/presentation/modules/map/maps-google.dart';
import 'package:turismo_cartagena/presentation/modules/map/maps-view.dart';
import 'package:turismo_cartagena/presentation/modules/map/maps.dart';
import 'package:turismo_cartagena/presentation/modules/profile/profile.dart';


class Layout extends StatefulWidget {
  int? currentItemPages;
  Layout({super.key, this.currentItemPages = 0});

  @override
  State<Layout> createState() => LayoutState(currentItemPages: currentItemPages);
}

class LayoutState extends State<Layout> {
  LayoutState({required currentItemPages});
  Set<Marker> markers = {};
  BitmapDescriptor? customIcon; // Define the custom icon variable
  Position? originLatLng;
  CustomInfoWindowController? _controllerCustomInfoWindow;

  void initMarker() async {
    Position currentPosition = await _getCurrentLocation();

    // Crear el marcador
    markers.add(
      Marker(
        markerId: MarkerId('current_location'), // Identificador único para el marcador
        icon: customIcon ?? BitmapDescriptor.defaultMarker, // Icono personalizado o predeterminado
        position: LatLng(currentPosition.latitude, currentPosition.longitude), // Posición actual
        onTap: () {
          print('Marcador tocado: ${currentPosition.latitude}, ${currentPosition.longitude}');
        },
      ),
    );
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Los servicios de ubicación están deshabilitados.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Los permisos de ubicación fueron denegados.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Los permisos de ubicación están permanentemente denegados.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }


  List<Widget> get pages => [
    HomeView(),
    const FavoriteView(),
    const ChatAna(),
    MapViewComponent(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[widget.currentItemPages ?? 0],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentItemPages ?? 0,
        onTap: (int newPage) {
          setState(() {
            widget.currentItemPages = newPage;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: S.current.Home,
          ),
          /*BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: S.current.Explore,
          ),*/
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite_border_rounded),
            label: S.current.Favorites,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/ana.gif', // Ruta de la imagen
              width: 40, // Ajusta el tamaño según sea necesario
              height: 40,
            ),
            label: S.current.chatAna,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.map),
            label: S.current.Explore,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: S.current.Profile,
          ),
        ],
        selectedItemColor: const Color(0xFF009C47),
        unselectedItemColor: Colors.black54,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
        ),
        selectedIconTheme: const IconThemeData(
          color: Color(0xFF009C47),
          size: 30.0,
        ),
        unselectedIconTheme: const IconThemeData(
          color: Colors.black54,
          size: 24.0,
        ),
      ),
    );
  }
}
