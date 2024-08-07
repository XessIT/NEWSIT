import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:read/repositories/google_signin/SignInPage.dart';
import 'package:read/repositories/google_signin/login_screen.dart';
import 'package:read/screens/splash_screen.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:read/theme/app_themes.dart';
import 'landing_page/read_navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<ReadNavigationBloc>(
            create: (context) => ReadNavigationBloc(),
          ),
          // Other providers if needed
        ],
        child:  MyApp(),

      ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  late Locale _locale;

  void setLocale(Locale locale) {
    _locale = locale;
  }



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return DynamicTheme(
      themeCollection: AppThemes().getThemeCollections(),
      defaultThemeId: AppThemes.lightOrange,
      builder: (BuildContext context, ThemeData theme) {
        return MaterialApp(
          title: 'NEWSIT',
          theme: theme,
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          supportedLocales: const [
            Locale('en', ''),
            Locale('ar', ''),
            Locale('hi', '')
          ],
          localizationsDelegates: const [
            //AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode &&
                  supportedLocale.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
        );
      },
    );
  }
}





class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        //  title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    try {
                      var user = await LoginApi.login();

                      if (user != null) {
                        var authentication = await user.authentication;
                        var idToken = authentication.idToken;
                        var userName = user.displayName ?? 'Unknown';
                        var userEmail = user.email;
                        var userPhotoUrl = user.photoUrl ?? '';
                        var userType = 'google';

                        print('Google Sign-In ID Token: $idToken');
                        print('Google Sign-In User Name: $userName');
                        print('Google Sign-In User Email: $userEmail');
                        print('Google Sign-In User Photo URL: $userPhotoUrl');

                        if (idToken != null) {
                          var apiResponse = await LoginApi.authenticateWithApi(idToken, userName, userEmail, userPhotoUrl, userType);

                          if (apiResponse != null) {
                            String accessToken = apiResponse['access_token'];
                            String refreshToken = apiResponse['refresh_token'];
                            print('Access Token: $accessToken');
                            print('Refresh Token: $refreshToken');



                            /*    Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => WelcomeScreen()),
                            );*/
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
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),

                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPageread()),
                    );
                  },
                  child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Logo_(2019).png',
                    width: 35,
                    height: 35,
                  ),
                ),const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Logo_(2019).png',
                    width: 35,
                    height: 35,
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SignInPagenew()),
                    // );
                  },
                  child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Logo_(2019).png',
                    width: 35,
                    height: 35,
                  ),
                ),
              ],
            )

          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



class LoginApi {
  static final _googleSignIn = GoogleSignIn(scopes: ['email']);

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future<void> signOut() => _googleSignIn.signOut();

  static Future<Map<String, dynamic>?> authenticateWithApi(String idToken, String name, String email, String photoUrl, String type) async {
    final response = await http.post(
      Uri.parse("http://stg-api-alb-1550582675.ap-south-1.elb.amazonaws.com/core-svc/api/v1/users/social-login"),
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