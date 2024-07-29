import 'package:flutter/material.dart';

import '../repositories/storage.dart';

class TokenDisplayScreen extends StatefulWidget {
  @override
  _TokenDisplayScreenState createState() => _TokenDisplayScreenState();
}

class _TokenDisplayScreenState extends State<TokenDisplayScreen> {
  final SecureStorageService secureStorageService = SecureStorageService();
  String? accessToken;
  String? refreshToken;

  @override
  void initState() {
    super.initState();
    _loadTokens();
  }

  Future<void> _loadTokens() async {
    final storedAccessToken = await secureStorageService.readAccessToken();
    final storedRefreshToken = await secureStorageService.readRefreshToken();
    setState(() {
      accessToken = storedAccessToken;
      refreshToken = storedRefreshToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Token Display'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Access Token:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SelectableText(accessToken ?? 'No access token found'),
            SizedBox(height: 16.0),
            Text(
              'Refresh Token:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SelectableText(refreshToken ?? 'No refresh token found'),
          ],
        ),
      ),
    );
  }
}
