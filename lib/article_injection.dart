
import 'package:get_it/get_it.dart';
import 'package:turismo_cartagena/domain/repositorys/auth.repository.dart';
import 'package:turismo_cartagena/domain/repositorys/category.repository.dart';
import 'package:turismo_cartagena/domain/repositorys/place.repository.dart';
import 'package:turismo_cartagena/domain/usecases/auth.usecases.dart';
import 'package:turismo_cartagena/domain/usecases/category.usecases.dart';
import 'package:turismo_cartagena/domain/usecases/place.usecases.dart';
import 'package:turismo_cartagena/infrastructure/services/http_category.service.dart';
import 'package:turismo_cartagena/infrastructure/services/http_login.service.dart';
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


}
