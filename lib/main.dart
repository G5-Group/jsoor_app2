import 'dart:ui';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'ThemeProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:tflite_v2/tflite_v2.dart';

class Cameras {
  static List<CameraDescription>? cameras;
  static double speechRate = 0.5;
  static String displayResult = '';
}

Future<void> main() async {
  // initialize the cameras when the app starts
  WidgetsFlutterBinding.ensureInitialized();
  Cameras.cameras = await availableCameras();
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale){
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {

  Locale? _locale;

  void setLocale(Locale locale){
    setState((){
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(), // Set the default light theme
      darkTheme: ThemeData.dark(), // Set the default dark theme
      themeMode: Provider.of<ThemeProvider>(context).isDarkModeEnabled
          ? ThemeMode.dark
          : ThemeMode.light,
      home: PhoneApplicationPage(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
    );
  }
}


//****************************************************************************
// PhoneApplicationPage (class 1)
class PhoneApplicationPage extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<PhoneApplicationPage> {
  @override
  void initState() {
    super.initState();

    // Start the timer for 3 seconds
    Timer(const Duration(seconds: 3), () {
      // Navigate to the onboarding screen after 3 seconds
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8cc7e6),
              Color(0xFF75afd2),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  width: 250,
                  height: 200,
                  child: Image.asset(
                    'images/Jsoor.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white), // تعيين لون التحميل إلى الأبيض
              ),
            ],
          ),
        ),
      ),
    );
  }
}



//****************************************************************************

// OnboardingPage (class 2)
class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,

        pages: [
          // page 1
          PageViewModel(
            titleWidget: const Text(
              "Jsoor",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            body: "One Sign at a Time Your Voice in Every Hand.",
            image: Image.asset(
              "images/intro1.png",
              height: 400,
              width: 400,
            ),
          ),


//--------------------------------------------------------------------------------------
          // page 2
          PageViewModel(
            titleWidget: const Text(
              "Sign to words",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            body: "Seamlessly bridge the gap between sign language and text with our intuitive app."
                " Instantly translate sign language gestures to text, enhancing communication for everyone.",
            image: Image.asset(
              "images/intro2.gif",
              height: 400,
              width: 400,
            ),
          ),

//--------------------------------------------------------------------------------------
          // page 3
          PageViewModel(
            titleWidget: const Text(
              "Text to voice",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            body: "Not only does the app translate sign language to text, but it also brings it to life with vocalized translations – SignCam: Bridging Conversations with Clarity",
            image: Image.asset(
              "images/intro3.gif",
              height: 400,
              width: 400,
            ),
          ),
        ],

//--------------------------------------------------------------------------------------

        onDone: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
          );
        },

        onSkip: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
          );
        },
        showSkipButton: true,


        //----skip-----
        skip: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: const Color(0xFF8cc7e6), width: 2.0),
            color: const Color(0xFF8cc7e6),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: const Text(
            "Skip",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),


        //----next-----
        next: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: const Color(0xFF8cc7e6), width: 2.0),
            color: const Color(0xFF8cc7e6),
          ),
          padding: const EdgeInsets.all(8.0),
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),

        //----Done-----
        done: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: const Color(0xFF8cc7e6), width: 2.0),
            color: const Color(0xFF8cc7e6),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: const Text(
            "Done",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),


        dotsDecorator: DotsDecorator(
          size: const ui.Size.square(10.0),
          activeSize: const ui.Size(20.0, 10.0),
          color: Colors.black26,
          activeColor: const Color(0xFF8cc7e6),
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}

//****************************************************************************


// MainPage (class 3)
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

//****************************************************************************
class _MainPageState extends State<MainPage> {
  int _pageIndex = 0;

  List<Widget> _pages = [
    HomeScreen(),
    AboutUs(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkModeEnabled = themeProvider.isDarkModeEnabled;
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: _pageIndex != 2,
            child: TickerMode(
              enabled: _pageIndex == 2,
              child: _pages[2],
            ),
          ),
          Offstage(
            offstage: _pageIndex == 2,
            child: Scaffold(
              bottomNavigationBar: CurvedNavigationBar(
                backgroundColor: isDarkModeEnabled ? Color(131313) : Color(0xFF8cc7e6),
                color: isDarkModeEnabled ? Color(303030) : Color(0xFF136a8d),
                animationDuration: Duration(milliseconds: 300),
                index: _pageIndex,
                onTap: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                items: [
                  Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.groups,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                ],
              ),
              body: _pages[_pageIndex],
            ),
          ),
        ],
      ),
    );
  }
}
//**************************************************************************


//-------------- HomeScreen ----------------
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkModeEnabled = themeProvider.isDarkModeEnabled;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkModeEnabled ? Color(303030) : Color(0xFF136a8d),
        //title: Text('Home'),
      ),
      body: Container(
        color: isDarkModeEnabled ? Color(131313) : Color(0xFF8cc7e6),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/Jsoor.png', // Replace with your image path
                width: 300,
                height: 200,
              ),
              Container(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TranslateScreen()),
                    );
                  },
                  child:  Column(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage('images/buttonImage.png'), // Replace with your image path
                        radius: 60,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        AppLocalizations.of(context)!.translateButton,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


//**************************************************************************
// about us (class 4)
//----------- GroupsScreen ---------------

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkModeEnabled = themeProvider.isDarkModeEnabled;

    return Scaffold(
      backgroundColor: isDarkModeEnabled ? Color(131313) : Color(0xFF8cc7e6),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.aboutUs),
        backgroundColor: isDarkModeEnabled ? Color(303030) : Color(0xFF136a8d),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/Jsoor.png',
              width: 300,
              height: 200,
            ),
            const SizedBox(height: 40),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 350.toDouble(),
                height: 200.toDouble(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withOpacity(0.13)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFA7E5FF).withOpacity(0.4),
                      blurRadius: 16,
                      spreadRadius: 4,
                      offset: const Offset(5, 5),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 4.0,
                        sigmaY: 4.0,
                      ),
                      child: Container(),
                    ),
                    Center(
                      child: Text(
                        AppLocalizations.of(context)!.jsoor,
                        style: TextStyle(fontSize: 24, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//**************************************************************************
// Settings (class 5)
//------------SettingsScreen------------------
class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  String selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  Future<void> _loadSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = prefs.getString('selectedLanguage') ?? 'English';
    });
  }

  Future<void> _saveSelectedLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', language);
  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkModeEnabled = themeProvider.isDarkModeEnabled;


    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
        backgroundColor: isDarkModeEnabled ? Color(303030) : Color(0xFF136a8d),

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          },
        ),
      ),
      body: Container(
        color: isDarkModeEnabled ? const Color(131313) : Color(0xFF8cc7e6),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ListTile(
              leading: const Icon(Icons.volume_up),
              iconColor: const Color(0xFF136a8d),
              title: Text(
                AppLocalizations.of(context)!.voice,
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Slider(
                min: 0.5,
                max: 2.0,
                value: Cameras.speechRate,
                onChanged: (value) {
                  setState(() {
                    Cameras.speechRate = value;
                  });
                },
              ),
              // Text(AppLocalizations.of(context)!.pronunciationSpeed),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.accessibility),
              iconColor: Color(0xFF136a8d),
              title: SwitchListTile(
                title: Text(
                  AppLocalizations.of(context)!.accessibility,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(AppLocalizations.of(context)!.screenMode),
                value: isDarkModeEnabled,
                onChanged: (value) {
                  // Toggle the theme mode and save the selection
                  themeProvider.toggleTheme();
                },
              ),
            ),
            Divider(),
            ExpansionTile(
              leading: Icon(Icons.language),
              iconColor: Color(0xFF136a8d),

              title: Text(
                AppLocalizations.of(context)!.language,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(AppLocalizations.of(context)!.selectLanguage),
              trailing: Icon(Icons.keyboard_arrow_down),
              children: [
                RadioListTile(
                  title: Text('English'),
                  value: 'English',
                  groupValue: selectedLanguage,
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value!;
                      _saveSelectedLanguage(value);
                      MyApp.setLocale(context, Locale('en'));
                    });
                  },
                ),
                RadioListTile(
                  title: Text('عربي'),
                  value: 'عربي',
                  groupValue: selectedLanguage,
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value!;
                      _saveSelectedLanguage(value);
                      MyApp.setLocale(context, Locale('ar'));
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}





//**************************************************************************
// TranslateScreen (class 6)

class TranslateScreen extends StatefulWidget {
  @override
  _TranslateScreenState createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  List<String> resultList = [];
  CameraController? cameraController;
  CameraImage? cameraImage;
  bool isModelBusy = false;
  String answer = "";
  String tarResult = 'مرحبا بك في تشبيه الإشارة';
  FlutterTts flutterTts = FlutterTts();

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

  // Future speakArabicList(List<String> textList) async {
  //   for (String text in textList) {
  //     final result = await flutterTts.speak(text);
  //     if (result == 1) {
  //       // TTS is playing
  //       // You can handle the TTS state as needed
  //     }
  //   }
  // }

  Future _speakArabicList(List<String> textList) async {
    for (String text in textList) {
      await flutterTts.speak(text);
      // Delay before speaking the next string (adjust the duration as needed)
      await Future.delayed(Duration(milliseconds: 1500));
    }
  }

  // Future _speakArabic() async {
  //   final result = await flutterTts.speak(tarResult);
  //   if (result == 1) {
  //     // TTS is playing
  //     // You can handle the TTS state as needed
  //   }
  // }

  loadmodel() async {
    await Tflite.loadModel(
      model: "assets/model6.tflite",
      labels: "assets/labels6.txt",
      numThreads: 4,
    );
  }

  @override
  void initState() {
    super.initState();
    loadmodel();
    setLang();
    initCamera(); // Initialize the camera directly here
  }

  @override
  void dispose() async {
    super.dispose();
    // await Tflite.close();
    await cameraController?.dispose();
  }

  void switchCamera() async {
    if (cameraController != null) {
      final newLensDirection = cameraController!.description.lensDirection ==
          CameraLensDirection.back
          ? CameraLensDirection.front
          : CameraLensDirection.back;

      await cameraController?.stopImageStream();
      await cameraController?.dispose(); // Dispose the current camera

      initCamera(
          cameraLensDirection:
          newLensDirection); // Initialize a new camera with the new direction
    }
  }

  Future<CameraDescription> getCamera(CameraLensDirection direction) async {
    final cameras = await availableCameras();
    return cameras.firstWhere((camera) => camera.lensDirection == direction);
  }

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
                      onPressed: switchCamera, // Switch the camera
                      icon: const Icon(
                        Icons.cameraswitch_outlined,
                        color: Color(0xFF136a8d),
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
                        color: Color(0xFF136a8d),
                      )),
                  Flexible(
                    child: Text(
                      resultList.toString(),
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
                      color: Color(0xFF136a8d),
                    ),
                  )
                ],
              ),
            ),
          ]),
        )
            : Container(
          color: const Color.fromARGB(255, 140, 199, 230),
          height: h,
          width: w,
          child:  Center(
            child: Text(
              AppLocalizations.of(context)!.cameraLoad,
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

  void initCamera({CameraLensDirection? cameraLensDirection}) async {
    var cameraDescription =
    await getCamera(cameraLensDirection ?? CameraLensDirection.back);
    cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
    );

    cameraController?.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController?.startImageStream((image) {
          if (mounted) {
            setState(() {
              cameraImage = image;
              applyModelOnImages();
            });
          }
        });
      });
    });
  }

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
          double confidenceInPercentage = ((prediction["confidence"] * 100). round()) / 100;
          print (confidenceInPercentage);
          tarResult = newResult;
          if (newResult.trim() == 'No Sign' &&
              !newPredictions.contains('No Sign')) {
            newPredictions = newPredictions;
            // newPredictions.add(newResult);
          } else {
            newPredictions.add(newResult);
            await Future.delayed(Duration (seconds: 3)); //delay after the printing // Future. delayed
          }
          // Add the new prediction to the list
        }

        // Add new predictions to the resultList
        resultList.addAll(newPredictions);

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




