import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:tradutor/app/controller/controller_translation.dart';
import 'package:tradutor/app/model/model_translation.dart';
import 'package:tradutor/app/repositories/translate_repository.dart';
import 'package:tradutor/app/widgets/card_translated.dart';

class ViewTranslation extends StatefulWidget {
  @override
  _ViewTranslationState createState() => _ViewTranslationState();
  Widget switchTheme;
  ViewTranslation({this.switchTheme});
}

class _ViewTranslationState extends State<ViewTranslation> {
  TranaslationRepository tranaslationRepository = TranaslationRepository();
  ControllerTrasnlation controllerTrasnlation;

  @override
  void initState() {
    super.initState();
    controllerTrasnlation = ControllerTrasnlation(tranaslationRepository);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
            color: Theme.of(context).accentColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Português', style: TextStyle(fontSize: 20)),
                      widget.switchTheme,
                    ],
                  ),
                ),
                Container(
                    // color: Colors.red,
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller: controllerTrasnlation.textEditingController,
                      // onFieldSubmitted: (text) => controllerTrasnlation
                      //     .tranaslationRepository
                      //     .traduzirAPI(text),
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: 20),
                      minLines: 1,
                      maxLines: 10,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Enter translated text"),
                    )),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(35.0),
                      topRight: Radius.circular(35.0),
                    ),
                  ),
                  child: Container(
                    child: SingleChildScrollView(
                        child: ValueListenableBuilder(
                            valueListenable:
                                controllerTrasnlation.historyTranslate,
                            builder: (context, value, child) {
                              if (value.isEmpty) {
                                return Container(
                                  child: Center(
                                    child: Text(
                                        'Seu histórico de traduções está vazio'),
                                  ),
                                );
                              } else {
                                return Column(
                                    children: controllerTrasnlation
                                        .historyTranslate.value
                                        .map((modelTranlation) {
                                  return CardTranslated(
                                      modelTranslation: modelTranlation,
                                      action: () => controllerTrasnlation.speak(
                                          modelTranlation.translatedText));
                                }).toList());
                              }
                            })),
                  ),
                ))
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: ValueListenableBuilder(
              valueListenable: controllerTrasnlation.isListening,
              builder: (context, value, child) {
                return AvatarGlow(
                  animate: value,
                  glowColor: Theme.of(context).accentColor,
                  endRadius: 75.0,
                  duration: const Duration(milliseconds: 2000),
                  repeatPauseDuration: const Duration(milliseconds: 100),
                  repeat: true,
                  child: FloatingActionButton(
                    onPressed: () => controllerTrasnlation.listen(),
                    child: Icon(value ? Icons.mic : Icons.mic_none),
                  ),
                );
              })),
    );
  }
}
