import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:turismo_cartagena/presentation/modules/places/widgets/card-services.dart';

import '../../../domain/models/place.model.dart';

class PlaceDetailScreen extends StatefulWidget {
  final PlaceModel place;

  const PlaceDetailScreen({super.key, required this.place});

  @override
  _PlaceDetailScreenState createState() => _PlaceDetailScreenState(place: place);
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  final PlaceModel place;

  _PlaceDetailScreenState({required this.place});


  int _currentIndex = 0;
  bool _isLiked = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Lugar'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 300,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: place.imagesUrl!.isNotEmpty
                      ? place.imagesUrl!.map((image) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Image.network(
                          place.imagesUrl!.first,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        );
                      },
                    );
                  }).toList()
                      : [
                    Builder(
                      builder: (BuildContext context) {
                        return Image.asset(
                          "assets/images/no-photo.jpg",
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        );
                      },
                    ),
                  ],

                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${_currentIndex + 1} / ${place.imagesUrl!.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
             Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${place.name}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Cartagena, colombia',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text("${place.address}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  //const SizedBox(height: 8),
                  /*const Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 20),
                      SizedBox(width: 4),
                      Text(
                        '5.0',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '1 evaluación',
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),*/
                  const Divider(height: 32),
                  const Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/no-image.png'),
                        radius: 30,
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Anfitrión: Gooway',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Diseñador',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(height: 32),

                  const SizedBox(height: 8),
                  Text("${place.description}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  /*const Text("Servicios",
                    style:  TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    height: 310, // Set an appropriate height
                    child: ListView.builder(
                      itemCount: place.imagesUrl!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CardServices(services: place.imagesUrl![index]);
                      },
                    ),
                  ),*/



                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
