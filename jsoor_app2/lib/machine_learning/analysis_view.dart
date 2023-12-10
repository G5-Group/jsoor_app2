import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:jsoor_app2/main.dart';
import 'package:tflite_v2/tflite_v2.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  AnalysisPageState createState() => AnalysisPageState();
}

class AnalysisPageState extends State<AnalysisPage> {
  List<String> resultList = [];
  CameraController? cameraController;
  CameraImage? cameraImage;
  bool isModelBusy = false;
  String answer = "";
  String tarResult = 'مرحبا بك في تشبيه الإشارة';
  FlutterTts flutterTts = FlutterTts();
// setting speaking lanugage and its configuration
  void setLang() async {
    //set speeaking speed
    await flutterTts.setSpeechRate(Cameras.speechRate);
    //set speeaking volume
    await flutterTts.setVolume(1.0);
    //set speeaking shrill or grave
    await flutterTts.setPitch(1.0);
    //set speeaking language
    await flutterTts.setLanguage('ar-SA');
  }

//Function to speek words
  Future _speakArabicList(List<String> textList) async {
    for (String text in textList) {
      await flutterTts.speak(text);
      // Delay before speaking the next string (adjust the duration as needed)
      await Future.delayed(Duration(milliseconds: 1500));
    }
  }

// Function to load model and label
  loadmodel() async {
    await Tflite.loadModel(
      model: "assets/model7.tflite",
      labels: "assets/labels7.txt",
      numThreads: 4,
    );
  }

// special fun call once and use for initialization
  @override
  void initState() {
    super.initState();
    loadmodel();
    setLang();
    initCamera(); // Initialize the camera directly here
  }

//function to release consumed resources
  @override
  void dispose() async {
    super.dispose();
    // await Tflite.close();
    await cameraController?.dispose();
  }

//function to switch camera
  void switchCamera() async {
    if (cameraController != null) {
      final newLensDirection = cameraController!.description.lensDirection ==
              CameraLensDirection.back
          ? CameraLensDirection.front
          : CameraLensDirection.back;

      await cameraController?.stopImageStream();
      await cameraController?.dispose(); // Dispose the current camera
//to initialize camera
      initCamera(
          cameraLensDirection:
              newLensDirection); // Initialize a new camera with the new direction
    }
  }

//Get available camera details
  Future<CameraDescription> getCamera(CameraLensDirection direction) async {
    final cameras = await availableCameras();
    return cameras.firstWhere((camera) => camera.lensDirection == direction);
  }

// build function ->to construct UI
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double w = size.width;
    double h = size.height;
    return SafeArea(
      child: Scaffold(
        body: cameraImage != null
            ? SingleChildScrollView(
                child: Column(children: [
                  Stack(
                    children: [
                      Container(
                        height: h * 0.7,
                        width: MediaQuery.of(context).size.width,
                        color: const Color.fromARGB(255, 177, 206, 230),
                        child: cameraController != null
                            ? AspectRatio(
                                aspectRatio:
                                    cameraController?.value.aspectRatio ?? 1,
                                child: CameraPreview(
                                  cameraController!, // Use the existing cameraController
                                ),
                              )
                            : null,
                      ),
                      Positioned(
                        top: 20.0,
                        right: 20.0,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                switchCamera();
                              });
                            }, // Switch the camera
                            icon: const Icon(
                              Icons.cameraswitch_outlined,
                              color: Colors.yellow,
                              size: 30.0,
                            )),
                      )
                    ],
                  ),
                  Container(
                    width: w,
                    height: h * 0.3,
                    decoration: BoxDecoration(
                        border: Border.all(
                      width: 4,
                      color: const Color.fromARGB(255, 192, 189, 189),
                      style: BorderStyle.solid,
                    )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                resultList.clear();
                              });
                            },
                            icon: const Icon(
                              Icons.cancel,
                              size: 30.0,
                            )),
                        Flexible(
                          child: Text(
                            Cameras.displayResult,
                            //resultList.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _speakArabicList(resultList);
                              //_speakArabic();
                            });
                          },
                          icon: const Icon(
                            Icons.volume_up,
                            size: 30.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              )
            : Container(
                color: const Color.fromARGB(255, 166, 238, 229),
                height: h,
                width: w,
                child: const Center(
                  child: Text(
                    'Loading Camera please wait....',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
      ),
    );
  }

//Initialize camera
  void initCamera({CameraLensDirection? cameraLensDirection}) async {
    var cameraDescription =
        await getCamera(cameraLensDirection ?? CameraLensDirection.back);
    cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
    );

    cameraController?.initialize().then((value) {
      //check if camera is mounted(part of UI or not)
      if (!mounted) {
        return;
      }
      setState(() {
        //start image stream
        cameraController?.startImageStream((image) {
          if (mounted) {
            setState(() {
              cameraImage = image;
              //after get cameraImage run the model
              applyModelOnImages();
            });
          }
        });
      });
    });
  }

  //Model to run on camera images
  void applyModelOnImages() async {
    if (cameraImage != null && !isModelBusy) {
      isModelBusy = true;

      try {
        var predictions = await Tflite.runModelOnFrame(
          bytesList: cameraImage!.planes.map((plane) {
            //Future.delayed(Duration(seconds: 1));
            return plane.bytes;
          }).toList(),
          imageHeight: cameraImage!.height,
          imageWidth: cameraImage!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          numResults: 2,
          rotation: 90,
          threshold: 0.2,
          asynch: true,
        );

        // Create a list to store new predictions
        List<String> newPredictions = [];

        for (var prediction in predictions!) {
          String newResult = prediction['label'].toString();
          await Future.delayed(Duration(seconds: 2));
          tarResult = newResult;
          if (newResult.trim() == 'No Sign' &&
              !newPredictions.contains('No Sign')) {
            newPredictions = newPredictions;
            // newPredictions.add(newResult);
          } else {
            newPredictions.add(newResult);
          }
          // Add the new prediction to the list
        }

        // Add new predictions to the resultList
        resultList.addAll(newPredictions);
        resultList =
            resultList.map((element) => element.toString().trim()).toList();

// If you want to create a comma-separated string:
        String commaSeparatedString = resultList.join(', ');
        Cameras.displayResult = commaSeparatedString;
        Cameras.displayResult = Cameras.displayResult;
        print(commaSeparatedString);

        setState(() {
          // You can set `answer` or `tarResult` here if needed, but it's not required for adding results to the list.
        });
      } catch (e) {
        print("Error running model: $e");
      } finally {
        isModelBusy = false;
      }
    }
  }
}
