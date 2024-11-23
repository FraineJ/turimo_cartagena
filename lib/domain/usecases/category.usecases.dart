import 'package:turismo_cartagena/domain/repositorys/category.repository.dart';

class CategoryCaseUse {

  final CategoryRepository _categoryRepository;
  CategoryCaseUse(this._categoryRepository);

  Future getAllCategory() async{
    return await _categoryRepository.getAllCategory();
  }
}