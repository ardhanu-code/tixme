import 'package:flutter/material.dart';
import 'package:tixme/const/app_color.dart';
import 'package:tixme/services/movie_service.dart';

class CheckoutPage extends StatefulWidget {
  final Map<String, dynamic> schedule;
  final int filmId;
  final int quantity;

  const CheckoutPage({
    super.key,
    required this.schedule,
    required this.filmId,
    required this.quantity,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  Map<String, dynamic>? _movieData;
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _fetchMovieData();
  }

  Future<void> _fetchMovieData() async {
    try {
      final data = await MovieService.getMovies();
      final movies = data['data'] ?? [];

      // Find the movie with matching film ID
      final movie = movies.firstWhere(
        (movie) => movie['id'] == widget.filmId,
        orElse: () => {},
      );

      setState(() {
        _movieData = movie;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: Text('Checkout', style: TextStyle(color: AppColor.textColor)),
        backgroundColor: AppColor.primaryColor,
        foregroundColor: AppColor.textColor,
      ),
      body:
          _isLoading
              ? Center(
                child: CircularProgressIndicator(
                  color: AppColor.secondaryColor,
                ),
              )
              : _error.isNotEmpty
              ? Center(
                child: Text(
                  'Error: $_error',
                  style: TextStyle(color: Colors.red),
                ),
              )
              : _movieData == null
              ? Center(
                child: Text(
                  'Movie data not found',
                  style: TextStyle(color: Colors.white),
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Summary',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColor.textColor,
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.textColor),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              height: 145,
                              width: 120,
                              decoration: BoxDecoration(
                                color: AppColor.accentColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: _buildMovieImage(),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _movieData!['title'] ?? 'No Title',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.textColor,
                                    ),
                                  ),
                                  Text(
                                    'Genre: ${_movieData!['genre'] ?? 'Unknown'}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.textColor,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Tanggal: ${_formatDate(widget.schedule['start_time'])}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColor.textColor,
                                    ),
                                  ),
                                  Text(
                                    'Jam: ${_formatTime(widget.schedule['start_time'])}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColor.textColor,
                                    ),
                                  ),
                                  Text(
                                    'Jumlah Tiket: ${widget.quantity}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColor.textColor,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement ticket purchase API call
                        // Send schedule ID and quantity to API
                        print('Schedule ID: ${widget.schedule['id']}');
                        print('Quantity: ${widget.quantity}');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.accentColor,
                        minimumSize: Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Checkout',
                        style: TextStyle(color: AppColor.textColor),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _buildMovieImage() {
    final imageUrl =
        _movieData!['image_url'] ?? _movieData!['image_base64'] ?? '';

    if (imageUrl.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder:
              (context, error, stackTrace) =>
                  Icon(Icons.movie, color: Colors.white),
        ),
      );
    } else {
      return Icon(Icons.movie, color: Colors.white);
    }
  }

  String _formatDate(String? dateTimeString) {
    if (dateTimeString == null) return 'Tidak tersedia';
    try {
      final dateTime = DateTime.parse(dateTimeString);
      return '${dateTime.day.toString().padLeft(2, '0')} - ${dateTime.month.toString().padLeft(2, '0')} - ${dateTime.year}';
    } catch (e) {
      return 'Format tidak valid';
    }
  }

  String _formatTime(String? dateTimeString) {
    if (dateTimeString == null) return 'Tidak tersedia';
    try {
      final dateTime = DateTime.parse(dateTimeString);
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return 'Format tidak valid';
    }
  }
}
