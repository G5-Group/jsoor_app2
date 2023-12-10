//**************************************************************************
// TranslateScreen (class 6)

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({super.key});

  @override
  TranslateScreenState createState() => TranslateScreenState();
}

class TranslateScreenState extends State<TranslateScreen> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textEditingController = TextEditingController();

  Future<void> speak(String text) async {
    await flutterTts.setLanguage("ar");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  @override
  void dispose() {
    flutterTts.stop(); // توقف عن تشغيل الصوت عند إغلاق الشاشة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: textEditingController,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text("بدء التحويل إلى كلام"),
                onPressed: () => speak(textEditingController.text),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
