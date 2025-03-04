part of 'places_bloc.dart';

@immutable
sealed class PlacesEvent {
  const PlacesEvent();
}

class InitialPlaceEvent extends PlacesEvent{}

class GetAllPlaceByCategoryEvent extends PlacesEvent{
  const GetAllPlaceByCategoryEvent(): super();
}


class GetPlaceByCategoryEvent extends PlacesEvent{
  final String id;
  const GetPlaceByCategoryEvent({required this.id}): super();
}

//EVENT ADD PLACE TO FAVORITE
class AddPlaceFavoriteEvent extends PlacesEvent{
  final int id;
  const AddPlaceFavoriteEvent({required this.id}): super();
}


//GET PLACE FAVORITE BY USER
class GetPlaceFavoriteByUserEvent extends PlacesEvent{
  const GetPlaceFavoriteByUserEvent(): super();
}