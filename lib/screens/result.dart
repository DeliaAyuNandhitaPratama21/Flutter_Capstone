import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'history.dart'; 

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  // Fungsi buka URL
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Tidak dapat membuka $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FBF5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        automaticallyImplyLeading: false, 
        title: const Text(
          'Hasil Analisis Emisi',
          style: TextStyle(
            color: Color(0xFF1B4332),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDataTable(),
            const SizedBox(height: 24),
            _buildCategorySection(),
            const SizedBox(height: 24),
            _buildOffsetEstimation(),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman HistoryScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HistoryScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D6A4F),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Keluar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Data tabel
  Widget _buildDataTable() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Data Terekstrak dari Nota",
            style: TextStyle(
              color: Color(0xFF1B4332),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Table(
            border: const TableBorder(
              horizontalInside: BorderSide(color: Colors.grey, width: 0.3),
            ),
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
            },
            children: const [
              TableRow(
                decoration: BoxDecoration(color: Color(0xFFF0F0F0)),
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Bahan',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Berat (kg)',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Emisi (kg CO₂e)',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              TableRow(children: [
                Padding(
                    padding: EdgeInsets.all(8.0), child: Text('Daging Sapi')),
                Padding(padding: EdgeInsets.all(8.0), child: Text('2.5')),
                Padding(padding: EdgeInsets.all(8.0), child: Text('27.5')),
              ]),
              TableRow(children: [
                Padding(
                    padding: EdgeInsets.all(8.0), child: Text('Sayuran Segar')),
                Padding(padding: EdgeInsets.all(8.0), child: Text('1.8')),
                Padding(padding: EdgeInsets.all(8.0), child: Text('0.9')),
              ]),
              TableRow(children: [
                Padding(padding: EdgeInsets.all(8.0), child: Text('Beras')),
                Padding(padding: EdgeInsets.all(8.0), child: Text('5.0')),
                Padding(padding: EdgeInsets.all(8.0), child: Text('6.5')),
              ]),
              TableRow(children: [
                Padding(padding: EdgeInsets.all(8.0), child: Text('Telur')),
                Padding(padding: EdgeInsets.all(8.0), child: Text('1.2')),
                Padding(padding: EdgeInsets.all(8.0), child: Text('3.6')),
              ]),
              TableRow(children: [
                Padding(
                    padding: EdgeInsets.all(8.0), child: Text('Minyak Goreng')),
                Padding(padding: EdgeInsets.all(8.0), child: Text('2.0')),
                Padding(padding: EdgeInsets.all(8.0), child: Text('4.2')),
              ]),
              TableRow(
                decoration: BoxDecoration(color: Color(0xFFDADADA)),
                children: [
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Total',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('12.5',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('42.7',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Kategori emisi
  Widget _buildCategorySection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Kategori Emisi",
            style: TextStyle(
              color: Color(0xFF1B4332),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildEmissionBar("Daging & Produk Hewani", 0.65, Colors.red),
          _buildEmissionBar("Bahan Pokok", 0.25, Colors.amber),
          _buildEmissionBar("Sayuran & Buah", 0.10, Colors.green),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFD1F4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(12),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, color: Color(0xFF1B4332)),
                    SizedBox(width: 6),
                    Text(
                      "Kategori Emisi: Sedang",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1B4332),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  "Emisi karbon Anda tergolong sedang. Kurangi pembelian produk hewani untuk menurunkannya.",
                  style: TextStyle(fontSize: 13, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Estimasi biaya offset
  Widget _buildOffsetEstimation() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Estimasi Biaya Carbon Offset",
            style: TextStyle(
              color: Color(0xFF1B4332),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildOffsetItem("Total Emisi", "42.7 kg CO₂e", Colors.green),
          _buildOffsetItem("Harga per kg CO₂e", "Rp 1.200", Colors.black),
          _buildOffsetItem("Total Biaya Offset", "Rp 51.240", Colors.blue),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 12),
          const Text(
            "Platform Carbon Offset yang Direkomendasikan:",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1B4332),
            ),
          ),
          const SizedBox(height: 10),
          _buildLinkCard(
            title: "Gold Standard Reforestation",
            url: "https://www.goldstandard.org",
            color: const Color(0xFFE6F4EA),
          ),
          _buildLinkCard(
            title: "CarbonClick Renewable Energy",
            url: "https://www.carbonclick.com",
            color: const Color(0xFFE8F0FE),
          ),
          _buildLinkCard(
            title: "Pachama Forest Restoration",
            url: "https://www.pachama.com",
            color: const Color(0xFFF3E8FF),
          ),
        ],
      ),
    );
  }

  // Wiget helper
  Widget _buildLinkCard({
    required String title,
    required String url,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () => _launchURL(url),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              const Icon(Icons.public, color: Color(0xFF1B4332)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1B4332),
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const Icon(Icons.open_in_new, color: Colors.grey, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOffsetItem(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  Widget _buildEmissionBar(String label, double value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 14)),
              Text("${(value * 100).toInt()}%",
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 10,
              backgroundColor: Colors.grey.shade300,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
