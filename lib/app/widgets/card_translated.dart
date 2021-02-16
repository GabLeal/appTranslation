import 'package:flutter/material.dart';

import '../model/model_translation.dart';

class CardTranslated extends StatelessWidget {
  ModelTranslation modelTranslation;
  Function action;
  CardTranslated({this.modelTranslation, this.action});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    modelTranslation.translatedText,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 5),
                  Text(
                    modelTranslation.originalText,
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          IconButton(icon: Icon(Icons.music_note), onPressed: action)
        ],
      ),
    );
  }
}
