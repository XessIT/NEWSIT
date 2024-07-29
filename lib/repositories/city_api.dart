import 'dart:convert';

import '../model/city.dart';
import '../utils/url_endpoints.dart';
import 'package:http/http.dart' as http;

class CityApiService {
  static const String apiUrl = '$cityGet'; // Replace with your actual API URL

  static Future<List<City>> fetchCities() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> citiesData = data['data'];
        List<City> cities = citiesData.map((json) => City.fromJson(json)).toList();
        return cities;
      } else {
        throw Exception('Failed to load cities');
      }
    } catch (e) {
      throw Exception('Failed to fetch cities: $e');
    }
  }

  static Future<City> fetchCityById(String cityId) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/$cityId'));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return City.fromJson(data);
      } else {
        throw Exception('Failed to load city');
      }
    } catch (e) {
      throw Exception('Failed to fetch city: $e');
    }
  }
}

