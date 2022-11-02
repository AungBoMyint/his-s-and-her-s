import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../main.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/AppCommon.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/Widget_extensions.dart';

enum TtsState { playing, stopped, paused, continued }

class ReadAloudDialog extends StatefulWidget {
  static String tag = '/ReadAloudDialog';
  final String text;
  final Color color;
  final bool isShape;

  ReadAloudDialog(this.text, {this.isShape = false, this.color = Colors.white});

  @override
  ReadAloudDialogState createState() => ReadAloudDialogState();
}

class ReadAloudDialogState extends State<ReadAloudDialog>
    with TickerProviderStateMixin {
  FlutterTts flutterTts = FlutterTts();
  TtsState ttsState = TtsState.stopped;

  int currentWordPosition = 0;

  bool isError = false;

  @override
  void initState() {
    super.initState();

    print("widget.text" + widget.text.toString());
    init();
  }

  Future<void> init() async {
    bool isLanguageFound = false;

    flutterTts.getLanguages.then((value) {
      Iterable it = value;

      it.forEach((element) {
        if (element.toString().contains(appStore.selectedLanguage)) {
          flutterTts.setLanguage(element);
          initTTS();
          isLanguageFound = true;
        }
      });
    });

    if (!isLanguageFound) initTTS();
  }

  Future<void> initTTS() async {
    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      stop();
    });

    flutterTts.setProgressHandler(
        (String text, int startOffset, int endOffset, String word) {
      currentWordPosition++;
    });

    flutterTts.setErrorHandler((msg) async {
      setState(() {
        ttsState = TtsState.playing;
      });

      flutterTts.stop();
      await 500.milliseconds.delay;

      if (!isError && mounted) {
        isError = true;
        toast(errorSomethingWentWrong);
      }
    });

    flutterTts.setCancelHandler(() async {
      log('Canceled');
      /*await Future.delayed(Duration(milliseconds: 200));

      finish(context);
      toast(errorSomethingWentWrong);*/
    });

    flutterTts.setPauseHandler(() {
      setState(() {
        ttsState = TtsState.paused;
      });
    });

    flutterTts.setContinueHandler(() {
      setState(() {
        ttsState = TtsState.continued;
      });
    });
  }

  Future speak() async {
    currentWordPosition = 0;
    var result = await flutterTts.speak(widget.text);
    if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  Future stop() async {
    currentWordPosition = 0;
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isShape
        ? GestureDetector(
            onTap: () {
              ttsState == TtsState.playing ? stop() : speak();
            },
            child: Icon(
                ttsState == TtsState.playing ? Icons.pause : Icons.volume_up,
                color: widget.color))
        : IconButton(
            onPressed: () async {
              ttsState == TtsState.playing ? stop() : speak();
            },
            icon: Icon(
                ttsState == TtsState.playing ? Icons.pause : Icons.volume_up),
            color: context.iconColor,
          );
  }
}
