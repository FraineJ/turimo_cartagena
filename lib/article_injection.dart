
import 'package:get_it/get_it.dart';
import 'package:turismo_cartagena/domain/repositorys/auth.repository.dart';
import 'package:turismo_cartagena/domain/repositorys/category.repository.dart';
import 'package:turismo_cartagena/domain/repositorys/device_user.repository.dart';
import 'package:turismo_cartagena/domain/repositorys/event.repository.dart';
import 'package:turismo_cartagena/domain/repositorys/partner.repository.dart';
import 'package:turismo_cartagena/domain/repositorys/place.repository.dart';
import 'package:turismo_cartagena/domain/usecases/auth.usecases.dart';
import 'package:turismo_cartagena/domain/usecases/category.usecases.dart';
import 'package:turismo_cartagena/domain/usecases/device-user.usecases.dart';
import 'package:turismo_cartagena/domain/usecases/event.usecases.dart';
import 'package:turismo_cartagena/domain/usecases/partner.usecases.dart';
import 'package:turismo_cartagena/domain/usecases/place.usecases.dart';
import 'package:turismo_cartagena/infrastructure/services/http_category.service.dart';
import 'package:turismo_cartagena/infrastructure/services/http_device_user.service.dart';
import 'package:turismo_cartagena/infrastructure/services/http_event.service.dart';
import 'package:turismo_cartagena/infrastructure/services/http_login.service.dart';
import 'package:turismo_cartagena/infrastructure/services/http_partner.service.dart';
import 'package:turismo_cartagena/infrastructure/services/http_place.service.dart';


final sl = GetIt.instance;

initArticlesInjections() {
  sl.registerLazySingleton<AuthCaseUse>(
      () => AuthCaseUse(sl<AbstractAuthRepository>()));
  sl.registerLazySingleton<AbstractAuthRepository>(() => HttpLoginService());

  sl.registerLazySingleton<CategoryCaseUse>(
          () => CategoryCaseUse(sl<CategoryRepository>()));
  sl.registerLazySingleton<CategoryRepository>(() => HttpCategoryService());

  sl.registerLazySingleton<PlaceCaseUse>(
          () => PlaceCaseUse(sl<PlaceRepository>()));
  sl.registerLazySingleton<PlaceRepository>(() => HttpPlaceService());

  sl.registerLazySingleton<PartnerCaseUse>(
          () => PartnerCaseUse(sl<PartnerRepository>()));
  sl.registerLazySingleton<PartnerRepository>(() => HttpPartnerService());

  sl.registerLazySingleton<EventCaseUse>(
          () => EventCaseUse(sl<EventRepository>()));
  sl.registerLazySingleton<EventRepository>(() => HttpEventsService());


  sl.registerLazySingleton<DeviceUserCaseUse>(
          () => DeviceUserCaseUse(sl<DeviceUserRepository>()));
  sl.registerLazySingleton<DeviceUserRepository>(() => HttpDeviceUserService());
}
