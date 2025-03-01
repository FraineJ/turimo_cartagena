import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:turismo_cartagena/core/di/article_injection.dart';
import 'package:turismo_cartagena/core/theme/sizes.dart';
import 'package:turismo_cartagena/domain/models/partner.model.dart';
import 'package:turismo_cartagena/presentation/bloc/initial-bloc/initial_bloc.dart';
import 'package:turismo_cartagena/presentation/bloc/partner/partner_bloc.dart';
import 'package:turismo_cartagena/core/utils/all.dart' as SHARED;
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

  int _currentIndex = 0;

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
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Stack(children: [
                    _buildImageContainer(context),
                    _buildFavoriteButton(context, isAuth),
                    _indicatorCarrousel(context)
                    ]

                  ),
                  SizedBox(height: AppSizes.marginMedium),
                  _buildPartnerInfo(context)
                  //_buildRecommendedTag(),



                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageContainer(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:  BorderRadius.circular(16),
            child: CarouselSlider(
                options: CarouselOptions(
                  height: 300,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlay: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: () {

                  List<Widget> listImage = widget.partner.imagesUrl.map((toElement) {
                    return CachedNetworkImage(
                      imageUrl: toElement,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                      const Center(
                          child: CircularProgressIndicator()
                      ),
                      errorWidget: (context, url, error) =>
                          Image.asset(
                            "assets/images/no-photo.jpg",
                            fit: BoxFit.cover,
                          ),
                    );
                  }).toList();

                  return listImage;
                }(),
            )
          ),
        ],
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

  Widget _indicatorCarrousel(BuildContext context) {
    return    Positioned(
      bottom: 10.0,
      left: 0.0,
      right: 0.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        widget.partner.imagesUrl!.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => setState(() {
              _currentIndex = entry.key;
            }),
            child: Container(
              width: 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Colors.white).withOpacity(
                    _currentIndex == entry.key ? 0.9 : 0.4
                ),
              ),
            ),
          );
        }).toList(),
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

      return Column(
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
            SHARED.Utils.truncateText(widget.partner.address ?? "", 40),
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
