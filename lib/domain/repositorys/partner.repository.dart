abstract class PartnerRepository {

  Future getPartnerByCategory(String id);

  Future addPartnerFavorite(String id);

  Future getPartnerFavoriteByUser();

}