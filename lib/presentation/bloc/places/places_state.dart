part of 'places_bloc.dart';

@immutable
sealed class PlacesState {}

final class PlacesInitial extends PlacesState {}

//GET CATEGORY STATE
class LoadingGetPlaceByCategory extends PlacesState {}

class SuccessGetPlaceByCategory extends PlacesState {

  final List<PlaceModel> placeModel;
  SuccessGetPlaceByCategory({required this.placeModel} );

  @override
  List<Object> get props => [placeModel];
}

class ErrorGetPlaceByCategory extends PlacesState {}

// ADD PLACE TO FAVORITE STATE
class LoadingAddPlaceFavorite extends PlacesState {}

class SuccessAddPlaceFavorite extends PlacesState {
  final bool response;
  SuccessAddPlaceFavorite({required this.response} );
}

class ErrorAddPlaceFavorite extends PlacesState {
  final bool response;
  ErrorAddPlaceFavorite({required this.response} );
}

class ErrorServeAddPlaceFavorite extends PlacesState {
  final String message;
  ErrorServeAddPlaceFavorite({required this.message} );
}

//GET PLACE  FAVORITE BY USER STATE
class LoadingGetPlaceFavoriteByUser extends PlacesState {}

class SuccessGetPlaceFavoriteByUser extends PlacesState {
  final List<PlaceModel> placeModel;
  SuccessGetPlaceFavoriteByUser({required this.placeModel} );

  @override
  List<Object> get props => [placeModel];
}

class ErrorGetPlaceFavoriteByUser extends PlacesState {
}
