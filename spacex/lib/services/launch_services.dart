import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/launch_model.dart';

class LaunchService {
  Future<Launch> fetchLatestLaunch() async {
    final response = await http
        .get(Uri.parse('https://api.spacexdata.com/v4/launches/latest'));

    if (response.statusCode == 200) {
      return Launch.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load launch');
    }
  }
}
