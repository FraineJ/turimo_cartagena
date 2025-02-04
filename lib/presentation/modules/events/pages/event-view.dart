import 'package:flutter/material.dart';
import 'package:turismo_cartagena/domain/models/event.model.dart';
import 'package:turismo_cartagena/presentation/modules/events/events.dart';

class EventCard extends StatelessWidget {
  final EventModel event;

  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventDetailScreen(event: event,)),

        );
      },
      child: Card(
        elevation: 8,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen principal
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.network(
                event.imagesUrl.first,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Contenido del evento
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre del evento
                  Text(
                    event.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Dirección y estado
                  Row(
                    children: [
                      const Icon(
                          Icons.location_on,
                          size: 18, color: Colors.red
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.address,
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: event.status == 'ACTIVE'
                              ? Colors.green.withOpacity(0.4)
                              : Colors.red.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          event.status.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: event.status == 'ACTIVE'
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Fechas
                  /*Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 18, color: Colors.blue),
                      const SizedBox(width: 4),
                      Text(
                        'Inicio: ${SHARED.Utils.formatearFechaEspanol(event.openingDate) }',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.event, size: 18, color: Colors.blue),
                      const SizedBox(width: 4),
                      Text(
                        'Fin: ${event.endDate.toLocal()}'.split(' ')[0],
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),*/
                  const SizedBox(height: 8),

                  // Descripción
                  Text(
                    event.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),

            // Botón de acción

          ],
        ),
      ),
    );
  }
}
