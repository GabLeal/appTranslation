class ModelTranslation {
  final String originalText;
  final String translatedText;

  ModelTranslation(this.originalText, this.translatedText);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelTranslation &&
          runtimeType == other.runtimeType &&
          originalText == other.originalText &&
          translatedText == other.translatedText;

  @override
  int get hashCode => originalText.hashCode ^ translatedText.hashCode;
}
