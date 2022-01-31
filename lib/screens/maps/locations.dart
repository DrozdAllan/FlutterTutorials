import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class LatLng {
  final double lat;
  final double lng;
  LatLng({
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  factory LatLng.fromMap(Map<String, dynamic> map) {
    return LatLng(
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LatLng.fromJson(String source) => LatLng.fromMap(json.decode(source));
}

class Region {
  final LatLng coords;
  final String id;
  final String name;
  final double zoom;
  Region({
    required this.coords,
    required this.id,
    required this.name,
    required this.zoom,
  });

  Map<String, dynamic> toMap() {
    return {
      'coords': coords.toMap(),
      'id': id,
      'name': name,
      'zoom': zoom,
    };
  }

  factory Region.fromMap(Map<String, dynamic> map) {
    return Region(
      coords: LatLng.fromMap(map['coords']),
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      zoom: map['zoom']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Region.fromJson(String source) => Region.fromMap(json.decode(source));
}

class Office {
  final String address;
  final String id;
  final String image;
  final double lat;
  final double lng;
  final String name;
  final String phone;
  final String region;
  Office({
    required this.address,
    required this.id,
    required this.image,
    required this.lat,
    required this.lng,
    required this.name,
    required this.phone,
    required this.region,
  });

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'id': id,
      'image': image,
      'lat': lat,
      'lng': lng,
      'name': name,
      'phone': phone,
      'region': region,
    };
  }

  factory Office.fromMap(Map<String, dynamic> map) {
    return Office(
      address: map['address'] ?? '',
      id: map['id'] ?? '',
      image: map['image'] ?? '',
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      region: map['region'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Office.fromJson(String source) => Office.fromMap(json.decode(source));
}

class Locations {
  final List<Office> offices;
  final List<Region> regions;
  Locations({
    required this.offices,
    required this.regions,
  });

  Map<String, dynamic> toMap() {
    return {
      'offices': offices.map((x) => x.toMap()).toList(),
      'regions': regions.map((x) => x.toMap()).toList(),
    };
  }

  factory Locations.fromMap(Map<String, dynamic> map) {
    return Locations(
      offices: List<Office>.from(map['offices']?.map((x) => Office.fromMap(x))),
      regions: List<Region>.from(map['regions']?.map((x) => Region.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Locations.fromJson(String source) =>
      Locations.fromMap(json.decode(source));
}

Future<Locations> getGoogleOffices() async {
  const googleLocationsURL = 'https://about.google/static/data/locations.json';

  // Retrieve the locations of Google offices
  try {
    final response = await http.get(Uri.parse(googleLocationsURL));
    if (response.statusCode == 200) {
      return Locations.fromJson(response.body);
    }
  } catch (e) {
    print(e);
  }

  // Fallback for when the above HTTP request fails
  return Locations.fromJson(
      json.decode(await rootBundle.loadString('assets/locations.json')));
}
