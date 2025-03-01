import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:turismo_cartagena/domain/models/category.model.dart';
import 'dart:convert';
import 'package:turismo_cartagena/domain/repositorys/category.repository.dart';
import 'package:turismo_cartagena/core/environments/environment.dart';

class HttpCategoryService extends CategoryRepository {
  @override
  Future getAllCategory() async {


    final environment = await Environment.forEnvironment('environment-dev');
    String apiUrl  = "${environment.baseUrl}/categories/listar";


    try {
      final response = await http.get(
          Uri.parse(apiUrl)
      ).timeout(Duration(seconds: 20));

      final body = jsonDecode(response.body);
      final List<dynamic> jsonDataList = body["data"] as List<dynamic>;
      final List<CategoryModel> category = jsonDataList.map((jsonData) => CategoryModel.fromJson(jsonData)).toList();

      print("response $response");

      if(response.statusCode == 200) {
        return category;
      }

      return [];

    } on TimeoutException {
      return [];
    }
    catch (error) {
      print("response $error");

      return error;
    }
  }
}
