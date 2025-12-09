import 'package:flutter/material.dart';

class ViewPaymentProofScreen extends StatelessWidget {
  final String imagePath;

  const ViewPaymentProofScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bukti Pembayaran"),
      ),
      body: Center(
        child: imagePath.isEmpty
            ? const Text("Tidak ada bukti pembayaran.")
            : Image.asset(imagePath, fit: BoxFit.contain),
      ),
    );
  }
}
