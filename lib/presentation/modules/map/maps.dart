import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:turismo_cartagena/article_injection.dart';
import 'package:turismo_cartagena/domain/models/partner.model.dart';
import 'package:turismo_cartagena/presentation/bloc/partner/partner_bloc.dart';
import 'package:turismo_cartagena/presentation/bloc/places/places_bloc.dart';
import 'package:turismo_cartagena/presentation/global/widgets/all-widgets.dart' as Widgets;
import 'package:turismo_cartagena/presentation/modules/partner/widgets/card-partner-map.dart';

class MapView extends StatelessWidget {
  final bool showAppBar;
  final String categoryId;

  const MapView({super.key, required this.showAppBar, required this.categoryId});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => PartnerBloc(sl())..add(GetPartnerByCategoryEvent(id: categoryId)),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<PartnerBloc, PartnersState>(
            builder: (context, state) {
              List<Marker> markers = [];
              if(state is LoadingGetPlaceByCategory){
                return CircularProgressIndicator();
              }

              if (state is SuccessGetPartnerByCategory) {
                List<PartnersModel> partners = state.partnerModel;

                markers = partners.map((partner) {
                  return Marker(
                    point: LatLng(partner.latitud, partner.longitud),
                    width: 50,
                    height: 50,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: MediaQuery.of(context).size.height * 0.4,
                                child: PartnerCardMap(partner: partner, autoPlay: false),
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.location_on_sharp,
                        size: 40,
                        color: Colors.red,
                      ),
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
                        options: const MapOptions(
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
