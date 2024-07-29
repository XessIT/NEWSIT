import 'dart:async';
import 'package:flutter/material.dart';
import 'package:read/screens/signup.dart';

import '../landing_page/landing_screen.dart';
import '../repositories/storage.dart';
import 'location.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String version = '';
  Timer? _timer;
  final SecureStorageService secureStorageService = SecureStorageService();


  @override
  void initState() {
    super.initState();

    // Start a timer to navigate to the next screen after a delay
    _timer = Timer(const Duration(seconds: 3), () {
      _checkTokenValidity();
    });
  }

  Future<void> _checkTokenValidity() async {
    if (await secureStorageService.isAccessTokenValid()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LandingScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpScreen(),
        ),
      );

    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                width: 189,
                height: 61.3,
                child: Image.asset(
                  'assets/png/newsit2 1.png',
                ),
              ),
            ),
            // Column(
            //   children: [
            //     const Spacer(),
            //     Padding(
            //       padding: const EdgeInsets.only(bottom: 17.0),
            //       child: Center(
            //         child: Text(
            //           '@copyright 2023',
            //           style: Theme.of(context)
            //               .textTheme
            //               .titleMedium!
            //               .copyWith(color: ColorResource.color333333),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
