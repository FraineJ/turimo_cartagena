import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:turismo_cartagena/domain/models/category.model.dart';
import 'package:turismo_cartagena/domain/usecases/category.usecases.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryCaseUse categoryCaseUse;
  CategoryBloc(this.categoryCaseUse) : super(CategoryInitial()) {
    on<GetCategoryEvent>(_getAllCategory);
  }

  Future _getAllCategory(GetCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(LoadingGetCategory());
    print("Bloc htt");

    try {
      final List<CategoryModel> response = await categoryCaseUse.getAllCategory();
      print("response init");

      if (response.isNotEmpty) {
        emit(SuccessGetCategory(categoryModel: response));
      } else {
        emit(ErrorGetCategory());
      }
    } catch (error) {
      print("response error $error");

      emit(ErrorGetCategory());
    }
  }
}
