import 'package:flutter/material.dart';
import 'package:sasmobile/frame.dart';
import "package:sasmobile/theme.dart";
void main() {
  runApp(const MainPage());
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: const MaterialThemeCustom(TextTheme()).light(),
      darkTheme: const MaterialThemeCustom(TextTheme()).light(),
      home: Scaffold(

        body: Center(
          child: Frame(),
        ),
      ),
    );
  }
}

