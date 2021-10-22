import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:async';

class GeolocatorDemo extends StatefulWidget {
  const GeolocatorDemo({Key? key}) : super(key: key);

  static const routeName = "/geolocator";

  @override
  _GeolocatorDemoState createState() => _GeolocatorDemoState();
}

class _GeolocatorDemoState extends State<GeolocatorDemo> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  StreamSubscription<Position>? _positionStreamSubscription;
  String _gpsPosition = "";
  String _gpsState = "";

  @override
  void dispose() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription!.cancel();
      _positionStreamSubscription = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Geolocator Demo"),
      ),
      body: Container(
        child: Column(
          children: [
            TextButton(
                onPressed: _handlePermission, child: Text('Is GPS active ?')),
            Text(_gpsState),
            TextButton(
                onPressed: _getCurrentPosition,
                child: Text('Get position once')),
            TextButton(
                onPressed: _positionStreamSubscription == null ||
                        _positionStreamSubscription!.isPaused
                    ? _startOrResumeListening
                    : _pauseListening,
                child: _positionStreamSubscription == null ||
                        _positionStreamSubscription!.isPaused
                    ? Text('Start position stream')
                    : Text('Pause position stream')),
            Text(_gpsPosition),
            TextButton(
                onPressed: _getLocationAccuracy,
                child: Text('Get location accuracy for ios')),
            TextButton(
                onPressed: _requestTemporaryFullAccuracy,
                child: Text('Request temporary full accuracy for ios')),
            TextButton(
                onPressed: _openAppSettings, child: Text('Open app settings')),
            TextButton(
                onPressed: _openLocationSettings,
                child: Text('Open location settings for android')),
          ],
        ),
      ),
    );
  }

  void _getLocationAccuracy() async {
    final status = await _geolocatorPlatform.getLocationAccuracy();
    _handleLocationAccuracyStatus(status);
  }

  void _requestTemporaryFullAccuracy() async {
    final status = await _geolocatorPlatform.requestTemporaryFullAccuracy(
      purposeKey: "TemporaryPreciseAccuracy",
    );
    _handleLocationAccuracyStatus(status);
  }

  void _handleLocationAccuracyStatus(LocationAccuracyStatus status) {
    String locationAccuracyStatusValue;
    if (status == LocationAccuracyStatus.precise) {
      locationAccuracyStatusValue = 'Precise';
    } else if (status == LocationAccuracyStatus.reduced) {
      locationAccuracyStatusValue = 'Reduced';
    } else {
      locationAccuracyStatusValue = 'Unknown';
    }
    _gpsState = '$locationAccuracyStatusValue location accuracy granted.';
  }

  void _openAppSettings() async {
    final opened = await _geolocatorPlatform.openAppSettings();
    String displayValue;

    if (opened) {
      displayValue = 'Opened Application Settings.';
    } else {
      displayValue = 'Error opening Application Settings.';
    }
    _gpsState = displayValue;
  }

  void _openLocationSettings() async {
    final opened = await _geolocatorPlatform.openLocationSettings();
    String displayValue;

    if (opened) {
      displayValue = 'Opened Location Settings';
    } else {
      displayValue = 'Error opening Location Settings';
    }

    _gpsState = displayValue;
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      setState(() {
        _gpsState = 'Location services are disabled.';
      });
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        setState(() {
          _gpsState = 'Permission denied.';
        });

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      setState(() {
        _gpsState = 'Permission denied forever.';
      });

      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    setState(() {
      _gpsState = 'Permission granted.';
    });
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    setState(() {
      _gpsState = 'Locating...';
    });

    final position = await _geolocatorPlatform.getCurrentPosition();
    setState(() {
      _gpsPosition = position.toString();
      _gpsState = 'Located !';
    });
  }

  void _pauseListening() {
    setState(() {
      _positionStreamSubscription!.pause();
      _gpsState = 'Position Stream paused';
    });
  }

  void _startOrResumeListening() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    if (_positionStreamSubscription == null) {
      setState(() {
        _gpsState = "Starting the stream...";
      });
      final positionStream = _geolocatorPlatform.getPositionStream();
      _positionStreamSubscription = positionStream.handleError((error) {
        print('error happened : ' + error);
        _positionStreamSubscription?.cancel();
        _positionStreamSubscription = null;
      }).listen((position) {
        print(position);

        setState(() {
          _gpsPosition = position.toString();
          _gpsState = "Position stream ongoing...";
        });
      });
    } else if (_positionStreamSubscription!.isPaused) {
      _positionStreamSubscription!.resume();
      setState(() {
        _gpsState = 'Position stream resumed, listening...';
      });
    }
  }
}
