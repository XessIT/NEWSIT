import 'package:flutter/material.dart';
import '../theme/app_themes.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool showIconLeft;
  final bool showArrowRight;
  final bool isOtpButton;

  CustomButton({
    required this.text,
    required this.onPressed,
    this.showIconLeft = false,
    this.showArrowRight = false,
    this.isOtpButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: isOtpButton
          ? CustomButtonTheme.otpButtonStyle()
          : CustomButtonTheme.primaryButtonStyle(),
      child: Ink(
        decoration: BoxDecoration(
          gradient: isOtpButton
              ? null
              : LinearGradient(
            colors: [Color(0xFF4776E6), Color(0xFF8E54E9)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Container(
          width: double.infinity,
          height: 48,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (showIconLeft) Icon(Icons.arrow_left, color: Colors.white),
              if (showIconLeft) SizedBox(width: 8),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (showIconLeft) Spacer(),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    if (showArrowRight) Spacer(),
                  ],
                ),
              ),
              if (showArrowRight) SizedBox(width: 8),
              if (showArrowRight) Icon(Icons.arrow_right, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
