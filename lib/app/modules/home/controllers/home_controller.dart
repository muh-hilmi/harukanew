import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController extends GetxController {
  Future fetchData() async {
    final response = await http
        .get(Uri.parse('https://haruka2022.com/api_controller/get_apg_data'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      // final status = data['status'];
      final agendaList = data['data'][0];
      return agendaList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
