import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:turismo_cartagena/core/di/article_injection.dart';
import 'package:turismo_cartagena/domain/models/partner.model.dart';
import 'package:turismo_cartagena/generated/l10n.dart';
import 'package:turismo_cartagena/presentation/bloc/initial-bloc/initial_bloc.dart';
import 'package:turismo_cartagena/presentation/bloc/partner/partner_bloc.dart';
import 'package:turismo_cartagena/core/widgets/all-widgets.dart'
as Widgets;
import 'package:turismo_cartagena/presentation/modules/partner/partner-detail.dart';
import 'package:turismo_cartagena/core/utils/all.dart' as SHARED;

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  bool isAuth = false;

  Future<Position?> _getCurrentLocation() async {
    try {
      return await SHARED.Utils.getPositionCurrent();
    } catch (_) {
      return null;
    }
  }

  void _toggleFavorite(BuildContext context, PartnersModel partner) {
    if (!isAuth) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Para agregar este negocio a favoritos debe iniciar sesión",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    context.read<PartnerBloc>().add(AddPartnerFavoriteEvent(id: partner.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => InitialBloc()..add(AppInitialEvent())),
            BlocProvider(create: (_) => PartnerBloc(sl())),
          ],
          child: BlocBuilder<InitialBloc, InitialState>(
            builder: (context, state) {
              if (state.isLoginApp) {
                isAuth = true;
                context.read<PartnerBloc>().add(GetPartnerFavoriteByUserEvent());
                return _buildPartnerBloc();
              } else  {
                isAuth = false;
                return _buildErrorOrEmptyView(
                  title: S.current.Favorites,
                  description: S.current.login_for_create_favorites,
                  icon: Icons.lock,
                  customWidget: Widgets.RequestLogin(
                    title: S.current.login_view_favorites,
                    description: S.current.login_for_create_favorites,
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }


  Widget _buildPartnerBloc() {
    return BlocBuilder<PartnerBloc, PartnersState>(
      builder: (context, partnerState) {
        if (partnerState is LoadingGetPartnerFavoriteByUser ||
            partnerState is LoadingAddPartnerFavorite) {
          return const Center(child: CircularProgressIndicator());
        } else if (partnerState is SuccessGetPartnerFavoriteByUser) {
          return _buildFavoriteList(partnerState.partnerResponse);
        } else if (partnerState is SuccessDeletePartnerFavorite) {

          context.read<PartnerBloc>().add(GetPartnerFavoriteByUserEvent());
          return const Center(child: CircularProgressIndicator());
        } else if (partnerState is ErrorAddPartnerFavorite ||
            partnerState is ErrorGetPartnerFavoriteByUser) {
          return _buildErrorOrEmptyView(
            title: S.current.Favorites,
            description: S.current.login_view_favorites_place,
            icon: Icons.favorite,
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }


  Widget _buildFavoriteList(List<dynamic> partnerResponse) {
    if (partnerResponse.isEmpty) {
      return _buildErrorOrEmptyView(
        title: S.current.Favorites,
        description: S.current.login_view_favorites_place,
        icon: Icons.favorite,
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Widgets.AppBarCustom(
            textTitle: S.current.Favorites,
            botonVolver: false,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: partnerResponse.length,
            itemBuilder: (context, index) {
              final partner = PartnersModel.fromJson(partnerResponse[index]["partner"]);
              return GestureDetector(
                onTap: () {

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider(
                        create: (context) => PartnerBloc(sl()),
                        child: PartnerDetailScreen(partners: partner)
                    ),
                  ));
                },
                child: CardPartner(
                  partner: partner,
                  onFavoriteToggle: () => _toggleFavorite(context, partner),
                  getCurrentLocation: _getCurrentLocation,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildErrorOrEmptyView({
    required String title,
    required String description,
    required IconData icon,
    Widget? customWidget,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),

      child: Column(
        children: [
          Widgets.AppBarCustom(textTitle: title, botonVolver: false),
          Expanded(
            child: customWidget ??
                Widgets.NoDataWidget(
                  svgPath: "assets/images/heart.svg",
                  title: title,
                  description: description,
                ),
          ),
        ],
      ),
    );
  }
}



class CardPartner extends StatelessWidget {
  final PartnersModel partner;
  final VoidCallback onFavoriteToggle;
  final Future<Position?> Function() getCurrentLocation;

  const CardPartner({
    required this.partner,
    required this.onFavoriteToggle,
    required this.getCurrentLocation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
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
                color: Colors.grey.withOpacity(0.2),
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(partner.imagesUrl.isNotEmpty ? partner.imagesUrl.first : ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
          // Botón de favoritos
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: onFavoriteToggle,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  partner.favorite ? Icons.favorite : Icons.favorite_border , // Aquí deberías manejar el estado de favorito
                  color: partner.favorite ?  Colors.red :  Colors.black54,
                ),
              ),
            ),
          ),
          // Información del socio
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
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
                  const SizedBox(height: 5),
                  Text(
                    SHARED.Utils.truncateText(partner.address, 40),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Rating
                      Row(
                        children: const [
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
                      // Ubicación
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.redAccent, size: 16),
                          const SizedBox(width: 8),
                          FutureBuilder<Position?>(
                            future: getCurrentLocation(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError || snapshot.data == null) {
                                return const Text("Ubicación no disponible");
                              } else {
                                final position = snapshot.data!;
                                return Text(
                                  "${SHARED.Utils.haversineDistanceString(
                                      position.latitude, position.longitude, partner.latitud, partner.longitud
                                  )} de distancia",
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                );
                              }
                            },
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
    );
  }
}
