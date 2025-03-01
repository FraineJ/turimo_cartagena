import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:turismo_cartagena/domain/models/event.model.dart';
import 'package:turismo_cartagena/presentation/modules/events/pages/events-detail.dart';
import 'package:turismo_cartagena/core/widgets/all-widgets.dart' as GLOBAL;

import '../widgets/card-video-event.dart';
import '../widgets/skeleton-image-event.dart';
import '../widgets/tag-date-event.dart';

class EventView extends StatefulWidget {
  final EventModel event;

  const EventView({Key? key, required this.event}) : super(key: key);

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EventDetailScreen(
                    event: widget.event,
                  )),
        );
      },
      child: Card(
        elevation: 1,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Stack(
                children: [
                  CarouselSlider(
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
                      List<Widget> mediaList = [];
                      bool hasVideo = widget.event.video == true;
                      bool hasImages = widget.event.imagesUrl != null && widget.event.imagesUrl!.isNotEmpty;

                      // Agregar el video en la posición 0 si existe
                      if (hasVideo) {
                        mediaList.add(
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            child: const VideoPlayerWidget(
                              videoUrl: 'https://mediamaratondelmar.com/cdn/shop/videos/c/vp/c7ef9ef2351b4a7daefff29c5eea8db8/c7ef9ef2351b4a7daefff29c5eea8db8.HD-1080p-7.2Mbps-25113547.mp4?v=0',
                            ),
                          ),
                        );
                      }

                      // Agregar imágenes a partir de la posición 1 si hay video, de lo contrario, desde la posición 0
                      if (hasImages) {
                        List<String> images = widget.event.video == true
                            ? widget.event.imagesUrl!.sublist(1) // Si hay video, empieza en la posición 1
                            : widget.event.imagesUrl!; // Si no hay video, empieza en 0

                        List<Widget> imagesList = images.map((image) {
                          return ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: image,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: SkeletonImageCartEven(width: double.infinity),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                "assets/images/no-photo.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList();

                        mediaList.addAll(imagesList);
                      }


                      // Si no hay video ni imágenes, agregar imagen por defecto
                      if (mediaList.isEmpty) {
                        mediaList.add(
                          Image.asset(
                            "assets/images/no-photo.jpg",
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                        );
                      }

                      return mediaList;
                    }(),
                  ),
                  Positioned(
                    bottom: 10.0,
                    left: 0.0,
                    right: 0.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          widget.event.imagesUrl!.asMap().entries.map((entry) {
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
                                  _currentIndex == entry.key ? 0.9 : 0.4),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                   const Positioned(
                        top: 10,
                        left: 16,
                        child: DateTagEvent()

                   )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.event.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 18,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          widget.event.address,
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: widget.event.status == 'ACTIVE'
                              ? Colors.green.withOpacity(0.4)
                              : Colors.red.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.event.status.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: widget.event.status == 'ACTIVE'
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.event.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
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
