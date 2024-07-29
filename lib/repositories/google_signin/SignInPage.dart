import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'google_sign_in_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignInPageread extends StatefulWidget {
  @override
  _SignInPagereadState createState() => _SignInPagereadState();
}

class _SignInPagereadState extends State<SignInPageread> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign-In'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () async {
            try {
              var user = await GoogleSignInService.signIn();
              if (user != null) {
                var authentication = await user.authentication;
                var idToken = authentication.idToken;
                var accessToken = authentication.accessToken;
                var userName = user.displayName ?? 'Unknown';
                var userEmail = user.email;
                var userPhotoUrl = user.photoUrl ?? '';

                print('Google Sign-In ID Token: $idToken');
                print('Google Sign-In Access Token: $accessToken');
                print('Google Sign-In User Name: $userName');
                print('Google Sign-In User Email: $userEmail');
                print('Google Sign-In User Photo URL: $userPhotoUrl');

                if (idToken != null) {
                  var apiResponse = await authenticateWithApi(idToken);
                  if (apiResponse != null) {
                    String accessToken = apiResponse['access_token'];
                    String refreshToken = apiResponse['refresh_token'];
                    print('Access Token: $accessToken');
                    print('Refresh Token: $refreshToken');

                    // Navigate to the desired page after successful login
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LocationCategorySelectionread()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Authentication with API failed')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to retrieve ID Token')),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Google Sign-In failed')),
                );
              }
            } catch (error) {
              print('Sign-In Error: $error');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Sign-In Error: $error')),
              );
            }
          },
          child: InkWell(
            child: Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Logo_(2019).png',
              width: 35,
              height: 35,
            ),
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>?> authenticateWithApi(String idToken) async {
    final response = await http.post(
      Uri.parse('http://stg-api-alb-1550582675.ap-south-1.elb.amazonaws.com/core-svc/api/v1/users/login-google'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'idToken': idToken,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Failed to authenticate with API. Status code: ${response.statusCode}');
      return null;
    }
  }
}

class LocationCategorySelectionread extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Category Selection'),
      ),
      body: Center(
        child: Text('Welcome to Location Category Selection!'),
      ),
    );
  }
}
