import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_cartagena/article_injection.dart';
import 'package:turismo_cartagena/domain/models/partner.model.dart';
import 'package:turismo_cartagena/generated/l10n.dart';
import 'package:turismo_cartagena/presentation/bloc/initial-bloc/initial_bloc.dart';
import 'package:turismo_cartagena/presentation/bloc/partner/partner_bloc.dart';
import 'package:turismo_cartagena/presentation/global/widgets/all-widgets.dart' as Widgets;
import 'package:turismo_cartagena/presentation/modules/partner/widgets/card-partner.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => InitialBloc(sl())..add(AppInitialEvent()),
            ),
            BlocProvider(
              create: (context) => PartnerBloc(sl()),
            ),
          ],
          child: BlocListener<PartnerBloc, PartnersState>(
            listener: (context, state) {
              if (state is FavoritesUpdated) {
                setState(() {});
                context.read<PartnerBloc>().add(GetPartnerFavoriteByUserEvent());
              }
            },
            child: BlocBuilder<InitialBloc, InitialState>(
              builder: (context, state) {
                if (state is IsAuthenticatedSuccess) {
                  // Llamar al evento para obtener favoritos inicialmente
                  context.read<PartnerBloc>().add(GetPartnerFavoriteByUserEvent());

                  return BlocBuilder<PartnerBloc, PartnersState>(
                    builder: (context, partnerState) {
                      if (partnerState is LoadingGetPartnerFavoriteByUser) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (partnerState is SuccessGetPartnerFavoriteByUser) {
                        return _buildFavoriteList(partnerState.partnerResponse);
                      } else if (partnerState is ErrorGetPartnerFavoriteByUser) {
                        return _buildErrorOrEmptyView(
                          title: S.current.Favorites,
                          description: S.current.login_view_favorites_place,
                          icon: Icons.favorite,
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                } else if (state is IsAuthenticatedFailure) {
                  return _buildErrorOrEmptyView(
                    title: S.current.Favorites,
                    description: S.current.login_for_create_favorites,
                    icon: Icons.lock,
                    customWidget: Widgets.RequestLogin(
                      title: S.current.login_view_favorites,
                      description: S.current.login_for_create_favorites,
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  /// Construye la lista de favoritos
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
              final PartnersModel partner = PartnersModel.fromJson(
                partnerResponse[index]["partner"],
              );
              return PropertyCard(
                partner: partner,
                autoPlay: false,
              );
            },
          ),
        ),
      ],
    );
  }

  /// Construye una vista para errores o listas vacías
  Widget _buildErrorOrEmptyView({
    required String title,
    required String description,
    required IconData icon,
    Widget? customWidget,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Widgets.AppBarCustom(
            textTitle: title,
            botonVolver: false,
          ),
          customWidget ??
              Widgets.NoDataWidget(
                icon: icon,
                title: title,
                description: description,
              ),
        ],
      ),
    );
  }
}
