import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email'],
);

void _authenticateWithGoogle(String idToken, String name, String email, String photoUrl, String userRole) async {
  final url = Uri.parse('http://stg-api-alb-1550582675.ap-south-1.elb.amazonaws.com/core-svc/api/v1/users/login-google');
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({
    'id_token': idToken,
    'name': name,
    'email': email,
    'photo_url': photoUrl,
    'user_role': userRole,
  });

  try {
    final response = await http.post(url, headers: headers, body: body);

    print('API Response Status Code: ${response.statusCode}');
    print('API Response Body: ${response.body}');

    if (response.statusCode == 200) {
      print('Suceess to authenticate with API: ${response.statusCode}');
      // Handle successful response
      final data = jsonDecode(response.body);
      // Use the access_token and refresh_token as needed
      print('Access Token: ${data['access_token']}');
      print('Refresh Token: ${data['refresh_token']}');
    } else {
      print('Failed to authenticate with API: ${response.statusCode}');
      print('API Response Body: ${response.body}');
    }
  } catch (e) {
    print('Error authenticating with API: $e');
  }
}

void _handleSignIn() async {
  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final String idToken = googleAuth.idToken!;
      final String name = googleUser.displayName!;
      final String email = googleUser.email;
      final String photoUrl = googleUser.photoUrl ?? '';
      final String userRole = 'user';  // Set a default user role

      print('Google Sign-In ID Token: $idToken');
      print('Google Sign-In User Name: $name');
      print('Google Sign-In User Email: $email');
      print('Google Sign-In User Photo URL: $photoUrl');

      _authenticateWithGoogle(idToken, name, email, photoUrl, userRole);
    }
  } catch (error) {
    print('Error during Google Sign-In: $error');
  }
}

class SignInDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Google Sign-In Demo'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: _handleSignIn,
            child: Text('Sign in with Google'),
          ),
        ),
      ),
    );
  }
}
