import 'dart:convert';

import 'package:covid19_vaccines_app/model/administration_data.dart';
import 'package:covid19_vaccines_app/model/latest_data.dart';
import 'package:http/http.dart' as http;

const BASE_URL = "http://178.62.18.137:3000";

class Webservice {
  Future<LatestData> fetchLatestData() async {
    final url = "$BASE_URL/latestData";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      LatestData latestData = LatestData.fromJson(body);
      return latestData;
    } else {
      throw Exception("Error when performing request!");
    }
  }

  Future<List<AdministrationData>> fetchAdministrationData(String area) async {
    final url = "$BASE_URL/administrationData/$area";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Iterable body = jsonDecode(response.body);
      return body.map((e) => AdministrationData.fromJson(e)).toList();
    } else {
      throw Exception("Error when performing request!");
    }
  }
}
