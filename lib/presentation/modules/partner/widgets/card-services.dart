import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:turismo_cartagena/domain/models/service.model.dart';
import 'package:turismo_cartagena/presentation/global/utils/all.dart' as UTILS;

class CardServicesPartner extends StatelessWidget {
  final Servicio services;
  final bool isDollar;
  final double exchangeRate;

  const CardServicesPartner({
    super.key,
    required this.services,
    required this.isDollar,
    required this.exchangeRate,
  });

  @override
  Widget build(BuildContext context) {
    final double tarifa = isDollar
        ? services.tarifa!.precio! / exchangeRate // Convierte a USD
        : services.tarifa!.precio!; // Mantiene en COP

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9 - 100, // Reduce el ancho para centrarlo
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
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
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8.0),
                topLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(0.0),
                bottomLeft: Radius.circular(0.0),
              ),
              child: services.imagenes!.isNotEmpty
                  ? Image.network(
                services.imagenes![0]['url'] ??
                    'https://i.pinimg.com/736x/40/60/bf/4060bf7ee3ca7637a713562ae13f1038.jpg',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              )
                  : Image.network(
                'https://i.pinimg.com/736x/40/60/bf/4060bf7ee3ca7637a713562ae13f1038.jpg',
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${services.name}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${services.descripcion}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isDollar
                        ? "\$${tarifa.toStringAsFixed(2)} USD"
                        : "\$${UTILS.Utils.formatearNumero(tarifa)} COP",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
