import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import 'dashboard.dart';
import 'upload.dart';
import 'history.dart';
import 'login.dart'; 

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 3;

  final nameCtl = TextEditingController(text: "Resto Eco Hijau");
  final emailCtl = TextEditingController(text: "eco.hijau@gmail.com");
  final passCtl = TextEditingController(text: "rahasia123");
  bool obscurePass = true;

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    Widget? nextScreen;
    switch (index) {
      case 0:
        nextScreen = const DashboardScreen();
        break;
      case 1:
        nextScreen = const UploadScreen();
        break;
      case 2:
        nextScreen = const HistoryScreen();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => nextScreen!),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1B4332),
        ),
      ),
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
          "Profil Pengguna",
          style: TextStyle(
            color: Color(0xFF1B4332),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                // langsung pindah ke halaman login tanpa alert/snackbar
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF2D6A4F),
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Color(0xFFD8F3DC),
                  child: Icon(Icons.person, size: 65, color: Color(0xFF2D6A4F)),
                ),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF2D6A4F),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 35),

            // Textfield
            _buildFieldLabel("Nama"),
            const SizedBox(height: 8),
            TextField(
              controller: nameCtl,
              decoration: InputDecoration(
                hintText: "Nama perusahaan / resto",
                suffixIcon: const Icon(Icons.person),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 18),

            _buildFieldLabel("Email"),
            const SizedBox(height: 8),
            TextField(
              controller: emailCtl,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "contoh@domain.com",
                suffixIcon: const Icon(Icons.email_outlined),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 18),

            _buildFieldLabel("Password"),
            const SizedBox(height: 8),
            TextField(
              controller: passCtl,
              obscureText: obscurePass,
              decoration: InputDecoration(
                hintText: "••••••••",
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePass ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey[700],
                  ),
                  onPressed: () => setState(() => obscurePass = !obscurePass),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Button perbarui
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profil berhasil diperbarui!'),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D6A4F),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Perbarui Profil",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Button batal
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const DashboardScreen()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: Color(0xFF2D6A4F)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Batal",
                  style: TextStyle(color: Color(0xFF2D6A4F), fontSize: 16),
                ),
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
    );
  }
}
