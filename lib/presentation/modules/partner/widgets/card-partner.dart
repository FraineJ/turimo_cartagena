import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:turismo_cartagena/article_injection.dart';
import 'package:turismo_cartagena/domain/models/partner.model.dart';
import 'package:turismo_cartagena/presentation/bloc/initial-bloc/initial_bloc.dart';
import 'package:turismo_cartagena/presentation/bloc/partner/partner_bloc.dart';
import 'package:turismo_cartagena/presentation/global/utils/all.dart' as SHARED;
import 'package:turismo_cartagena/presentation/modules/partner/partner-detail.dart';

class PropertyCard extends StatelessWidget {
  final PartnersModel partner;
  final bool autoPlay;

  const PropertyCard({Key? key, required this.partner, required this.autoPlay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PartnerBloc(sl()),
      child: PropertyCardState(partner: partner),
    );
  }
}

class PropertyCardState extends StatefulWidget {
  final double? height;
  final PartnersModel partner;

  const PropertyCardState({Key? key, this.height, required this.partner})
      : super(key: key);

  @override
  State<PropertyCardState> createState() => _PropertyCardStateState();
}

class _PropertyCardStateState extends State<PropertyCardState> {
  late Future<Position?> currentPosition;

  @override
  void initState() {
    super.initState();
    currentPosition = SHARED.Utils.getPositionCurrent();
  }

  void _toggleFavorite(BuildContext context, bool isAuth) {
    print("is auteh $isAuth");
    if (!isAuth) {
      SHARED.Utils.showSnackBar(
        context,
        "Para agregar este negocio a favoritos debe iniciar sesión",
        Colors.redAccent,
      );
      return;
    }

    setState(() {
      widget.partner.favorite = !widget.partner.favorite;
    });

    final event = AddPartnerFavoriteEvent(id: widget.partner.id);
    context.read<PartnerBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PartnerBloc, PartnersState>(
      listener: (context, state) {
        if (state is SuccessAddPartnerFavorite) {
          SHARED.Utils.showSnackBar(context, "Se ha agregado el negocio a tus favoritos", Colors.green);
        }

        if (state is SuccessDeletePartnerFavorite) {
          SHARED.Utils.showSnackBar(context, "Has eliminado el negocio de tus favoritos", Colors.red);
        }
      },
      child: BlocBuilder<InitialBloc, InitialState>(
        builder: (context, state) {
          final isAuth = state.isLoginApp;
          print("estado del auth $isAuth");
          return GestureDetector(
            onTap: () {

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => PartnerBloc(sl()),
                    child: PartnerDetailScreen(partners: widget.partner)
                ),
              ));

            },
            child: Container(
              height: widget.height ?? 300,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  _buildImageContainer(),
                  _buildRecommendedTag(),
                  _buildFavoriteButton(context, isAuth),
                  _buildPartnerInfo(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(widget.partner.imagesUrl.first),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildRecommendedTag() {
    return Positioned(
      top: 10,
      left: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Text(
          'Recomendado',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteButton(BuildContext context, bool isAuth) {
    return Positioned(
      top: 10,
      right: 10,
      child: GestureDetector(
        onTap: () => _toggleFavorite(context, isAuth),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            widget.partner.favorite ? Icons.favorite : Icons.favorite_border,
            color: widget.partner.favorite ? Colors.red : Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget _buildPartnerInfo(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.partner.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              SHARED.Utils.truncateText(widget.partner.address, 40),
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 16),
                    SizedBox(width: 8),
                    Text(
                      '4.5 Rating',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                _buildDistanceInfo(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDistanceInfo() {
    return Row(
      children: [
        const Icon(Icons.location_on, color: Colors.redAccent, size: 16),
        const SizedBox(width: 8),
        FutureBuilder<Position?>(
          future: currentPosition,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || snapshot.data == null) {
              return const Text(
                "Ubicación no disponible",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              );
            } else {
              return Text(
                "${SHARED.Utils.haversineDistanceString(
                  snapshot.data?.latitude ?? 0.0,
                  snapshot.data?.longitude ?? 0.0,
                  widget.partner.latitud,
                  widget.partner.longitud,
                )} de distancia",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              );
            }
          },
        ),
      ],
    );
  }

}
