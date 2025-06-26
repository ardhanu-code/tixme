import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tixme/const/app_color.dart';

class DetailsPage extends StatelessWidget {
  final String imageUrl;
  final String movieName;
  final String sinopsis;
  final String director;
  final List<String> writers;
  final List<String> stars;

  const DetailsPage({
    super.key,
    required this.imageUrl,
    this.movieName = "Movie Title",
    this.sinopsis =
        "This is a brief synopsis of the movie. It gives an overview of the plot and main themes.",
    this.director = "Director Name",
    this.writers = const ["Writer 1", "Writer 2"],
    this.stars = const ["Star 1", "Star 2", "Star 3"],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: Text('Detail Film', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColor.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background: Blurred poster image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: SizedBox(
                      height: 320,
                      width: double.infinity,
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        color: Colors.black.withOpacity(0.4),
                        colorBlendMode: BlendMode.darken,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                Container(color: Colors.grey[800]),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: SizedBox(
                      height: 320,
                      width: double.infinity,
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) =>
                                  Container(color: Colors.grey[800]),
                        ),
                      ),
                    ),
                  ),
                  // Foreground: Hero poster image
                  Hero(
                    tag: imageUrl,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        imageUrl,
                        height: 240,
                        width: 160,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) => Container(
                              height: 240,
                              width: 160,
                              color: Colors.grey[800],
                              child: const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  color: Colors.white,
                                  size: 64,
                                ),
                              ),
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              movieName,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              sinopsis,
              textAlign: TextAlign.justify,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Director: ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    director,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Writers: ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    writers.join(', '),
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Status: ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    stars.join(', '),
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                _showDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.secondaryColor,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Set jadwal tayang',
                style: TextStyle(color: AppColor.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text('Set jadwal tayang'),
          content: Column(
            children: [
              Text('Pilih tanggal tayang'),
              Text('Pilih jam tayang'),
              Text('Pilih studio'),
            ],
          ),
        ),
  );
}
