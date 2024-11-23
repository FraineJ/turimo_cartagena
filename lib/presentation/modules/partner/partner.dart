import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_cartagena/article_injection.dart';
import 'package:turismo_cartagena/domain/models/partner.model.dart';
import 'package:turismo_cartagena/presentation/bloc/partner/partner_bloc.dart';
import 'package:turismo_cartagena/presentation/modules/map/maps.dart';
import 'package:turismo_cartagena/presentation/modules/partner/widgets/card-partner.dart';

class PartnerView extends StatefulWidget {
  final String categoryId;
  const PartnerView({super.key, required this.categoryId});

  @override
  State<PartnerView> createState() => _PartnerViewState();
}

class _PartnerViewState extends State<PartnerView> {

   bool modeView = false;

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
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is SuccessGetPartnerByCategory) {
                List<PartnersModel> partners = state.partnerModel;

                return modeView ?  MapView(
                  showAppBar: false,
                  categoryId: widget.categoryId, // Pasar el ID correcto de la categoría
                ):
                ListView.builder(
                  itemCount: partners.length,
                  itemBuilder: (context, index) {
                    final partner = partners[index];

                    return PropertyCard(partner: partner, autoPlay: true,);
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
          label: const Text(
            'Mapa',
            style: TextStyle(
                fontSize: 16,
              color: Colors.white
            ),
          ),
          icon: const Icon(
              Icons.map, size: 24,
              color: Colors.white
          ),
          backgroundColor: Colors.black,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
