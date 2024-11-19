import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';



class SpacesHeaderAppBar extends StatefulWidget {

  final List imagenes;
  const SpacesHeaderAppBar({super.key, required this.imagenes});

  @override
  State<SpacesHeaderAppBar> createState() => _SpacesHeaderAppBarState();
}

class _SpacesHeaderAppBarState extends State<SpacesHeaderAppBar> {

  int _currentIndex = 0;
  bool _isLiked = false;



  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 250,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        stretchModes: [StretchMode.zoomBackground],
        background: Stack(
          fit: StackFit.expand,
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
              items: widget.imagenes!.isNotEmpty
                  ? widget.imagenes!.map((image) {
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
                top: 30,
                left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ),
            Positioned(
                top: 30,
                right: 10,
                child: IconButton(
                  icon: Icon(
                    _isLiked ? Icons.favorite : Icons.favorite_border,
                    color: _isLiked ? Colors.red : Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      _isLiked = !_isLiked;
                    });
                  },
                )
            )
          ],
        ),
      ),
    );
  }
}
