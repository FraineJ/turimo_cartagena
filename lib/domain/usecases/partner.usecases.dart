
import 'package:turismo_cartagena/domain/repositorys/partner.repository.dart';

class PartnerCaseUse {

  final PartnerRepository _partnerRepository;
  PartnerCaseUse(this._partnerRepository);

  Future getPlaceByCategory(String id) async{
    return await _partnerRepository.getPartnerByCategory(id);
  }

  Future addPlaceFavorite(int id) async{
    return await _partnerRepository.addPartnerFavorite(id);
  }

  Future getPlaceFavoriteByUser() async{
    return await _partnerRepository.addPartnerFavoriteByUser();
  }
}