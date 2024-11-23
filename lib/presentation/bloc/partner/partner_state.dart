part of 'partner_bloc.dart';

@immutable
sealed class PartnersState {}

final class PartnersInitial extends PartnersState {}

//GET CATEGORY STATE
class LoadingGetPartnerByCategory extends PartnersState {}

class SuccessGetPartnerByCategory extends PartnersState {

  final List<PartnersModel> partnerModel;
  SuccessGetPartnerByCategory({required this.partnerModel} );

  @override
  List<Object> get props => [partnerModel];
}

class ErrorGetPartnerByCategory extends PartnersState {}

// ADD Partner TO FAVORITE STATE
class LoadingAddPartnerFavorite extends PartnersState {}

class SuccessAddPartnerFavorite extends PartnersState {
  final bool response;
  SuccessAddPartnerFavorite({required this.response} );
}

class ErrorAddPartnerFavorite extends PartnersState {
  final bool response;
  ErrorAddPartnerFavorite({required this.response} );
}

class ErrorServeAddPartnerFavorite extends PartnersState {
  final String message;
  ErrorServeAddPartnerFavorite({required this.message} );
}

//GET Partner  FAVORITE BY USER STATE
class LoadingGetPartnerFavoriteByUser extends PartnersState {}

class SuccessGetPartnerFavoriteByUser extends PartnersState {
  final List partnerResponse;
  SuccessGetPartnerFavoriteByUser({required this.partnerResponse} );

  @override
  List<Object> get props => [partnerResponse];
}

class ErrorGetPartnerFavoriteByUser extends PartnersState {
}
