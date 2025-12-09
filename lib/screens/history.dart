import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'upload.dart';
import 'profile.dart';
import 'payment_proof_upload.dart';
import 'payment_offset_screen.dart';
import 'view_payment_proof.dart'; // <--- TAMBAH INI SAJA
import '../widgets/chatbot_popup.dart';
import '../widgets/bottom_nav.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    Widget nextScreen;
    switch (index) {
      case 0:
        nextScreen = const DashboardScreen();
        break;
      case 1:
        nextScreen = const UploadScreen();
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

  /// DATA SIMULASI
  final List<Map<String, dynamic>> history = [
    {
      'date': '2025-10-31',
      'total': 27.5,
      'category': 'Sedang',
      'file': 'Analisis_2025-10-31.pdf',
      'isPaid': false,
      'proof': null,
    },
    {
      'date': '2025-10-24',
      'total': 15.2,
      'category': 'Rendah',
      'file': 'Analisis_2025-10-24.pdf',
      'isPaid': true,
      'proof': 'assets/payment_proofs/bukti1.jpg', // contoh
    },
    {
      'date': '2025-10-17',
      'total': 41.8,
      'category': 'Tinggi',
      'file': 'Analisis_2025-10-17.pdf',
      'isPaid': false,
      'proof': null,
    },
  ];

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Rendah':
        return const Color(0xFF2D6A4F);
      case 'Sedang':
        return const Color(0xFFFFB703);
      case 'Tinggi':
        return const Color(0xFFD00000);
      default:
        return Colors.grey;
    }
  }

  /// BUTTON STYLE
  Widget _modernButton({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18, color: const Color(0xFF1B4332)),
      label: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF1B4332),
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFF9BA9A7)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }

  /// BUTTON Aksi
  Widget _actionButtons(Map<String, dynamic> item) {
    if (!item['isPaid']) {
      return Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          _modernButton(
            text: "Unduh PDF",
            icon: Icons.download_rounded,
            onTap: () {},
          ),
          _modernButton(
            text: "Bayar Offset",
            icon: Icons.payment_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PaymentOffsetScreen()),
              );
            },
          ),
          _modernButton(
            text: "Upload Bukti",
            icon: Icons.upload_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      PaymentProofUploadScreen(analysisDate: item['date']),
                ),
              );
            },
          ),
        ],
      );
    }

    // SUDAH BAYAR
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _modernButton(
          text: "Unduh PDF",
          icon: Icons.download_rounded,
          onTap: () {},
        ),
        _modernButton(
          text: "Lihat Bukti",
          icon: Icons.attachment_rounded,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    ViewPaymentProofScreen(imagePath: item['proof']),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FBF5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'Riwayat Analisis',
          style: TextStyle(
            color: Color(0xFF1B4332),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: _card(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Riwayat Analisis Emisi Karbon",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF1B4332),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Column(
                    children: history.map((item) {
                      final color = _getCategoryColor(item['category']);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              item['date'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1B4332),
                              ),
                            ),
                            subtitle: Text(
                              "Total: ${item['total']} kg CO₂e • ${item['category']}",
                              style: TextStyle(
                                color: color,
                                fontSize: 13.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(
                                left: 4, right: 4, bottom: 12),
                            child: _actionButtons(item),
                          ),
                        ],
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar:
          CustomBottomNav(currentIndex: _selectedIndex, onTap: _onItemTapped),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (_) => const ChatbotPopup());
        },
        backgroundColor: const Color(0xFF2D6A4F),
        child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
      ),
    );
  }

  BoxDecoration _card() {
    return BoxDecoration(
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
    );
  }
}
