import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: width * (1 / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: "scan",
                child: BigButton(
                  text: "SCAN",
                  icon: const Icon(
                    Icons.qr_code_scanner,
                    color: Colors.white,
                    size: 48,
                  ),
                  onClick: () {
                    Navigator.pushNamed(context, "/scan");
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Hero(
                tag: "generate",
                child: BigButton(
                  text: "GENERATE",
                  icon: const Icon(
                    Icons.qr_code_2,
                    color: Colors.white,
                    size: 48,
                  ),
                  onClick: () {
                    Navigator.pushNamed(context, "/generate");
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

class BigButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback onClick;
  const BigButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: Theme.of(context).primaryColor,
      child: InkWell(
        onTap: onClick,
        borderRadius: BorderRadius.circular(16),
        splashColor: Colors.white.withAlpha(100),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.withAlpha(50),
                offset: Offset.zero,
                blurRadius: 16,
              ),
            ],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              icon,
              const SizedBox(
                height: 16,
              ),
              Text(
                text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
