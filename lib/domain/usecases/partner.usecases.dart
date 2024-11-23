
import 'package:turismo_cartagena/domain/repositorys/partner.repository.dart';

class PartnerCaseUse {

  final PartnerRepository _partnerRepository;
  PartnerCaseUse(this._partnerRepository);

  Future getPartnerByCategory(String id) async{
    return await _partnerRepository.getPartnerByCategory(id);
  }

  Future addPartnerFavorite(String id) async{
    return await _partnerRepository.addPartnerFavorite(id);
  }

  Future getPartnerFavoriteByUser() async{
    return await _partnerRepository.getPartnerFavoriteByUser();
  }
}