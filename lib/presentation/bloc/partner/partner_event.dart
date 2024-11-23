part of 'partner_bloc.dart';

@immutable
sealed class PartnerEvent {
  const PartnerEvent();
}

class InitialPartnerEvent extends PartnerEvent{}


class GetPartnerByCategoryEvent extends PartnerEvent{
  final String id;
  const GetPartnerByCategoryEvent({required this.id}): super();
}

//EVENT ADD Partner TO FAVORITE
class AddPartnerFavoriteEvent extends PartnerEvent{
  final String id;
  const AddPartnerFavoriteEvent({required this.id}): super();
}


//GET Partner FAVORITE BY USER
class GetPartnerFavoriteByUserEvent extends PartnerEvent{
  const GetPartnerFavoriteByUserEvent(): super();
}