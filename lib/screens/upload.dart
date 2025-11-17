import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'history.dart';
import 'profile.dart';
import 'result.dart';
import '../widgets/chatbot_popup.dart';
import '../widgets/bottom_nav.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    Widget nextScreen;
    switch (index) {
      case 0:
        nextScreen = const DashboardScreen();
        break;
      case 1:
        return;
      case 2:
        nextScreen = const HistoryScreen();
        break;
      case 3:
        nextScreen = const ProfileScreen();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FBF5),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Upload Data Produksi & Pembelian',
          style: TextStyle(
            color: Color(0xFF1B4332),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildUploadCard(),
                  const SizedBox(height: 20),
                  _buildExtractionCard(context),
                ],
              ),
            ),
          ),
        ),
      ),

      // Floating chatbot
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const ChatbotPopup(),
          );
        },
        backgroundColor: const Color(0xFF2D6A4F),
        child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
      ),

      // Navbar
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  // Card upload file
  Widget _buildUploadCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Unggah Dokumen",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF1B4332),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Seret dan lepas file struk, invoice, atau Excel ke area di bawah.",
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 20),
          Container(
            height: 180,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload, size: 60, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("Klik atau seret file ke sini",
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Card hasil ekstraksi
  Widget _buildExtractionCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hasil Ekstraksi Data (Simulasi OCR)",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF1B4332),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Periksa dan perbaiki data yang diekstraksi sebelum melanjutkan analisis.",
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 20),

          // Table header
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE0E0E0)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Table(
              border: TableBorder.symmetric(
                inside: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
              },
              children: const [
                TableRow(
                  decoration: BoxDecoration(color: Color(0xFFF1F5F2)),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Nama Bahan',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Jumlah',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Satuan',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Button analisis
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF2D6A4F),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              textStyle: const TextStyle(fontSize: 15),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ResultScreen()),
              );
            },
            child: const Text("Analisis"),
          ),
        ],
      ),
    );
  }
}
