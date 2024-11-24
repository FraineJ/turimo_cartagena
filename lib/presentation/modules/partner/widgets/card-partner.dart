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
  bool isFavorite = false;
  bool isAuth = false;

  Future<Position?> _getCurrentLocation() async {
    try {
      return await SHARED.Utils.getPositionCurrent();
    } catch (e) {
      return null; // Manejo de errores en caso de fallo de geolocalización
    }
  }

  void _toggleFavorite(BuildContext context) {
    if (!isAuth) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Para agregar este negocio a favoritos debe iniciar sesión",
            style: TextStyle(color: Colors.white),
          ),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          backgroundColor: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    setState(() {
      isFavorite = !isFavorite;
    });

    final event = AddPartnerFavoriteEvent(id: widget.partner.id);
    context.read<PartnerBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      InitialBloc(sl())
        ..add(AppInitialEvent()),
      child: MultiBlocListener(
        listeners: [
          BlocListener<InitialBloc, InitialState>(
            listener: (context, state) {
              if (state is IsAuthenticatedFailure) {
                setState(() {
                  isAuth = false;
                });
              } else if (state is IsAuthenticatedSuccess) {
                setState(() {
                  isAuth = true;
                });
              }
            },
          ),
          BlocListener<PartnerBloc, PartnersState>(
            listener: (context, state) {
              if (state is SuccessAddPartnerFavorite) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Se ha agregado el negocio a tus favoritos",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  ),
                );

              }

              if (state is ErrorAddPartnerFavorite) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Has eliminado el negocio de tus favoritos",
                      style: TextStyle(color: Colors.white),
                    ),
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  ),
                );
              }


            },
          ),
        ],
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PartnerDetailScreen(
                      partners: widget.partner,
                    ),
              ),
            );
          },
          child: Container(
            height: widget.height ?? 300,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                // Imagen del socio
                Container(
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
                ),
                // Etiqueta "Recomendado"
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 8),
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
                ),
                // Botón de favoritos
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () => _toggleFavorite(context),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.black54,
                      ),
                    ),
                  ),
                ),
                // Información del socio
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
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
                          SHARED.Utils.truncateText(
                              widget.partner.address, 40),
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
                                Icon(Icons.star,
                                    color: Colors.orange, size: 16),
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
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: Colors.redAccent, size: 16),
                                const SizedBox(width: 8),
                                FutureBuilder<Position?>(
                                  future: _getCurrentLocation(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child:
                                          CircularProgressIndicator());
                                    } else if (snapshot.hasError ||
                                        snapshot.data == null) {
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}