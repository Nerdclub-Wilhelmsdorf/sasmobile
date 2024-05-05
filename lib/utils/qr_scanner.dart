import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();

enum QrApplication {
  sender,
  register
}

class QrDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Text('QR Dialog'),
    );
  }
}