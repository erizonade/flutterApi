import 'package:crud/config/config.dart';
import 'package:http/http.dart' as http;

import 'package:crud/model/model_list.dart';
import 'package:crud/model/model_detail.dart';

Future<List<Result>> fetchListResep() async {
  var response = await http.get(baseurl + 'recipes');

  if (response.statusCode == 200) {
    // print(response.body);
    final listDataModel = welcomeFromJson(response.body);
    return listDataModel.results;
  } else {
    throw Exception('Gagal Mengambil Data List Resep');
  }
}

Future<List<Result>> fetchSearchResep(String name) async {
  var response = await http.get(baseurl + 'search/?q=' + name);

  if (response.statusCode == 200) {
    print(response.body);
    final listDataModel = welcomeFromJson(response.body);
    return listDataModel.results;
  } else {
    throw Exception('Gagal Mengambil Data List Resep');
  }
}

Future<Details> fetchDetailReseps(String keys) async {
  var response = await http.get(baseurl + 'recipe/' + keys);

  if (response.statusCode == 200) {
    print(response.body);
    final listDetailModel = detailsFromJson(response.body);
    return listDetailModel;
  } else {
    throw Exception('Gagal Mengambil Data List Resep');
  }
}
