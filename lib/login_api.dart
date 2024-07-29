import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:read/utils/url_endpoints.dart';

class LoginApi {
  static final _googleSignIn = GoogleSignIn(scopes: ['email']);

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future<void> signOut() => _googleSignIn.signOut();

  static Future<Map<String, dynamic>?> authenticateWithApi(String idToken, String name, String email, String photoUrl, String type) async {
    final response = await http.post(
      Uri.parse(googleUrl),
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
}
