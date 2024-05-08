import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

class WelcomeText extends StatefulWidget {
  const WelcomeText({
    super.key,
  });

  @override
  State<WelcomeText> createState() => _WelcomeTextState();
}

class _WelcomeTextState extends State<WelcomeText> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 40),
      child: FadeIn(
        duration: Duration(milliseconds: 250),
        curve: Curves.easeIn,
        child: Text(
          "Registrieren",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
