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
    //TravelView(),
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
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: S.current.Explore,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite_border_rounded),
            label: S.current.Favorites,
          ),
          /*BottomNavigationBarItem(
            icon: const Icon(Icons.airplanemode_on_rounded),
            label: S.current.Trips,
          ),*/
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
