import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class SignInPagenew extends StatefulWidget {
  @override
  _SignInPagenewState createState() => _SignInPagenewState();
}

class _SignInPagenewState extends State<SignInPagenew> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  Future<void> signOut() => _googleSignIn.signOut();

  Future<Map<String, dynamic>?> authenticateWithApi(String idToken, String name, String email, String photoUrl, String type) async {
    final response = await http.post(
      Uri.parse('http://stg-api-alb-1550582675.ap-south-1.elb.amazonaws.com/core-svc/api/v1/users/social-login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'id_token': idToken,
        'name': name,
        'email': email,
        'phone': '', // Ensure the 'phone' field is included
        'photo_url': photoUrl,
        'type': type, // Set the type dynamically
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Failed to authenticate with API: ${response.statusCode}');
      print('API Response Body: ${response.body}');
      return null;
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      var user = await login();
      if (user != null) {
        var authentication = await user.authentication;
        print('Google Sign-In Authentication: $authentication');

        var idToken = authentication.idToken;
        print('Google Sign-In ID Token: $idToken');

        var userName = user.displayName ?? 'Unknown';
        var userEmail = user.email;
        var userPhotoUrl = user.photoUrl ?? '';
        var userType = 'google';

        print('Google Sign-In ID Token: $idToken');
        print('Google Sign-In User Name: $userName');
        print('Google Sign-In User Email: $userEmail');
        print('Google Sign-In User Photo URL: $userPhotoUrl');

        if (idToken != null) {
          var apiResponse = await authenticateWithApi(idToken, userName, userEmail, userPhotoUrl, userType);

          if (apiResponse != null) {
            String accessToken = apiResponse['access_token'];
            String refreshToken = apiResponse['refresh_token'];
            print('Access Token: $accessToken');
            print('Refresh Token: $refreshToken');

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomepageNew(user: user, serverResponse: apiResponse)),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign-In'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => _signInWithGoogle(context),
          child: InkWell(
            child: Image(
              image: AssetImage('assets/png/google.png'),
              width: 40,
              height: 40,
            ),
          ),
        ),
      ),
    );
  }
}

class HomepageNew extends StatelessWidget {
  final GoogleSignInAccount user;
  final Map<String, dynamic> serverResponse;

  HomepageNew({required this.user, required this.serverResponse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${user.displayName}!'),
            Text('Email: ${user.email}'),
            Text('Access Token: ${serverResponse['access_token']}'),
            Text('Refresh Token: ${serverResponse['refresh_token']}'),
          ],
        ),
      ),
    );
  }
}
