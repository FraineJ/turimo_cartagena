import 'package:turismo_cartagena/domain/models/place.model.dart';

abstract class PlaceRepository {

  Future getAllPlaceByCategory();


  Future getPlaceByCategory(String id);

  Future addPlaceFavorite(int id);

  Future<List<PlaceModel>> addPlaceFavoriteByUser();

}