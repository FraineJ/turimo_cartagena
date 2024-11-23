import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_cartagena/article_injection.dart';
import 'package:turismo_cartagena/domain/models/partner.model.dart';
import 'package:turismo_cartagena/generated/l10n.dart';
import 'package:turismo_cartagena/presentation/bloc/initial-bloc/initial_bloc.dart';
import 'package:turismo_cartagena/presentation/bloc/partner/partner_bloc.dart';
import 'package:turismo_cartagena/presentation/bloc/places/places_bloc.dart';
import 'package:turismo_cartagena/presentation/global/widgets/all-widgets.dart' as Widgets;
import 'package:turismo_cartagena/presentation/modules/partner/widgets/card-partner.dart';
import 'package:turismo_cartagena/presentation/modules/places/widgets/card-places.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => InitialBloc(sl())..add(AppInitialEvent()),
              ),
              BlocProvider(
                create: (context) => PartnerBloc(sl()),
              ),
            ],
            child: BlocBuilder<InitialBloc, InitialState>(
              builder: (context, state) {
                if (state is IsAuthenticatedSuccess) {
                  // Si el usuario está autenticado, solicitamos los lugares favoritos.
                  context.read<PartnerBloc>().add(GetPartnerFavoriteByUserEvent());

                  return BlocBuilder<PartnerBloc, PartnersState>(
                    builder: (context, state) {
                      if(state is LoadingGetPlaceFavoriteByUser) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is SuccessGetPartnerFavoriteByUser) {
                        if (state.partnerResponse.isNotEmpty) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Widgets.AppBarCustom(textTitle: S.current.Favorites, botonVolver: false),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: state.partnerResponse.length,
                                  itemBuilder: (context, index) {
                                    final PartnersModel partner = PartnersModel.fromJson(state.partnerResponse[index]["partner"]);
                                    return PropertyCard(partner: partner ,autoPlay: false,);
                                  },
                                ),
                              ),
                            ],
                          );
                        }
                      } else if (state is ErrorGetPlaceFavoriteByUser) {
                        return  Column(
                          children: [
                            Widgets.AppBarCustom(textTitle: S.current.Favorites, botonVolver: false),
                            Widgets.NoDataWidget(
                              icon: Icons.favorite,
                              title: S.current.Favorites,
                              description: S.current.login_view_favorites_place,
                            ),
                          ],
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                } else if (state is IsAuthenticatedFailure) {
                  return  Column(
                    children: [
                      Widgets.AppBarCustom(textTitle: S.current.Favorites, botonVolver: false),
                      Widgets.RequestLogin(
                        title: S.current.login_view_favorites,
                        description: S.current.login_for_create_favorites,
                      ),
                    ],
                  );
                } else {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
