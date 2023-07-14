import 'dart:convert';

import 'package:http/http.dart' as http;

class LandPad {
  final String id;
  final String name;
  final String fullName;
  final String status;
  final String? locality;
  final String? region;
  final String? details;
  LandPad(
      {required this.id,
      required this.fullName,
      this.locality,
      this.region,
      this.details,
      required this.name,
      required this.status});

  static Future<LandPad> fetchLandPad(String id) async {
    try {
      final response = await http
          .get(Uri.parse('https://api.spacexdata.com/v4/landpads/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return LandPad(
          id: jsonResponse['id'],
          name: jsonResponse['name'],
          fullName: jsonResponse['full_name'],
          status: jsonResponse['status'],
          locality: jsonResponse['locality'],
          region: jsonResponse['region'],
          details: jsonResponse['details'],
        );
      } else {
        throw Exception('Failed to load landpad');
      }
    } catch (error) {
      throw Exception('Failed to load landpad: $error');
    }
  }
}
