import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanCodePage extends StatefulWidget {
  const ScanCodePage({super.key});

  @override
  State<ScanCodePage> createState() => _ScanCodePageState();
}

class _ScanCodePageState extends State<ScanCodePage> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "scan",
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Scan QR Code'),
        ),
        body: MobileScanner(
          controller: MobileScannerController(
            detectionSpeed: DetectionSpeed.noDuplicates,
            returnImage: true,
          ),
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            final Uint8List? image = capture.image;

            for (final barcode in barcodes) {
              print("Barcode found! ${barcode.rawValue}");
            }

            if (image != null) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        title: Text(
                          barcodes.first.rawValue ?? "",
                        ),
                        content: Image(
                          image: MemoryImage(image),
                        ));
                  });
            }
          },
        ),
      ),
    );
  }
}
