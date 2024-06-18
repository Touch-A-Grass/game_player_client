import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreen extends StatelessWidget {
  const QrScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Lobby Code'),
        actions: [
          IconButton(
            onPressed: () {
              WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.of(context).pop());
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: SafeArea(
        child: MobileScanner(
          onDetect: (data) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => Navigator.of(context).pop(data.barcodes.firstOrNull?.rawValue),
            );
          },
        ),
      ),
    );
  }
}
