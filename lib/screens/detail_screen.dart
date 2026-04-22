import 'package:flutter/material.dart';
import '../models/word_model.dart';

class DetailScreen extends StatelessWidget {
  final Word word;

  const DetailScreen({Key? key, required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          word.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Üst kısımdaki büyük resim alanı
            Container(
              width: double.infinity,
              color: const Color(0xFFF5F3FF),
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Hero(
                tag: word.id,
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 220),
                  child: word.imagePath2 != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Image.asset(
                                word.imagePath,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Image.asset(
                                word.imagePath2!,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        )
                      : (word.imagePath.isNotEmpty
                          ? Image.asset(
                              word.imagePath,
                              fit: BoxFit.contain,
                            )
                          : const Center(
                              child: Icon(
                                Icons.science_outlined,
                                size: 80,
                                color: Color(0xFFC084FC),
                              ),
                            )),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Tanım'),
                  _buildTextContent(word.description),
                  
                  if (word.dailyLife.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    _buildSectionTitle('Günlük Yaşam Bağlantısı'),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF), // lightest blue
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFBFDBFE), width: 1), // blue border
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 2.0),
                            child: Icon(Icons.home_rounded, color: Color(0xFF3B82F6), size: 24),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              word.dailyLife,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                color: Color(0xFF1E40AB), // dark blue
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 36),
                  _buildSectionTitle('Disiplinlerarası (STEM) Bağlantısı'),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAF5FF), // lightest purple
                      border: const Border(
                        left: BorderSide(width: 4, color: Color(0xFFC084FC)), // accent purple
                      ),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                        topLeft: Radius.circular(4),
                        bottomLeft: Radius.circular(4),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFC084FC).withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        )
                      ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.science_outlined, color: Color(0xFF9333EA)),
                            const SizedBox(width: 12),
                            const Text(
                              "STEM Yaklaşımı",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF7E22CE)),
                            )
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          word.experiment,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: Color(0xFF4C1D95),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 36),
                  _buildSectionTitle('Farklı Disiplinlerle İlişkilendirme'),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 2.0),
                          child: Icon(Icons.hub_rounded, color: Color(0xFF6B7280), size: 24),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            word.interdisciplinary,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF4B5563),
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: Color(0xFF1F2937),
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildTextContent(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 17,
        height: 1.7,
        color: Color(0xFF4B5563),
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
