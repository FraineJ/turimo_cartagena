import 'package:turismo_cartagena/domain/repositorys/event.repository.dart';

class EventCaseUse {

  final EventRepository _eventRepository;
  EventCaseUse(this._eventRepository);

  Future getAllCategory() async{
    return await _eventRepository.getAllEvents();
  }
}