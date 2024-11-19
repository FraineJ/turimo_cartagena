import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_cartagena/article_injection.dart';
import 'package:turismo_cartagena/domain/models/partner.model.dart';
import 'package:turismo_cartagena/presentation/bloc/partner/partner_bloc.dart';
import 'package:turismo_cartagena/presentation/modules/partner/partner-detail.dart';



class PartnerCardMap extends StatelessWidget {
  final PartnersModel partner;
  final bool autoPlay;
  bool isFavorite = false;
  PartnerCardMap({super.key, required this.partner, required this.autoPlay, this.isFavorite = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PartnerBloc(sl()),
        child: PlaceCardView(partner: partner, autoPlay:  autoPlay, isFavorite: isFavorite)
    );
  }
}

class PlaceCardView extends StatefulWidget {
  final PartnersModel partner;
  final bool autoPlay;
  bool isFavorite = false;
  PlaceCardView({super.key, required this.partner, required this.autoPlay, this.isFavorite = false});

  @override
  _PlaceCardState createState() => _PlaceCardState(partner: partner, autoPlay:  autoPlay, isFavorite: isFavorite );
}

class _PlaceCardState extends State<PlaceCardView> {
  final PartnersModel partner;
  bool autoPlay = false;
  bool isFavorite = false;
  _PlaceCardState({required this.partner, required this.autoPlay, this.isFavorite = false});

  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)  => PartnerDetailScreen(partners: partner)));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height / 4,
                    autoPlay: autoPlay,
                    autoPlayInterval: Duration(seconds: 2),
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: partner.imagesUrl!.isNotEmpty
                      ? partner.imagesUrl!.map((image) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Image.network(
                          image ?? "https://static.vecteezy.com/system/resources/previews/004/141/669/non_2x/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg",
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
                  top: 20,
                  right: 20,
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      //final event = AddPlaceFavoriteEvent(id: partner.id);
                      //context.read<PlacesBloc>().add(event);

                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                  ),
                ),
                Positioned(
                  bottom: 10.0,
                  left: 0.0,
                  right: 0.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: partner.imagesUrl!.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => setState(() {
                          _currentIndex = entry.key;
                        }),
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Colors.white).withOpacity(_currentIndex == entry.key ? 0.9 : 0.4),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    partner.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    partner.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
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
