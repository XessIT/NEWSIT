import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read/screens/storyviewpage.dart';
import 'package:read/screens/verifyOtp.dart';
import 'package:read/screens/welcome.dart';

import '../bloc/signup/signup_bloc.dart';
import '../bloc/signup/signup_event.dart';
import '../bloc/signup/signup_state.dart';
import '../landing_page/landing_screen.dart';
import '../landing_page/read_screen.dart';
import '../login_api.dart';
import '../main.dart';
import '../repositories/google_signin/newtry.dart';
import '../repositories/storage.dart';
import '../theme/image_resource.dart';
import '../ui_components/customButton.dart';
import 'location.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _sheet = GlobalKey();
  final _controller = DraggableScrollableController();
  bool valuefirst = false;
  TextEditingController mobileController = TextEditingController();
  bool isGetOtp = false;
  String otp = "";
  int countryMobileLength = 10;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupBloc>(
      create: (context) => SignupBloc(),
      child: BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is OtpSentSuccess) {
            print('OtpSentSuccess state received');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Otp Sent Successful!')),
            );

            setState(() {
              // otp = state.otp;
              // print("otp : ${otp}");
            });
          }

          if (state is GoogleSigninSuccess) {
            print('GoogleSigninSuccess state received');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Google Signin Successful!')),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const WelcomeScreen(mobile: '',)),
            );

          }

          if (state is OtpSentFailure) {
            print('OtpSentFailure state received');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Otp Sent Failed!')),
            );
          }

        },
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: Stack(
            children: [
              // Background image
              Positioned(
                top: 148,
                left: 53,
                width: 268,
                height: 241,
                child: Image.asset(
                  'assets/png/login.png', // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
              BlocBuilder<SignupBloc, SignupState>(
                builder: (context, state) {
                  return DraggableScrollableSheet(
                    key: _sheet,
                    initialChildSize: 0.52,
                    maxChildSize: 0.7,
                    minChildSize: 0.4,
                    expand: true,
                    controller: _controller,
                    builder: (BuildContext context, ScrollController scrollController) {
                      return DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: CustomScrollView(
                              controller: scrollController,
                              slivers: [
                                SliverToBoxAdapter(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 15),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Get Started !',
                                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                              fontWeight: FontWeight.bold, color: Colors.black),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Enter your phone number to proceed',
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                              fontWeight: FontWeight.bold, color: Colors.grey),
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Form(
                                        key: loginFormKey,
                                        child: TextFormField(
                                          maxLength: 10,
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          keyboardType: TextInputType.number,
                                          controller: mobileController,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.grey[100],
                                            errorStyle: const TextStyle(fontSize: 11.0),
                                            enabledBorder: const OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.grey),
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            ),
                                            focusedBorder: const OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.grey),
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            ),
                                            prefixIcon: Padding(
                                              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    '+91',
                                                    style: TextStyle(fontSize: 18, color: Colors.black),
                                                  ),
                                                  const Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.black),
                                                  const SizedBox(width: 4),
                                                  Container(
                                                    height: 24,
                                                    width: 1,
                                                    color: Colors.black,
                                                  ),
                                                  const SizedBox(width: 8),
                                                ],
                                              ),
                                            ),
                                            prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                            border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            ),
                                            hintText: 'Enter Mobile Number',

                                            contentPadding: const EdgeInsets.symmetric(vertical: 15),
                                          ),
                                          onChanged: (String? value) {
                                            setState(() {
                                              if (value != null && value.length == 10) {
                                                isGetOtp = true;
                                              } else {
                                                isGetOtp = false;
                                              }
                                            });
                                            print('isGetOtp: $isGetOtp');
                                          },
                                        )


                                        ,
                                      ),
                                      SizedBox(height: 10),

                                      CustomButton(
                                        text: "Get OTP",
                                        onPressed: () {

                                          print('Get OTP button pressed');
                                          final mobileNumber = mobileController.text;
                                          final bloc = BlocProvider.of<SignupBloc>(context);
                                          bloc.add(SentOTPEvent(mobileNumber));
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => OTPScreen(
                                                  mobile: mobileController.text,
                                                )),
                                          );

                                          // Handle OTP button press
                                        },
                                        isOtpButton: true, // Use the new OTP button style
                                      ),

                                      // Material(
                                      //   color: Colors.transparent,
                                      //   child: InkWell(
                                      //     onTap: isGetOtp
                                      //         ? () {
                                      //       print('Get OTP button pressed');
                                      //       final mobileNumber = mobileController.text;
                                      //       final bloc = BlocProvider.of<SignupBloc>(context);
                                      //       bloc.add(SentOTPEvent(mobileNumber));
                                      //       Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (context) => OTPScreen(
                                      //               mobile: mobileController.text,
                                      //             )),
                                      //       );
                                      //     }
                                      //         : null,
                                      //     child: Container(
                                      //       height: 50,
                                      //       margin: const EdgeInsets.all(10),
                                      //       padding: const EdgeInsets.all(10),
                                      //       alignment: Alignment.center,
                                      //       decoration: BoxDecoration(
                                      //         color: isGetOtp ? Colors.blue : Colors.grey,
                                      //         borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                      //       ),
                                      //       child: const Text(
                                      //         "Get OTP",
                                      //         style: TextStyle(
                                      //           fontSize: 16,
                                      //           color: Colors.white,
                                      //           fontFamily: 'DMSans-Medium',
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      const SizedBox(height: 30),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [Text('or Continue with',style:Theme.of(context).textTheme.titleSmall?.copyWith(
                                            fontWeight: FontWeight.bold, color: Colors.grey) ,)],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            /*onTap: () async {
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

                                                      final secureStorage = SecureStorageService();
                                                      await secureStorage.writeAccessToken(accessToken);
                                                      await secureStorage.writeRefreshToken(refreshToken);

                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => WelcomeScreen(mobile: '',)),
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
                                            },*/
                                            child: InkWell(
                                              child: Image(
                                                image: AssetImage('assets/png/google.png'),
                                                width: 40,
                                                height: 40,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(width: 10),
                                          GestureDetector(
                                            onTap: () {
                                             // Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPagenew(),));
                                           //   Navigator.push(context, MaterialPageRoute(builder: (context) => FeedScreen(),));
                                           //  Navigator.push(context, MaterialPageRoute(builder: (context) => LandingScreen(),));
                                              //print('Facebook Sign-In button pressed');
                                              print('Story view button pressed');
                                            },

                                            child: const Image(
                                              image: AssetImage('assets/png/facebook.png'),
                                              width: 35,
                                              height: 35,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

