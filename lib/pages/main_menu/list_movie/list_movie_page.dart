import 'package:flutter/material.dart';
import 'package:tixme/const/app_color.dart';
import 'package:tixme/pages/auth_page/login_page.dart';
import 'package:tixme/pages/main_menu/details_movie/details_page.dart';
import 'package:tixme/pages/main_menu/details_movie/tambah_data_movie.dart';
import 'package:tixme/services/movie_service.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({super.key});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  List<dynamic> _movies = [];
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });
    try {
      final data = await MovieService.getMovies();
      // Asumsikan response API: { "data": [ { ...movie... }, ... ] }
      setState(() {
        _movies = data['data'] ?? [];
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
    // Penanganan error token tidak ditemukan/expired
    if (_error.contains('Token not found') || _error.contains('401')) {
      Future.microtask(() {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
        );
      });
      return Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: Text(
          'Daftar Film Lengkap',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: AppColor.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        filled: true,
                        fillColor: AppColor.accentColor,
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColor.textColor,
                        ),
                        hintText: 'Search',
                        hintStyle: TextStyle(color: AppColor.textColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: AppColor.accentColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: AppColor.accentColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: AppColor.accentColor),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          shape: BoxShape.circle,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TambahDataMovie(),
                            ),
                          );
                          // Refresh movie list after adding
                          _fetchMovies();
                        },
                        iconSize: 26,
                        icon: const Icon(Icons.add, color: Colors.white),
                        tooltip: 'Profile',
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Expanded(
                child:
                    _isLoading
                        ? Center(
                          child: CircularProgressIndicator(
                            color: AppColor.secondaryColor,
                          ),
                        )
                        : _error.isNotEmpty
                        ? Center(
                          child: Text(
                            _error,
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                        : _movies.isEmpty
                        ? Center(
                          child: Text(
                            'Tidak ada film ditemukan.',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                        : GridView.builder(
                          itemCount: _movies.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                          itemBuilder: (context, index) {
                            final movie = _movies[index];
                            final imageUrl =
                                movie['image_url'] ??
                                movie['image_base64'] ??
                                '';
                            final heroTag =
                                'movie_hero_${movie['id'] ?? index}';

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => DetailsPage(
                                          imageUrl: imageUrl,
                                          movieName:
                                              movie['title'] ?? 'No Title',
                                          sinopsis: movie['description'] ?? '',
                                          director: movie['director'] ?? '',
                                          writers:
                                              movie['writer'] != null
                                                  ? (movie['writer'] is List
                                                      ? List<String>.from(
                                                        movie['writer'],
                                                      )
                                                      : [
                                                        movie['writer']
                                                            .toString(),
                                                      ])
                                                  : [],
                                          stars:
                                              movie['stats'] != null
                                                  ? (movie['stats'] is List
                                                      ? List<String>.from(
                                                        movie['stats'],
                                                      )
                                                      : [
                                                        movie['stats']
                                                            .toString(),
                                                      ])
                                                  : [],
                                        ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: heroTag,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child:
                                      imageUrl.isNotEmpty
                                          ? Image.network(
                                            imageUrl,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Center(
                                                      child: Icon(
                                                        Icons.broken_image,
                                                        color:
                                                            AppColor
                                                                .secondaryColor,
                                                        size: 48,
                                                      ),
                                                    ),
                                            loadingBuilder: (
                                              context,
                                              child,
                                              loadingProgress,
                                            ) {
                                              if (loadingProgress == null)
                                                return child;
                                              return Center(
                                                child: CircularProgressIndicator(
                                                  value:
                                                      loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              (loadingProgress
                                                                      .expectedTotalBytes ??
                                                                  1)
                                                          : null,
                                                  color:
                                                      AppColor.secondaryColor,
                                                ),
                                              );
                                            },
                                          )
                                          : Container(
                                            color: AppColor.accentColor,
                                            child: Center(
                                              child: Icon(
                                                Icons.movie,
                                                color: AppColor.secondaryColor,
                                                size: 48,
                                              ),
                                            ),
                                          ),
                                ),
                              ),
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
