import 'package:flutter/material.dart';
import 'package:turismo_cartagena/domain/models/event.model.dart';
import 'package:flutter_tts/flutter_tts.dart';

class EventDetailScreen extends StatelessWidget {
  final EventModel event;

  EventDetailScreen({Key? key, required this.event}) : super(key: key);
  final FlutterTts flutterTts = FlutterTts();



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen principal
            Stack(
              children: [
                Hero(
                  tag: event.id,
                    child: Image.network(
                      event.imagesUrl.first,
                      width: double.infinity,
                      height: 280,
                      fit: BoxFit.cover,
                    ),
                ),
                Positioned(
                  top: 40,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: event.status == 'ACTIVE'
                          ? Colors.green.withOpacity(0.9)
                          : Colors.red.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      event.status.toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: event.status == 'ACTIVE' ? Colors.white : Colors.red,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 40,
                  left: 10,
                  child: GestureDetector(
                    onTap: () =>  Navigator.of(context).pop(),
                    child:  CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.8),
                      child: const  Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),

              ],
            ),


            const SizedBox(height: 16),

            // Contenido del evento
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título
                  Text(
                    event.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Dirección
                  Row(
                    children: [
                      const Icon(
                          Icons.location_on,
                          size: 20, color:
                          Colors.red
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          event.address,
                          style: const TextStyle(fontSize: 16, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Fechas y estado
                  /*Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 20, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        'Inicio: ${event.openingDate}',
                        style: const TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.event, size: 20, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        'Fin: ${event.endDate.toLocal()}'.split(' ')[0],
                        style: const TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),*/

                  // Descripción
                  Text(
                    event.description,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 16),




                ],
              ),
            ),

            const SizedBox(height: 16),


          ],
        ),
      ),
    );
  }

  // Método para construir elementos de detalle
  Widget _buildDetailItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blue),
          const SizedBox(width: 8),
          Text(
            "$title:",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
