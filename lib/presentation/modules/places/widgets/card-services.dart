import 'package:flutter/material.dart';
import 'package:turismo_cartagena/domain/models/service.model.dart';

class CardServices extends StatelessWidget {
  final Servicio services;
  const CardServices({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    print("services ${services}");
    return Container(
      margin: EdgeInsets.only(right: 16),
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: services.imagenes!.isNotEmpty
                ? Image.network(
              services.imagenes![0]['url'] ?? 'https://i.pinimg.com/736x/40/60/bf/4060bf7ee3ca7637a713562ae13f1038.jpg',
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
                Text("${services.descripcion}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
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
    );
  }
}
