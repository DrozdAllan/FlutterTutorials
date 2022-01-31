import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'locations.dart' as locations;

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  static const routeName = "/maps";

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(title: office.name, snippet: office.address),
        );
        _markers[office.name] = marker;
      }
      _markers['Custom1'] = Marker(
          markerId: MarkerId('Custom1'),
          position: LatLng(49.07524527626486, 6.197535237906448),
          infoWindow: InfoWindow(
              title: 'Collocation mère-fils',
              snippet: 'bon courage bon courage'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Google Maps Tuto',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition:
              const CameraPosition(target: LatLng(46.7, 2.8), zoom: 6.0),
          markers: _markers.values.toSet(),
        ));
  }
}
