import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tradutor/app/model/model_translation.dart';
import 'package:tradutor/app/repositories/translate_repository.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = Dio();
  final repository = TranaslationRepository();

  group('TranslateRepository', () {
    test('Deve retornar o sucesso do response na API', () async {
      // when(dio.post(any,
      //         data: {"T": "teste flutter", "SL": "PtBr", "TL": "EnUs"}))
      //     .thenAnswer((_) async => Response(data: jsonDecode(resultJson)));
      await repository.traduzirAPI('teste flutter');

      Response response = await dio.post(repository.urlBase,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Basic MjAxNS0zOEljSXRNeDp0K055Q081dGhJMGpqcG9peXd1VlNBUTJQS3pyTU5ZbzI3Slk='
          }),
          data: {"T": "teste flutter", "SL": "PtBr", "TL": "EnUs"});

      expect(response.data, jsonDecode('{"resul": "Flutter testing"}'));
    });
    test('Deve retonar um TranslationModel', () async {
      ModelTranslation modelTranslation =
          await repository.traduzirAPI('teste flutter');
      expect(modelTranslation,
          equals(ModelTranslation('teste flutter', 'Flutter testing')));
    });
  });
}
