part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

//GET CATEGORY STATE
class LoadingGetCategory extends CategoryState {}

class SuccessGetCategory extends CategoryState {

  final List<CategoryModel> categoryModel;
  SuccessGetCategory({required this.categoryModel} );

  @override
  List<Object> get props => [categoryModel];
}

class ErrorGetCategory extends CategoryState {}