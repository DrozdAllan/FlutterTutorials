import 'dart:developer';

import 'package:camera/camera.dart';

class CameraService {
  late List<CameraDescription> cameras;

  void init() async {
    // get list of available cameras
    cameras = await availableCameras();
    inspect(cameras.first);
  }

  List<CameraDescription> getCameras() {
    inspect(cameras);
    return cameras;
  }
}
