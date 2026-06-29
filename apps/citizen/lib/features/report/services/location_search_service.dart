import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class LocationSearchResult {
  final String displayName;
  final LatLng location;

  const LocationSearchResult({
    required this.displayName,
    required this.location,
  });

  factory LocationSearchResult.fromJson(Map<String, dynamic> json) {
    return LocationSearchResult(
      displayName: json['display_name'] ?? '',
      location: LatLng(
        double.parse(json['lat']),
        double.parse(json['lon']),
      ),
    );
  }
}

class LocationSearchService {
  static Future<List<LocationSearchResult>> search(String query) async {
    if (query.isEmpty) return [];

    try {
      final uri = Uri.parse('https://nominatim.openstreetmap.org/search').replace(
        queryParameters: {
          'q': query,
          'format': 'jsonv2',
          'addressdetails': '1',
          'limit': '5',
        },
      );

      final response = await http.get(
        uri,
        headers: {
          'User-Agent': 'CivicWatch/1.0 (https://github.com/Civic-Watch; contact@civicwatch.org)'
        },
      );

      if (response.statusCode != 200) {
        return [];
      }

      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => LocationSearchResult.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }
}
