abstract class PartnerRepository {

  Future getPartnerByCategory(String id);

  Future addPartnerFavorite(int id);

  Future addPartnerFavoriteByUser();

}