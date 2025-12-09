import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentOffsetScreen extends StatelessWidget {
  const PaymentOffsetScreen({super.key});

  final String websiteName = "Lindungi Hutan";
  final String websiteURL = "https://lindungihutan.com/";

  Future<void> openWebsite() async {
    final Uri url = Uri.parse("https://lindungihutan.com/");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Tidak dapat membuka situs!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FBF5),

      appBar: AppBar(
        title: const Text(
          "Bayar Carbon Offset",
          style: TextStyle(
            color: Color(0xFF1B4332),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE0E0E0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Pembayaran Carbon Offset",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF1B4332),
                ),
              ),

              const SizedBox(height: 12),
              Text(
                "Anda akan diarahkan ke website resmi untuk melakukan "
                "donasi penanaman pohon:",
                style: TextStyle(color: Colors.grey.shade800),
              ),

              const SizedBox(height: 20),

              Text(
                "Website:",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.w600),
              ),

              Text(
                websiteName,
                style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF1B4332),
                    fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 6),

              Text(
                websiteURL,
                style: const TextStyle(
                    fontSize: 14, color: Color(0xFF2D6A4F)),
              ),

              const Spacer(),

              ElevatedButton(
                onPressed: openWebsite,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B4332),
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Buka Website",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
