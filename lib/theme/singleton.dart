class AidivaFlashSingleton {
  Map<String, dynamic>? errorMapValues;


   static final AidivaFlashSingleton _singleton =
      new AidivaFlashSingleton._internal();

  AidivaFlashSingleton._internal();

  static AidivaFlashSingleton get instance => _singleton;
}
