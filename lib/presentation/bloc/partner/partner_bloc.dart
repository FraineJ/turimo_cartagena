import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:turismo_cartagena/domain/usecases/partner.usecases.dart';

import '../../../domain/models/partner.model.dart';


part 'partner_event.dart';
part 'partner_state.dart';

class PartnerBloc extends Bloc<PartnerEvent, PartnersState> {
  final PartnerCaseUse partnerCaseUse;
  PartnerBloc(this.partnerCaseUse) : super(PartnersInitial()) {
    on<GetPartnerByCategoryEvent>(_getAllPartner);
    on<AddPartnerFavoriteEvent>(_addPartnerFavorite);
    on<GetPartnerFavoriteByUserEvent>(_getPartnerFavoriteByUser);
  }


  Future _getAllPartner(GetPartnerByCategoryEvent event, Emitter<PartnersState> emit) async {
    emit(LoadingGetPartnerByCategory());

    try {
      final List<PartnersModel> response = await partnerCaseUse.getPartnerByCategory(event.id);
      if (response.isNotEmpty) {
        emit(SuccessGetPartnerByCategory(partnerModel: response));
      } else {
        emit(ErrorGetPartnerByCategory());
      }
    } catch (error) {
      emit(ErrorGetPartnerByCategory());
    }
  }

  Future _addPartnerFavorite(AddPartnerFavoriteEvent event, Emitter<PartnersState> emit) async {
    emit(LoadingAddPartnerFavorite());
    print("(event.id ${event.id}");
    try {
      final response = await partnerCaseUse.addPartnerFavorite(event.id);

      if (response) {
        emit(SuccessAddPartnerFavorite(response: response));
      } else {
        emit(ErrorAddPartnerFavorite(response: response));
      }
    } catch (error) {
      emit(ErrorServeAddPartnerFavorite(message: error.toString()));
    }
  }

  Future _getPartnerFavoriteByUser(GetPartnerFavoriteByUserEvent event, Emitter<PartnersState> emit) async {
    emit(LoadingGetPartnerFavoriteByUser());

    final  response = await partnerCaseUse.getPartnerFavoriteByUser();
    print("partner response ${response}");

    if (response.isNotEmpty) {

      emit(SuccessGetPartnerFavoriteByUser(partnerResponse: response));
    } else {
      emit(ErrorGetPartnerFavoriteByUser());
    }
  }

}
