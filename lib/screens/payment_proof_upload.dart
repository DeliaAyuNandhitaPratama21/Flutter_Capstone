import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PaymentProofUploadScreen extends StatefulWidget {
  final String analysisDate;

  const PaymentProofUploadScreen({
    super.key,
    required this.analysisDate,
  });

  @override
  State<PaymentProofUploadScreen> createState() =>
      _PaymentProofUploadScreenState();
}

class _PaymentProofUploadScreenState extends State<PaymentProofUploadScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  /// Pilih dari galeri
  Future<void> pickImageGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    setState(() => _selectedImage = File(pickedFile.path));
  }

  /// Pilih dari kamera
  Future<void> pickImageCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) return;
    setState(() => _selectedImage = File(pickedFile.path));
  }

  /// Upload (simulasi)
  void uploadFile() {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Silakan pilih bukti pembayaran terlebih dahulu."),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // TODO: Kirim file ke backend API /payment-proof/upload

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Bukti pembayaran berhasil diupload!"),
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FBF5),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          "Upload Bukti Pembayaran",
          style: TextStyle(
            color: Color(0xFF1B4332),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tanggal Analisis: ${widget.analysisDate}",
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE0E0E0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Unggah Bukti Pembayaran",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B4332),
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 10),

                  const Text(
                    "Pastikan bukti pembayaran menampilkan nama platform resmi "
                    "(contoh: 'Lindungi Hutan') agar dapat diverifikasi.",
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),

                  const SizedBox(height: 16),

                  /// PREVIEW GAMBAR
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      color: Colors.grey.shade100,
                    ),
                    child: _selectedImage == null
                        ? const Center(
                            child: Text(
                              "Belum ada gambar bukti pembayaran",
                              style: TextStyle(color: Colors.black54),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),

                  const SizedBox(height: 16),

                  /// TOMBOL GALERI & KAMERA
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: pickImageGallery,
                          icon: const Icon(Icons.photo_library_rounded,
                              color: Color(0xFF1B4332)),
                          label: const Text(
                            "Galeri",
                            style: TextStyle(color: Color(0xFF1B4332)),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF9BA9A7)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: pickImageCamera,
                          icon: const Icon(Icons.photo_camera_rounded,
                              color: Color(0xFF1B4332)),
                          label: const Text(
                            "Kamera",
                            style: TextStyle(color: Color(0xFF1B4332)),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF9BA9A7)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// TOMBOL UPLOAD
                  ElevatedButton(
                    onPressed: uploadFile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B4332),
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Upload Bukti Pembayaran",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
