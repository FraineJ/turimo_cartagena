import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:turismo_cartagena/domain/models/place.model.dart';
import 'package:turismo_cartagena/domain/models/respose.model.dart';
import 'package:turismo_cartagena/domain/usecases/place.usecases.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  final PlaceCaseUse placeCaseUse;
  PlacesBloc(this.placeCaseUse) : super(PlacesInitial()) {
    on<GetAllPlaceByCategoryEvent>(_getAllPlace);
    on<AddPlaceFavoriteEvent>(_addPlaceFavorite);
    on<GetPlaceFavoriteByUserEvent>(_getPlaceFavoriteByUser);
  }


  Future _getAllPlace(GetAllPlaceByCategoryEvent event, Emitter<PlacesState> emit) async {
    emit(LoadingGetPlaceByCategory());

    try {
      final ResponsePages response = await placeCaseUse.getAllPlaceByCategory();

      if (response.data.isNotEmpty) {
        List<PlaceModel> place = response.data.map((jsonData) => PlaceModel.fromJson(jsonData))
        .toList();

        emit(SuccessGetPlaceByCategory(placeModel: place));
      } else {
        emit(ErrorGetPlaceByCategory());
      }
    } catch (error) {
      print("response ${error}");
      emit(ErrorGetPlaceByCategory());
    }
  }

  Future _addPlaceFavorite(AddPlaceFavoriteEvent event, Emitter<PlacesState> emit) async {
    emit(LoadingAddPlaceFavorite());

    try {
      final bool response = await placeCaseUse.addPlaceFavorite(event.id);

      if (response) {
        emit(SuccessAddPlaceFavorite(response: response));
      } else {
        emit(ErrorAddPlaceFavorite(response: response));
      }
    } catch (error) {
      emit(ErrorServeAddPlaceFavorite(message: error.toString()));
    }
  }

  Future _getPlaceFavoriteByUser(GetPlaceFavoriteByUserEvent event, Emitter<PlacesState> emit) async {
    emit(LoadingGetPlaceFavoriteByUser());

    final List<PlaceModel> response = await placeCaseUse.getPlaceFavoriteByUser();

    if (response.isNotEmpty) {

      emit(SuccessGetPlaceFavoriteByUser(placeModel: response));
    } else {
      emit(ErrorGetPlaceFavoriteByUser());
    }
  }

}
