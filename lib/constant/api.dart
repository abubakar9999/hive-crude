import 'dart:convert';

import 'package:hive_crud_api_model/models/model.dart';
import 'package:http/http.dart' as http;

class Api {
  List<Model> data = [];
  Future<List<Model>> fatchData() async {
    var url = 'https://fakestoreapi.com/products';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<Model> data = modelFromJson(response.body);
      print("all Data decode: $data");
      return data;
    } else {
      print("Datas Problem");
      return data;
    }
  }
}
