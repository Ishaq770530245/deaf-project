import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DetectSignLanguagePage extends StatefulWidget {
  @override
  _DetectSignLanguagePageState createState() => _DetectSignLanguagePageState();
}

class _DetectSignLanguagePageState extends State<DetectSignLanguagePage> {
  CameraController? _cameraController;
  late List<CameraDescription> _cameras;
  int _selectedCameraIndex = 0;
  FlutterTts flutterTts = FlutterTts();
  bool isProcessing = false;
  String detectedText = "";
  Uint8List? capturedImage;
  List<Map<String, dynamic>> predictions = [];

  @override
  void initState() {
    super.initState();
    _initializeCameras();
    _initializeTTS();
  }

  Future<void> _initializeCameras() async {
    _cameras = await availableCameras();
    if (_cameras.isNotEmpty) {
      _cameraController = CameraController(
          _cameras[_selectedCameraIndex], ResolutionPreset.medium);
      await _cameraController!.initialize();
      await _cameraController!.setFlashMode(FlashMode.off);
      setState(() {});
    }
  }

  Future<void> _initializeTTS() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.awaitSpeakCompletion(true);
  }

  void _switchCamera() async {
    if (_cameras.length > 1) {
      _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
      await _cameraController?.dispose();
      _cameraController = CameraController(
          _cameras[_selectedCameraIndex], ResolutionPreset.medium);
      await _cameraController!.initialize();
      await _cameraController!
          .setFlashMode(FlashMode.off); // Ensure flash remains off

      setState(() {});
    }
  }

  Future<void> _captureImage() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized)
      return;
    try {
      final XFile file = await _cameraController!.takePicture();
      final Uint8List bytes = await file.readAsBytes();
      setState(() {
        capturedImage = bytes;
      });
      _detectSignLanguage(file);
    } catch (e) {
      setState(() {
        detectedText = "Error capturing image: $e";
      });
    }
  }

  Future<void> _detectSignLanguage(XFile imageFile) async {
    if (isProcessing) return;
    setState(() {
      isProcessing = true;
    });

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://saher-sign-language.onrender.com/predict'),
      );
      request.files
          .add(await http.MultipartFile.fromPath('file', imageFile.path));

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final data = jsonDecode(responseBody);

      if (response.statusCode == 200 &&
          data['predictions'] != null &&
          data['predictions'].isNotEmpty) {
        setState(() {
          detectedText = data['predictions'][0]['class'];
          predictions = List<Map<String, dynamic>>.from(data['predictions']);
        });
        _speakText(detectedText);
      } else {
        setState(() {
          detectedText = "Unknown Prediction";
          predictions = [];
        });
      }
    } catch (e) {
      setState(() {
        detectedText = "Error during prediction: $e";
        predictions = [];
      });
    }
    setState(() {
      isProcessing = false;
    });
  }

  Future<void> _speakText(String text) async {
    if (text.isNotEmpty) {
      try {
        await flutterTts.speak(text);
      } catch (e) {
        print("TTS Error: $e");
      }
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Language Detection".tr)),
      body: Column(
        children: [
          Expanded(
            child: capturedImage == null
                ? (_cameraController != null &&
                        _cameraController!.value.isInitialized
                    ? CameraPreview(_cameraController!)
                    : Center(child: CircularProgressIndicator()))
                : Stack(
                    children: [
                      Image.memory(capturedImage!),
                      if (predictions.isNotEmpty)
                        Positioned.fill(
                          child: CustomPaint(
                            painter: BoundingBoxPainter(predictions),
                          ),
                        ),
                    ],
                  ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(detectedText,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _captureImage,
                      child: isProcessing
                          ? CircularProgressIndicator()
                          : Text("Capture & Predict".tr),
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      icon: Icon(Icons.switch_camera, size: 30),
                      onPressed: _switchCamera,
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      icon: Icon(Icons.replay, size: 30),
                      onPressed: () => setState(() {
                        capturedImage = null;
                        detectedText = "";
                        predictions = [];
                      }),
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      icon: Icon(Icons.volume_up, size: 30),
                      onPressed: () => _speakText(detectedText),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BoundingBoxPainter extends CustomPainter {
  final List<Map<String, dynamic>> predictions;

  BoundingBoxPainter(this.predictions);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    for (var pred in predictions) {
      final rect = Rect.fromLTWH(
        pred['x'] - pred['width'] / 2,
        pred['y'] - pred['height'] / 2,
        pred['width'],
        pred['height'],
      );
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
