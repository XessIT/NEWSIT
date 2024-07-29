class Font {
  static const Font dmsansLight = Font('DMSans-Light');
  static const Font dmsansMedium = Font('DMSans-Medium');
  static const Font dmsansRegular = Font('DMSans-Regular');
  static const Font dmsansSemiBold = Font('DMSans-SemiBold');
  static const Font dmsansBold = Font('DMSans-Bold');


  final String _fontName;

  String get value => _fontName;

  // ignore: sort_constructors_first
  const Font(this._fontName);
}