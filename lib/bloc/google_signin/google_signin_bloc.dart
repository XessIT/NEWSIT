import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'google_signin_event.dart';
import 'google_signin_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final String loginUrl = 'http://stg-api-lki-1550582675.ap-north-1.elb.amazonaws.com/core-svc/api/v1/users/login-google';

  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is GoogleSignInRequested) {
      yield AuthLoading();

      try {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser == null) {
          yield AuthError("Sign in aborted by user");
          return;
        }

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final response = await http.post(
          Uri.parse(loginUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'idToken': googleAuth.idToken!,
          }),
        );

        if (response.statusCode == 200) {
          final body = json.decode(response.body);
          yield AuthAuthenticated(body['access_token']);
        } else {
          yield AuthError("Failed to sign in with Google");
        }
      } catch (error) {
        yield AuthError("An error occurred: $error");
      }
    }
  }
}
