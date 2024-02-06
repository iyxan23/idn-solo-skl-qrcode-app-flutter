import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          body: Stack(
            children: [
              MobileScanner(
                controller: MobileScannerController(
                  detectionSpeed: DetectionSpeed.noDuplicates,
                  returnImage: true,
                ),
                onDetect: (capture) {
                  final List<Barcode> barcodes = capture.barcodes;
                  final Uint8List? image = capture.image;

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
                          ),
                        );
                      },
                    );
                  }
                },
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0x00000000),
                    border: Border.symmetric(
                        vertical: BorderSide(
                          color: Colors
                              .black45, // Adjust opacity and color as needed
                          width: (MediaQuery.of(context).size.width / 2) - 100,
                        ),
                        horizontal: BorderSide(
                          color: Colors
                              .black45, // Adjust opacity and color as needed
                          width: (MediaQuery.of(context).size.height / 2) - 100,
                        )),
                  ),
                  child: Center(
                    child: Container(
                      // Centering indicator (e.g., SizedBox, CircleAvatar)
                      width: 50.0,
                      height: 50.0,
                      decoration: const BoxDecoration(
                        color: Colors
                            .white38, // Adjust opacity and color as needed
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
              const Positioned.fill(
                top: 300,
                child: SizedBox(
                  width: 300,
                  child: Center(
                    child: Text(
                      "Point to a QR Code to scan",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 100,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.transparent,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        "Scan a QR Code",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
