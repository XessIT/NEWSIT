import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Language extends StatelessWidget {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Language Preference Example'),
        ),
        body: Center(
          child: LanguagePreferenceWidget(secureStorage: secureStorage),
        ),
      ),
    );
  }
}

class LanguagePreferenceWidget extends StatefulWidget {
  final FlutterSecureStorage secureStorage;

  LanguagePreferenceWidget({required this.secureStorage});

  @override
  _LanguagePreferenceWidgetState createState() =>
      _LanguagePreferenceWidgetState();
}

class _LanguagePreferenceWidgetState extends State<LanguagePreferenceWidget> {
  String _language = 'en';

  final Map<String, String> _paragraphs = {
    'en': 'This is an English paragraph. Here you can write the English content you want to display.',
    'ta': 'இது ஒரு தமிழ் பத்தி. இங்கே நீங்கள் காட்சி செய்ய விரும்பும் தமிழ் உள்ளடக்கத்தை எழுதலாம்.'
  };

  @override
  void initState() {
    super.initState();
    _loadLanguagePreference();
  }

  Future<void> _loadLanguagePreference() async {
    String? language = await widget.secureStorage.read(key: 'language_preference');
    if (language != null) {
      setState(() {
        _language = language;
      });
    } else {
      _saveLanguagePreference('en'); // Set default language to English
    }
  }

  Future<void> _saveLanguagePreference(String language) async {
    await widget.secureStorage.write(key: 'language_preference', value: language);
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Selected Language: ${_language == 'en' ? 'English' : 'Tamil'}'),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(_paragraphs[_language] ?? ''),
        ),
        ElevatedButton(
          onPressed: () {
            _saveLanguagePreference('en');
          },
          child: Text('Set English'),
        ),
        ElevatedButton(
          onPressed: () {
            _saveLanguagePreference('ta');
          },
          child: Text('Set Tamil'),
        ),
      ],
    );
  }
}

void main() => runApp(Language());
