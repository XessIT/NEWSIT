import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:read/screens/welcome.dart';
import '../bloc/signup/signup_bloc.dart';
import '../bloc/signup/signup_event.dart';
import '../bloc/signup/signup_state.dart';
import '../landing_page/landing_screen.dart';
import '../ui_components/customButton.dart';

class OTPScreen extends StatefulWidget {
  final String mobile;

  const OTPScreen({
    Key? key,
    required this.mobile,
  }) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _sheet = GlobalKey();
  final _controller = DraggableScrollableController();
  OtpFieldController otpController = OtpFieldController();
  bool isOtpComplete = false;
  String otp = ''; // Store the OTP
  int _start = 30; // Timer duration in seconds
  late Timer _timer;
  bool isTimerFinished = false;
  bool isOtpFieldEnabled = true; // State variable to control OTP field

  @override
  void initState() {
    super.initState();
    startTimer();
    print("Mobile Numberssss : ${widget.mobile}");
  }

  void startTimer() {
    _start = 1800;
    isTimerFinished = false;
    isOtpFieldEnabled = true; // Enable the OTP field when timer starts
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          isTimerFinished = true;
          isOtpFieldEnabled =
              false; // Disable the OTP field when timer finishes
        });
        _timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void _checkOtpComplete(String otp) {
    setState(() {
      isOtpComplete = otp.length == 6; // Change this to 6
      this.otp = otp; // Update the stored OTP
    });
    if (isOtpComplete) {
      _timer.cancel();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: Stack(
            children: [
              // Background image
              Positioned(
                top: 130,
                left: 53,
                width: 268,
                height: 241,
                child: Image.asset(
                  'assets/png/login.png', // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
              // Body content
              BlocListener<SignupBloc, SignupState>(
                listener: (context, state) {
                  if (state is VerifyOtpFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Verified otp is wrong!")),
                    );
                  } else if (state is VerifyOtpSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Verified otp is Correct!")),
                    );
                    if (state.isUserDetailsEmpty) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeScreen(mobile: widget.mobile == '' ? null : widget.mobile),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LandingScreen(),
                        ),
                      );
                    }
                  } else if (state is OtpSentSuccess) {
                    // Print message on OTP sent success
                    //print("Resend OTP : ${state.otp}");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("OTP resent successfully!")),
                    );
                  } else if (state is OtpSentFailure) {
                    // Print message on OTP sent failure
                    print("Resend OTP failed");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Failed to resend OTP!")),
                    );
                  }
                },
                child: BlocBuilder<SignupBloc, SignupState>(
                  builder: (context, state) {
                    return DraggableScrollableSheet(
                      key: _sheet,
                      initialChildSize: 0.5,
                      maxChildSize: 0.7,
                      minChildSize: 0.4,
                      expand: true,
                      snap: true,
                      snapSizes: const [0.6],
                      controller: _controller,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return DecoratedBox(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(18),
                              child: CustomScrollView(
                                controller: scrollController,
                                slivers: [
                                  SliverToBoxAdapter(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                         Row(
                                          children: [
                                            Text(
                                              'Verify OTP',
                                              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                                  fontWeight: FontWeight.bold, color: Colors.black)
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                         Column(
                                          children: [
                                            Text('OTP has been sent to +91 ${widget.mobile}',style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                fontWeight: FontWeight.bold, color: Colors.grey),)
                                          ],
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        Column(
                                          children: [
                                            Center(
                                              child: Opacity(
                                                opacity: isOtpFieldEnabled
                                                    ? 1.0
                                                    : 0.5,
                                                child: IgnorePointer(
                                                  ignoring: !isOtpFieldEnabled,
                                                  child: OTPTextField(
                                                    controller: otpController,
                                                    length:
                                                        6, // Change this to 6
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    textFieldAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    fieldWidth: 40,
                                                    fieldStyle: FieldStyle.box,
                                                    outlineBorderRadius: 10,
                                                    style:
                                                        TextStyle(fontSize: 17),
                                                    onChanged: (pin) {
                                                      _checkOtpComplete(pin);
                                                    },
                                                    onCompleted: (pin) {
                                                      _checkOtpComplete(pin);
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                          children: [
                                            Center(
                                              child: isTimerFinished
                                                  ? TextButton(
                                                      onPressed: () {
                                                        context
                                                            .read<SignupBloc>()
                                                            .add(SentOTPEvent(
                                                                widget.mobile));
                                                        //startTimer();
                                                      },
                                                      child:  Text(
                                                          "Resend OTP",style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                          fontWeight: FontWeight.bold, color: Colors.grey)),
                                                    )
                                                  : Text(
                                                      'Resend OTP',style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                  fontWeight: FontWeight.bold, color: Colors.grey),),
                                              // Text(
                                              //   'Resend OTP in $_start seconds',style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                              //     fontWeight: FontWeight.bold, color: Colors.grey),),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                         Column(
                                          children: [
                                            CustomButton(
                                              text: 'Verify',
                                              onPressed: isOtpComplete
                                                  ? () {
                                                print(
                                                    "Verifying OTP: $otp");
                                                context
                                                    .read<SignupBloc>()
                                                    .add(VerifyOTPEvent(
                                                    widget.mobile,
                                                    otp));
                                              } : null ,
                                              showIconLeft: false, // Change to true to show the left icon
                                              showArrowRight: false, // Change to true to show the right icon
                                            ),

                                          ],
                                        ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
