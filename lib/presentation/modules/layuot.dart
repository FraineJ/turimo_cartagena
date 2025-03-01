import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turismo_cartagena/generated/l10n.dart';
import 'package:turismo_cartagena/presentation/modules/chat/chat-ana-ia.dart';
import 'package:turismo_cartagena/presentation/modules/favorite/favorite.dart';
import 'package:turismo_cartagena/presentation/modules/home/home.dart';
import 'package:turismo_cartagena/presentation/modules/map/maps-view.dart';
import '../../core/theme/colors.dart';
import 'menu/menu.dart';

class Layout extends StatefulWidget {
  int? currentItemPages;
  Layout({super.key, this.currentItemPages = 0});

  @override
  State<Layout> createState() => LayoutState(currentItemPages: currentItemPages);
}

class LayoutState extends State<Layout> {
  LayoutState({required this.currentItemPages});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Set<Marker> markers = {};
  BitmapDescriptor? customIcon;
  Position? originLatLng;
  CustomInfoWindowController? _controllerCustomInfoWindow;
  int? currentItemPages;
  bool typeView = true;

  void _onItemSelected(int index) {
    setState(() {
      currentItemPages = index;
    });
    Navigator.pop(context);
  }

  void initMarker() async {
    Position currentPosition = await _getCurrentLocation();
    markers.add(
      Marker(
        markerId: MarkerId('current_location'),
        icon: customIcon ?? BitmapDescriptor.defaultMarker,
        position: LatLng(currentPosition.latitude, currentPosition.longitude),
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
    const SizedBox(), // Espacio reservado para la opción del menú
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: pages[
      (widget.currentItemPages != null && widget.currentItemPages! < pages.length)
          ? widget.currentItemPages!
          : 0], // Evita el error de rango
      drawer: MenuBarApp(
        currentIndex: currentItemPages,
        onItemSelected: _onItemSelected,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentItemPages ?? 0,
        onTap: (int newPage) {
          if (newPage == 4) {
            _scaffoldKey.currentState?.openDrawer(); // Usa la clave para abrir el drawer
          } else {
            setState(() {
              widget.currentItemPages = newPage;
            });
          }
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: S.current.Home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite_border_rounded),
            label: S.current.Favorites,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/ana.gif',
              width: 40,
              height: 40,
            ),
            label: S.current.chatAna,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.map),
            label: S.current.Explore,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.menu),
            label: S.current.menu,
          ),
        ],
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.black54,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
        ),
        selectedIconTheme: const IconThemeData(
          color: AppColors.primary,
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
