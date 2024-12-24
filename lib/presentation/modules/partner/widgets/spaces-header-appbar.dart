import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_cartagena/domain/models/partner.model.dart';
import 'package:turismo_cartagena/presentation/bloc/initial-bloc/initial_bloc.dart';
import 'package:turismo_cartagena/presentation/bloc/partner/partner_bloc.dart';
import 'package:turismo_cartagena/presentation/global/utils/all.dart' as SHARED;

class SpacesHeaderAppBar extends StatefulWidget {
  PartnersModel partners;
  SpacesHeaderAppBar({super.key, required this.partners});

  @override
  State<SpacesHeaderAppBar> createState() => _SpacesHeaderAppBarState();
}

class _SpacesHeaderAppBarState extends State<SpacesHeaderAppBar> {
  int _currentIndex = 0;

  void _toggleFavorite(BuildContext context, bool isAuth) {
    if (!isAuth) {
      SHARED.Utils.showSnackBar(
        context,
        "Para agregar este negocio a favoritos debe iniciar sesión",
        Colors.redAccent,
      );
      return;
    }

    setState(() {
      widget.partners.favorite = !widget.partners.favorite;
    });

    final event = AddPartnerFavoriteEvent(id: widget.partners.id);
    context.read<PartnerBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PartnerBloc, PartnersState>(
      listener: (context, state) {
        if (state is SuccessAddPartnerFavorite) {
          SHARED.Utils.showSnackBar(context, "Se ha agregado el negocio a tus favoritos", Colors.green);
        }

        if (state is SuccessDeletePartnerFavorite) {
          SHARED.Utils.showSnackBar(context, "Has eliminado el negocio de tus favoritos", Colors.red);
        }
      },
      child: BlocBuilder<InitialBloc, InitialState>(
        builder: (context, state) {
          final isAuth = state.isLoginApp;
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
                    items: widget.partners.imagesUrl!.isNotEmpty
                        ? widget.partners.imagesUrl!.map((image) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Image.network(
                                  image ??
                                      "https://static.vecteezy.com/system/resources/previews/004/141/669/non_2x/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg",
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
                  _buttonBackPage(context),
                  _buildFavoriteButton(context, isAuth)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFavoriteButton(BuildContext context, bool isAuth) {
    return Positioned(
      top: 30,
      right: 10,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
          ),
          child: IconButton(
            icon: Icon(
              widget.partners.favorite ? Icons.favorite : Icons.favorite_border,
              color: widget.partners.favorite ? Colors.red : Colors.black54,
              size: 28,
            ),
            onPressed: () => _toggleFavorite(context, isAuth),
          )),
    );
  }

  Widget _buttonBackPage(BuildContext context) {
    return Positioned(
        top: 30,
        left: 10,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(32),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 28,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        )
    );
  }

}
