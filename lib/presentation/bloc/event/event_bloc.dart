import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:turismo_cartagena/domain/models/event.model.dart';
import 'package:turismo_cartagena/domain/usecases/event.usecases.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventCaseUse eventCaseUse;
  EventBloc(this.eventCaseUse) : super(EventInitial()) {
    on<GetEventEvent>(_getAllEvent);
  }

  Future _getAllEvent(GetEventEvent event, Emitter<EventState> emit) async {
    emit(LoadingGetEvent());

    try {
      final List<EventModel> response = await eventCaseUse.getAllCategory();
      if (response.isNotEmpty) {
        emit(SuccessGetEvent(events: response));
      } else {
        emit(ErrorGetEvent());
      }
    } catch (error) {
      emit(ErrorGetEvent());
    }
  }
}
