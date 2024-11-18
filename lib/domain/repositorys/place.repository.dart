abstract class PlaceRepository {

  Future getPlaceByCategory(int id);

  Future addPlaceFavorite(int id);

  Future addPlaceFavoriteByUser();

}