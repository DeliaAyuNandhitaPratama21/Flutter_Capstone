import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'upload.dart';
import 'profile.dart';
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
    setState(() => _selectedIndex = index);

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

  final List<Map<String, String>> history = [
    {
      'date': '2025-10-31',
      'total': '27.5',
      'category': 'Sedang',
      'file': 'Analisis_2025-10-31.pdf'
    },
    {
      'date': '2025-10-24',
      'total': '15.2',
      'category': 'Rendah',
      'file': 'Analisis_2025-10-24.pdf'
    },
    {
      'date': '2025-10-17',
      'total': '41.8',
      'category': 'Tinggi',
      'file': 'Analisis_2025-10-17.pdf'
    },
  ];

  final List<String> monthlyReports = [
    'November 2025',
    'Oktober 2025',
    'September 2025',
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
            // Card riwayat analisis
            Container(
              width: double.infinity,
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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Riwayat Analisis Emisi Karbon",
                    style: TextStyle(
                      color: Color(0xFF1B4332),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Hasil analisis emisi karbon Anda yang telah dilakukan sebelumnya.",
                    style: TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                  const SizedBox(height: 12),

                  // Daftar Riwayat
                  Column(
                    children: history.map((item) {
                      final categoryColor =
                          _getCategoryColor(item['category']!);
                      return Column(
                        children: [
                          const Divider(),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              item['date']!,
                              style: const TextStyle(
                                color: Color(0xFF1B4332),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            subtitle: Text(
                              "Total: ${item['total']} kg CO₂e • ${item['category']}",
                              style: TextStyle(
                                color: categoryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 13.5,
                              ),
                            ),
                            trailing: OutlinedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Mengunduh ${item['file']} (simulasi)...'),
                                    behavior: SnackBarBehavior.floating,
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.download_rounded,
                                size: 18,
                                color: Color(0xFF2D6A4F),
                              ),
                              label: const Text(
                                "Unduh PDF",
                                style: TextStyle(
                                  color: Color(0xFF2D6A4F),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side:
                                    const BorderSide(color: Color(0xFF2D6A4F)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Card laporan bulanan
            Container(
              width: double.infinity,
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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Laporan Emisi Bulanan",
                    style: TextStyle(
                      color: Color(0xFF1B4332),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Unduh laporan emisi karbon bulanan untuk mendukung langkah hijau bisnis Anda.",
                    style: TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: monthlyReports.map((month) {
                      return Column(
                        children: [
                          const Divider(),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              month,
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 15),
                            ),
                            trailing: OutlinedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Mengunduh laporan $month (simulasi)...'),
                                    behavior: SnackBarBehavior.floating,
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.download_rounded,
                                size: 18,
                                color: Color(0xFF2D6A4F),
                              ),
                              label: const Text(
                                "Unduh PDF",
                                style: TextStyle(
                                  color: Color(0xFF2D6A4F),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side:
                                    const BorderSide(color: Color(0xFF2D6A4F)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Navbar
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
    );
  }
}
