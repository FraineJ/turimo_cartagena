
import 'package:turismo_cartagena/domain/repositorys/place.repository.dart';

class PlaceCaseUse {

  final PlaceRepository _placeRepository;
  PlaceCaseUse(this._placeRepository);

  Future getPlaceByCategory(int id) async{
    return await _placeRepository.getPlaceByCategory(id);
  }

  Future addPlaceFavorite(int id) async{
    return await _placeRepository.addPlaceFavorite(id);
  }

  Future getPlaceFavoriteByUser() async{
    return await _placeRepository.addPlaceFavoriteByUser();
  }
}