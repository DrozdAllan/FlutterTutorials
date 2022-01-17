// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// // import 'package:tflite/tflite.dart';

// class EmotionDetector extends StatefulWidget {
//   static const routeName = "/emotion";
//   final List<CameraDescription> cameras;

//   EmotionDetector(this.cameras);

//   @override
//   _EmotionDetectorState createState() => _EmotionDetectorState();
// }

// class _EmotionDetectorState extends State<EmotionDetector> {
//   CameraImage? cameraImage;
//   late CameraController controller;
//   String output = '';

//   @override
//   void initState() {
//     super.initState();
//     controller = CameraController(widget.cameras[1], ResolutionPreset.low);
//     controller.initialize().then((value) {
//       if (!mounted) {
//         return;
//       } else {
//         setState(() {
//           controller.startImageStream((imageStream) {
//             cameraImage = imageStream;

//             // load Model IF NOT WORKING PROPERLY CHECK BACK THE TUTO TO CHANGE THE INIT
//             loadmodel();
//             // Run Tflite model
//             runModel();
//           });
//         });
//       }
//     });
//   }

//   runModel() async {
//     if (cameraImage != null) {
//       var predictions = await Tflite.runModelOnFrame(
//           bytesList: cameraImage!.planes.map(
//             (plane) {
//               return plane.bytes;
//             },
//           ).toList(),
//           imageHeight: cameraImage!.height,
//           imageWidth: cameraImage!.width,
//           imageMean: 127.5,
//           imageStd: 127.5,
//           rotation: 90,
//           numResults: 2,
//           threshold: 0.1,
//           asynch: true);
//       predictions!.forEach((element) {
//         setState(() {
//           output = element['label'];
//         });
//       });
//     }
//   }

//   loadmodel() async {
//     await Tflite.loadModel(
//         model: "assets/model.tflite", labels: "assets/labels.txt");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.all(20),
//           child: Container(
//             height: MediaQuery.of(context).size.height * 0.7,
//             width: MediaQuery.of(context).size.width,
//             child: !controller.value.isInitialized
//                 ? Container()
//                 : AspectRatio(
//                     aspectRatio: controller.value.aspectRatio,
//                     child: CameraPreview(controller),
//                   ),
//           ),
//         ),
//         Text(
//           output,
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
//         )
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     // Tflite.close();
//     super.dispose();
//   }
// }
