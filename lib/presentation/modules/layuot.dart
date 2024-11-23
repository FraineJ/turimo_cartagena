import 'package:flutter/material.dart';
import 'package:turismo_cartagena/generated/l10n.dart';
import 'package:turismo_cartagena/presentation/modules/favorite/favorite.dart';
import 'package:turismo_cartagena/presentation/modules/home/home.dart';
import 'package:turismo_cartagena/presentation/modules/map/maps.dart';
import 'package:turismo_cartagena/presentation/modules/profile/profile.dart';
import 'package:turismo_cartagena/presentation/modules/travel/travel.dart';

class Layout extends StatefulWidget {
  int? currentItemPages;
  Layout({super.key, this.currentItemPages = 0});

  @override
  State<Layout> createState() => LayoutState(currentItemPages: currentItemPages);
}

class LayoutState extends State<Layout> {
  LayoutState({required currentItemPages});

  List<Widget> get pages => [
    HomeView(),
    FavoriteView(),
    TravelView(),
    //MapView(showAppBar: true,),
    ProfileView(),
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
        items:  [
          BottomNavigationBarItem(
            backgroundColor: Colors.white70,
            icon: const Icon(Icons.search),
            label: S.current.Explore,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite_border_rounded),
            label: S.current.Favorites,
          ),
          /*BottomNavigationBarItem(
              icon: Icon(Icons.credit_card),
              label: "Gastos"
          ),*/
          BottomNavigationBarItem(
            icon: const Icon(Icons.airplanemode_on_rounded),
            label: S.current.Trips,
          ),
          /*BottomNavigationBarItem(
            icon: Icon(Icons.place_outlined),
            label: "Mapas",
          ),*/
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: S.current.Profile,
          ),
        ],
        selectedItemColor: const Color(0xFF22014D), // Color de texto seleccionado
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
