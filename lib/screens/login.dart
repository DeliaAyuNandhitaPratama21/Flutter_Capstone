import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtl = TextEditingController();
  final passCtl = TextEditingController();
  bool rememberMe = false;
  bool obscurePass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD8F3DC),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo 
                Column(
                  children: [
                    Image.asset(
                      'assets/images/logo carbon.png', // Logo kamu
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Kotak form login
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1B4332),
                              ),
                            ),
                            const SizedBox(height: 6),
                            GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, '/register'),
                              child: const Text.rich(
                                TextSpan(
                                  text: "Belum punya akun? ",
                                  style: TextStyle(color: Colors.black54),
                                  children: [
                                    TextSpan(
                                      text: "Daftar",
                                      style: TextStyle(
                                        color: Color(0xFF40916C),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Textfield
                      const Text(
                        "Email",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: emailCtl,
                        decoration: InputDecoration(
                          hintText: "Masukkan email",
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      const Text(
                        "Password",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: passCtl,
                        obscureText: obscurePass,
                        decoration: InputDecoration(
                          hintText: "Masukkan password",
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscurePass
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () =>
                                setState(() => obscurePass = !obscurePass),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Remember me + lupa password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: rememberMe,
                                onChanged: (v) =>
                                    setState(() => rememberMe = v!),
                                activeColor: const Color(0xFF52B788),
                              ),
                              const Text("Ingat saya"),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              overlayColor: Colors.transparent,
                              foregroundColor: const Color(0xFF40916C),
                            ),
                            child: const Text(
                              "Lupa Password?",
                              style: TextStyle(color: Color(0xFF40916C)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Button login
                      ElevatedButton(
                        onPressed: () {
                          if (emailCtl.text.isNotEmpty &&
                              passCtl.text.isNotEmpty) {
                            Navigator.pushReplacementNamed(
                                context, '/dashboard');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Harap isi semua kolom terlebih dahulu'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: const Color(0xFF2D6A4F),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Masuk',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Pembatas atau
                      const Row(
                        children: [
                          Expanded(child: Divider(thickness: 1)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text("Atau"),
                          ),
                          Expanded(child: Divider(thickness: 1)),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Login dengan google
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: Image.network(
                          'https://cdn-icons-png.flaticon.com/512/2991/2991148.png',
                          height: 20,
                        ),
                        label: const Text(
                          'Masuk dengan Google',
                          style: TextStyle(color: Colors.black54),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black54,
                          side: const BorderSide(color: Colors.black26),
                          minimumSize: const Size(double.infinity, 48),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
