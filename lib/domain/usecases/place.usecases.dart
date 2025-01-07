
import 'package:turismo_cartagena/domain/models/place.model.dart';
import 'package:turismo_cartagena/domain/repositorys/place.repository.dart';

class PlaceCaseUse {

  final PlaceRepository _placeRepository;
  PlaceCaseUse(this._placeRepository);

  Future getAllPlaceByCategory() async{
    return await _placeRepository.getAllPlaceByCategory();
  }

  Future getPlaceByCategory(String id) async{
    return await _placeRepository.getPlaceByCategory(id);
  }

  Future addPlaceFavorite(int id) async{
    return await _placeRepository.addPlaceFavorite(id);
  }

  Future<List<PlaceModel>> getPlaceFavoriteByUser() async{
    return await _placeRepository.addPlaceFavoriteByUser();
  }
}