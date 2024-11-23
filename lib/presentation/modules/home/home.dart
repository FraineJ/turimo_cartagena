import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismo_cartagena/article_injection.dart';
import 'package:turismo_cartagena/domain/models/category.model.dart';
import 'package:turismo_cartagena/generated/l10n.dart';
import 'package:turismo_cartagena/presentation/bloc/category/category_bloc.dart';
import 'package:turismo_cartagena/presentation/global/widgets/no-data.dart';
import 'package:turismo_cartagena/presentation/modules/home/pages/qr-view/qa-view-example.dart';
import 'package:turismo_cartagena/presentation/modules/home/pages/tab-view-one.dart';
import 'package:turismo_cartagena/presentation/modules/map/maps.dart';
import 'package:turismo_cartagena/presentation/global/utils/all.dart' as SHARED ;
import 'package:turismo_cartagena/presentation/modules/partner/partner.dart';

const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoicGl0bWFjIiwiYSI6ImNsY3BpeWxuczJhOTEzbnBlaW5vcnNwNzMifQ.ncTzM4bW-jpq-hUFutnR1g';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryBloc(sl()),
        ),
      ],
      child: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeViewState();
}

class _HomeViewState extends State<Home> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  LatLng? myPosition;
  List<Widget> _tabs = [];
  List<CategoryModel> category = [];
  Position? originLatLng;
  Position? currentLocation;
  Future<Position?>? _currentPositionFuture;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(GetCategoryEvent());
    _currentPositionFuture = _getCurrentLocation();
  }


  Future<Position?> _getCurrentLocation() async {
    var status = await Permission.location.status;
    Position? currentLocation = await SHARED.Utils.getPositionCurrent();
    if (currentLocation != null && currentLocation.longitude != null && currentLocation.latitude != null) {
      originLatLng = Position(
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude,
          timestamp: DateTime.now(),
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
          altitudeAccuracy: 0,
          headingAccuracy: 0
      );
    }

    if (status.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        await _savePosition(position);
        return position;
      } catch (e) {
        return Future.error("Error al obtener la ubicación");
      }
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
      return Future.error("Permiso permanentemente denegado");
    } else {
      var requestResult = await Permission.location.request();
      if (requestResult.isGranted) {
        return await _getCurrentLocation(); // Volver a llamar
      } else {
        return Future.error("Permiso de ubicación no concedido.");
      }
    }
  }

  Future<void> _savePosition(Position position) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('position', '${position.latitude},${position.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child:  BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is LoadingGetCategory) {
            return const Center(child: CircularProgressIndicator());
          }

          if(state is ErrorGetCategory) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: const NoDataWidget(
                icon: Icons.wifi_off_outlined,
                title: "Error de conexión",
                description: "No se pudo establecer conexión a internet. Por favor, verifique su red e intente nuevamente.",
              ),
            );

          }

          if (state is SuccessGetCategory) {
            category = state.categoryModel;

            _tabs = [
              const Tab(text: "Destacados"),
              ...category.map((category) {
                return Tab(text: category.name);
              }).toList(),
            ];

            return  Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Cartagena",
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                    ),
                    const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 16),
                    child: TextField(
                      //controller: _searchController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        hintText: S.current.where_to_go_today,
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.grey, width: 1.0), // Borde gris de 1px
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      onChanged: (value) {
                        //searchCustomer(value);
                      },
                    ),
                  ),


                  DefaultTabController(
                    length: _tabs.length,
                    child: Expanded( // Aquí utilizamos Expanded para darle una altura fija al TabBarView
                      child: Column(
                        children: [
                          TabBar(
                            isScrollable: true,
                            tabs: _tabs,
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                const TabViewOneHome(),
                                ...category.asMap().entries.map((entry) {
                                  int index = entry.key;
                                  CategoryModel cat = entry.value;

                                  return Builder(
                                    builder: (context) {
                                      currentIndex = DefaultTabController.of(context)!.index;
                                      if (currentIndex == index + 1) {
                                        return PartnerView( categoryId: cat.id);
                                      } else {
                                        return const Center(child: Text("Cargando..."));
                                      }
                                    },
                                  );
                                }).toList(),
                              ]
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        }),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => ListPhone()),
          );

        },
        backgroundColor: const Color(0xFF22014D),
        child: const Icon(
          Icons.phone,
          color: Color(0xFFFFFFFF),
        ),
      ),*/
    );
  }

  @override
  bool get wantKeepAlive => true;
}
