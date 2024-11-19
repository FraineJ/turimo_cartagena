abstract class PlaceRepository {

  Future getPlaceByCategory(String id);

  Future addPlaceFavorite(int id);

  Future addPlaceFavoriteByUser();

}