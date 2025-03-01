import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:turismo_cartagena/core/di/article_injection.dart';
import 'package:turismo_cartagena/domain/models/partner.model.dart';
import 'package:turismo_cartagena/presentation/bloc/partner/partner_bloc.dart';
import 'package:turismo_cartagena/presentation/modules/map/maps.dart';
import 'package:turismo_cartagena/presentation/modules/partner/widgets/card-partner.dart';
import 'package:turismo_cartagena/core/utils/all.dart' as UTILS;

class PartnerView extends StatefulWidget {
  final String categoryId;
  final Position? originLatLng;
  const PartnerView({super.key, required this.categoryId, required this.originLatLng});

  @override
  State<PartnerView> createState() => _PartnerViewState();
}

class _PartnerViewState extends State<PartnerView> {

   bool modeView = false;
   List<PartnersModel> _getNearbyPartner(List<PartnersModel> event) {
     return event
       ..sort((a, b) {
         double distanceA = UTILS.Utils.haversineDistanceKilometers(
           widget.originLatLng?.latitude ?? 0,
           widget.originLatLng?.longitude ?? 0,
           a.latitud,
           a.longitud,
         );
         double distanceB = UTILS.Utils.haversineDistanceKilometers(
           widget.originLatLng?.latitude ?? 0,
           widget.originLatLng?.longitude ?? 0,
           b.latitud,
           b.longitud,
         );
         return distanceA.compareTo(distanceB);
       }
       );
   }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      PartnerBloc(sl())..add(GetPartnerByCategoryEvent(id: widget.categoryId)),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<PartnerBloc, PartnersState>(
            builder: (context, state) {
              if (state is LoadingGetPartnerByCategory) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is SuccessGetPartnerByCategory) {
                List<PartnersModel> partners = state.partnerModel;
                partners = _getNearbyPartner(partners);

                return modeView ?  MapView(
                  showAppBar: false,
                  categoryId: widget.categoryId, // Pasar el ID correcto de la categoría
                ):
                ListView.builder(
                  itemCount: partners.length,
                  itemBuilder: (context, index) {
                    final partner = partners[index];

                    return PropertyCard(partner: partner, autoPlay: false);
                  },
                );
              }

              return Container();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              modeView = !modeView;
            });
          },
          label:  Text(modeView ?
            'Vista' : 'Mapa',
            style: const TextStyle(
                fontSize: 16,
              color: Colors.white
            ),
          ),
          icon:  Icon(
              modeView ? Icons.list_alt : Icons.map,
              size: 24,
              color: Colors.white
          ),
          backgroundColor: Colors.black,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
