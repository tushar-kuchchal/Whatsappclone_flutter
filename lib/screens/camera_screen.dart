

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:full_stack_whatsapp_flutter/screens/camera_view_page.dart';
import 'package:full_stack_whatsapp_flutter/screens/video_view.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

List<CameraDescription> cameras = [];

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController _cameraController =
      CameraController(cameras[0], ResolutionPreset.high);
  late Future<void> cameraValue;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _initializeCamera();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  Future<void> _initializeCamera() async {
    await _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
                future: cameraValue,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(_cameraController);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.flash_off,
                            color: Colors.white,
                            size: 28,
                          )),
                      GestureDetector(
                        onLongPress: () async {
                          // final videoPath = join(
                          //     (await getTemporaryDirectory()).path,
                          //     "${DateTime.now()}.mp4");
                          _cameraController.startVideoRecording();

                          setState(() {
                            isRecording = true;
                          });
                        },
                        onLongPressUp: () async {
                          final videopath =
                              await _cameraController.stopVideoRecording();
                          // final vpath = join(
                          //     (await getTemporaryDirectory()).path,
                          //     "${DateTime.now()}.mp4");
                          // videopath.saveTo(vpath);

                          setState(() {
                            isRecording = false;
                          });
                          if (!mounted) return;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) =>
                                      VideoView(path: videopath.path)));
                        },
                        onTap: () {
                          if (!isRecording) {
                            takePhoto(context);
                          }
                        },
                        child: isRecording
                            ? const Icon(
                                Icons.radio_button_on,
                                color: Colors.red,
                                size: 70,
                              )
                            : const Icon(
                                Icons.panorama_fish_eye,
                                color: Colors.white,
                                size: 70,
                              ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.flip_camera_ios,
                            color: Colors.white,
                            size: 28,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Hold for video, tap for photo",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void takePhoto(BuildContext context) async {
    final picturePath =
        join((await getTemporaryDirectory()).path, "${DateTime.now()}.png");
    final path = await _cameraController.takePicture();
    path.saveTo(picturePath);
    if (!mounted) return;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => CameraViewPage(path: picturePath)));
  }
}
