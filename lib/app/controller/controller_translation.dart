import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter/widgets.dart';
import 'package:tradutor/app/model/model_translation.dart';
import 'package:tradutor/app/repositories/translate_repository.dart';

class ControllerTrasnlation {
  TranaslationRepository tranaslationRepository;

  ControllerTrasnlation(this.tranaslationRepository);

  FlutterTts fluttertts = FlutterTts();
  stt.SpeechToText _speech = stt.SpeechToText();

  ValueNotifier<String> textTranslate = ValueNotifier<String>('Tradução');
  ValueNotifier<bool> isListening = ValueNotifier<bool>(false);
  ValueNotifier<List<ModelTranslation>> historyTranslate =
      ValueNotifier<List<ModelTranslation>>([]);
  final textEditingController = TextEditingController();

  void listen() async {
    if (!isListening.value) {
      bool available = await _speech.initialize(
          onStatus: (val) => print('OnStatus: $val'),
          onError: (val) {
            isListening.value = false;
            print('onError: $val');
          });

      if (available) {
        isListening.value = true;
        _speech.listen(onResult: (val) async {
          textEditingController.text = val.recognizedWords;
          if (val.finalResult) {
            isListening.value = false;

            ModelTranslation result = await tranaslationRepository
                .traduzirAPI(textEditingController.text);

            historyTranslate.value = List.from(historyTranslate.value)
              ..insert(0, result);
            textEditingController.text = '';
          }
        });
      }
    } else {
      isListening.value = false;

      _speech.stop();
    }
  }

  speak(String text) async {
    await fluttertts.setLanguage('en-US');
    print(await fluttertts.getVoices);
    await fluttertts.setPitch(1);
    await fluttertts.speak(text);
  }
}
