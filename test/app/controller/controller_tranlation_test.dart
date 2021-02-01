import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_to_text.dart';
import 'package:tradutor/app/controller/controller_translation.dart';
import 'package:tradutor/app/repositories/translate_repository.dart';

class SpeechToTextMock extends Mock implements SpeechToText {}

class ControllerTrasnlationMock extends Mock implements ControllerTrasnlation {}

ControllerTrasnlation main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('ControllerTranslation', () {
    TranaslationRepository tranaslationRepository = TranaslationRepository();
    ControllerTrasnlation controllerTrasnlation =
        ControllerTrasnlation(tranaslationRepository);
    SpeechToTextMock speechToTextMock = SpeechToTextMock();
    test('Deve iniciar valor como false', () {
      expect(controllerTrasnlation.isListening.value, false);
    });
    test('deve chamar o meto listen', () {
      speechToTextMock.listen();
      verify(
        speechToTextMock.listen(),
      );
    });

    test('teste', () {
      when(speechToTextMock.listen()).thenAnswer((_) async {
        controllerTrasnlation.isListening.value = true;
      });
      speechToTextMock.listen();
      expect(controllerTrasnlation.isListening.value, equals(false));
    });
  });
}
