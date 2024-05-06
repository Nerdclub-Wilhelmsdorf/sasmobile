
// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sasmobile/main.dart';

class QrPage extends StatelessWidget {
  const QrPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text("Code von $id:", style: TextStyle(fontSize: 30)),
          ),
          QrImageView(
          data: "w:$id",
          backgroundColor: Colors.white,
          version: QrVersions.auto,
          size: MediaQuery.sizeOf(context).width * 0.8,
),

          Spacer()
        ],
      ),
    );
      
  }
}

