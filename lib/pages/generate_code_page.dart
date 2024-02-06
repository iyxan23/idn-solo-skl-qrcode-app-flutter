import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:screenshot/screenshot.dart';

class GenerateCodePage extends StatefulWidget {
  const GenerateCodePage({super.key});

  @override
  State<GenerateCodePage> createState() => _GenerateCodePageState();
}

class _GenerateCodePageState extends State<GenerateCodePage> {
  final ScreenshotController screenshotController = ScreenshotController();
  String? qrData;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "generate",
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Generate QR Code'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Insert text",
                ),
                onChanged: (txt) {
                  setState(() {
                    qrData = txt;
                  });
                },
              ),
              if (qrData != null)
                SizedBox.fromSize(
                  size: const Size(128, 128),
                  child: PrettyQrView.data(data: qrData!),
                ),
              if (qrData != null)
                ElevatedButton.icon(
                  onPressed: () async {
                    final qr = await screenshotController
                        .captureFromWidget(PrettyQrView.data(data: qrData!));

                    await FileSaver.instance.saveAs(
                      name: "qrcode",
                      bytes: qr,
                      ext: "png",
                      mimeType: MimeType.png,
                    );
                  },
                  icon: const Icon(Icons.save),
                  label: const Text("Save QR Code"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
