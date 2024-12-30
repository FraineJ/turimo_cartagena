import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismo_cartagena/article_injection.dart';
import 'package:turismo_cartagena/domain/models/category.model.dart';
import 'package:turismo_cartagena/generated/l10n.dart';
import 'package:turismo_cartagena/presentation/bloc/category/category_bloc.dart';
import 'package:turismo_cartagena/presentation/global/widgets/no-data.dart';
import 'package:turismo_cartagena/presentation/modules/home/pages/tab-view-one.dart';
import 'package:turismo_cartagena/presentation/global/utils/all.dart' as SHARED;
import 'package:turismo_cartagena/presentation/modules/partner/partner.dart';

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

class _HomeViewState extends State<Home>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  LatLng? myPosition;
  List<CategoryModel> category = [];
  Position? originLatLng;
  Position? currentLocation;
  Future<Position?>? _currentPositionFuture;
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();

  void _scrollToIndex(int index) {
    const double itemWidth = 100.0; // Ancho estimado del elemento (ajusta según tu diseño)
    final double targetOffset = index * itemWidth;
    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(GetCategoryEvent());
    _currentPositionFuture = _getCurrentLocation();
  }

  Future<Position?> _getCurrentLocation() async {
    var status = await Permission.location.status;
    Position? currentLocation = await SHARED.Utils.getPositionCurrent();
    if (currentLocation != null &&
        currentLocation.longitude != null &&
        currentLocation.latitude != null) {
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
        headingAccuracy: 0,
      );
    }

    if (status.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
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
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is LoadingGetCategory) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ErrorGetCategory) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const NoDataWidget(
                  svgPath: "assets/images/danger.svg",
                  title: "Error del Servidor",
                  description:
                  "Ocurrió un problema al conectarse con el servidor. Por favor, inténtelo nuevamente más tarde.",
                ),
              );
            }

            if (state is SuccessGetCategory) {

              category = [
                CategoryModel(
                  id: '0',
                  code: '0',
                  name: "Destacados",
                  image:
                  "https://storaga-turismo-gooway.s3.us-east-1.amazonaws.com/categories/destacado/destacado.svg",
                ),
                ...state.categoryModel,
              ];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage("assets/images/logo-app.png"),
                          width: 150,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40, // Altura de los tabs
                    child: ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: category.length,
                      itemBuilder: (context, index) {
                        final item = category[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index; // Cambiar el índice seleccionado
                            });
                            _scrollToIndex(index);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 0.0
                            ),
                            decoration: BoxDecoration(
                              color: _selectedIndex == index
                                  ? Colors.green
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: _selectedIndex == index
                                ? Colors.transparent
                                : Colors.grey[400]!,
                                width: 1.0,         // Ancho del borde
                              ),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.network(
                                  item.image!,
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  item.name,
                                  style: TextStyle(
                                    color: _selectedIndex == index
                                        ? Colors.white
                                        : Colors.black,

                                    fontWeight: _selectedIndex == index
                                      ? FontWeight.bold
                                      : FontWeight.w500
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Expanded(
                    child: _selectedIndex == 0
                        ? const TabViewOneHome()
                        : PartnerView(
                        key: ValueKey(category[_selectedIndex].id),
                        categoryId: category[_selectedIndex].id
                    ),
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
