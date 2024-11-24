import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_cartagena/article_injection.dart';
import 'package:turismo_cartagena/domain/models/partner.model.dart';
import 'package:turismo_cartagena/presentation/bloc/partner/partner_bloc.dart';
import 'package:turismo_cartagena/presentation/global/utils/all.dart' as SHARED;
import 'package:turismo_cartagena/presentation/modules/partner/partner-detail.dart';

class PropertyCard extends StatelessWidget {
  final PartnersModel partner;
  final bool autoPlay;

  PropertyCard({super.key, required this.partner, required this.autoPlay});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PartnerBloc(sl()),
        child: PropertyCardState(partner: partner));
  }
}

class PropertyCardState extends StatefulWidget {
  final double? height; // Parámetro para definir la altura
  final PartnersModel partner;
  PropertyCardState({Key? key, this.height, required this.partner})
      : super(key: key);

  @override
  State<PropertyCardState> createState() => _PropertyCardStateState();
}

class _PropertyCardStateState extends State<PropertyCardState> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PartnerBloc, PartnersState>(
      listener: (context, state) {
        if(state is SuccessAddPartnerFavorite) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Se ha agregado a mis favoritos")));
        }

        if(state is ErrorAddPartnerFavorite) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Has  eliminado el aliado de tus favoritos")));
        }

        if(state is ErrorServeAddPartnerFavorite) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Ha ocurido un error inesperado")));
        }
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PartnerDetailScreen(
                      partners: widget.partner,
                    )),
          );
        },
        child: Container(
          height: 300, // Aplicar la altura si se proporciona
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.2), // Borde sutil y suave
                    width: 1.0, // Grosor del borde
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // Sombra suave
                      blurRadius: 8, // Radio de difuminado de la sombra
                      offset: Offset(0, 4), // Dirección de la sombra
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(widget.partner.imagesUrl.first),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                    final event = AddPartnerFavoriteEvent(id: widget.partner.id);
                    context.read<PartnerBloc>().add(event);
                  },
                  child:  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.black54,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
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
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  color: Colors.white, size: 16),
                              SizedBox(width: 8),
                              Text(
                                '1 Km de Distancia',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
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
    );
  }
}
