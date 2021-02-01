import 'dart:convert';
import 'package:dio/dio.dart';
import '../model/model_translation.dart';

class TranaslationRepository {
  String urlBase = 'https://api.gotit.ai/Translation/v1.1/Translate';
  static const String keyIdentifier = '2015-38IcItMx';
  static const String keySecret = 't+NyCO5thI0jjpoiywuVSAQ2PKzrMNYo27JY';
  static const String APIKEY = '$keyIdentifier:$keySecret';
  // Dio dio = Dio();

  // TranaslationRepository([Dio dio]) {
  //   dio == null ? this.dio = Dio() : this.dio = dio;
  // }

  String toBase64(String text) {
    return base64.encode(utf8.encode(text));
  }

  Future<ModelTranslation> traduzirAPI(String text) async {
    String base64 = toBase64(APIKEY);
    Response response;
    Dio dio = Dio();

    try {
      response = await dio.post(urlBase,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Basic $base64'
          }),
          data: {"T": text, "SL": "PtBr", "TL": "EnUs"});

      ModelTranslation modelTranslation =
          ModelTranslation(text, response.data['result']);

      return modelTranslation;
    } catch (erro) {
      print(erro);
      print('Erro: ' + erro.toString());
      return null;
    }
  }
}
