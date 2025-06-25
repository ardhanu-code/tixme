import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tixme/const/app_color.dart';
import 'package:tixme/pages/main_menu/details_movie/details_page.dart';
import 'package:tixme/pages/main_menu/list_movie/list_movie_page.dart';
import 'package:tixme/pages/profile/profile_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<String> _moviePosters = [
    'https://www.movieposters.com/cdn/shop/files/Gladiator.mpw.102813_480x.progressive.jpg?v=1707500493',
    'https://www.movieposters.com/cdn/shop/files/ItemR85530_jpg_480x.progressive.jpg?v=1682536001',
    'https://www.movieposters.com/cdn/shop/files/jurassicpark.mpw_480x.progressive.jpg?v=1713805481',
    'https://www.movieposters.com/cdn/shop/products/6cd691e19fffbe57b353cb120deaeb8f_8489d7bf-24ba-4848-9d0f-11f20cb35025_480x.progressive.jpg?v=1573613877',
    'https://www.movieposters.com/cdn/shop/files/darkknight.building.24x36_20e90057-f673-4cc3-9ce7-7b0d3eeb7d83_480x.progressive.jpg?v=1707491191',
  ];
  final List<String> _bannerMovies = [
    'https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/p2/01/2024/01/24/Snapinstaapp_420655547_7990717357610171_3553154605950509796_n_1080-1-4279030997.jpg',
    'https://idseducation.com/wp-content/uploads/2024/10/Contoh-desain-grafis-dan-film-poster-film-inception.jpg',
    'https://image.idntimes.com/post/20240927/picsart-24-09-27-14-05-30-383-min-ff7c3661b0d1c7b8cdf6bef66bbcc704.jpg',
  ];
  final PageController _controller = PageController();
  final String iconImageUrl = 'assets/icons';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(),
                              ),
                            );
                          },
                          iconSize: 26,
                          icon: const Icon(
                            Icons.person_outline,
                            color: Colors.white,
                          ),
                          tooltip: 'Profile',
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white38,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: CarouselSlider(
                    items:
                        _bannerMovies
                            .map(
                              (e) => Container(
                                width: double.infinity,
                                child: ClipRRect(
                                  child: Image.network(
                                    e,
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 300),
                      autoPlayCurve: Curves.easeInOut,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Now Showing',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailsPage(),
                          ),
                        );
                      },
                      child: Text(
                        'See All Movies',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 150,
                  child: PageView.builder(
                    padEnds: false,
                    controller: PageController(viewportFraction: 0.3),
                    itemCount: _moviePosters.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => DetailsPage(
                                        imageUrl: _moviePosters[index],
                                      ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'now_showing_${_moviePosters[index]}',
                              child: Image.network(
                                _moviePosters[index],
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) => Center(
                                      child: Icon(
                                        Icons.broken_image,
                                        color: AppColor.secondaryColor,
                                        size: 48,
                                      ),
                                    ),
                                loadingBuilder: (
                                  context,
                                  child,
                                  loadingProgress,
                                ) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                      color: AppColor.secondaryColor,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Coming Soon',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 150,
                  child: PageView.builder(
                    padEnds: false,
                    controller: PageController(viewportFraction: 0.3),
                    itemCount: _moviePosters.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => DetailsPage(
                                        imageUrl: _moviePosters[index],
                                      ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'coming_soon_${_moviePosters[index]}',
                              child: Image.network(
                                _moviePosters[index],
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) => Center(
                                      child: Icon(
                                        Icons.broken_image,
                                        color: AppColor.secondaryColor,
                                        size: 48,
                                      ),
                                    ),
                                loadingBuilder: (
                                  context,
                                  child,
                                  loadingProgress,
                                ) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                      color: AppColor.secondaryColor,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildButton(String text, VoidCallback onPressed, String image) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      elevation: 5,
      backgroundColor: Colors.white38,
      minimumSize: Size(double.infinity, 54),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, width: 18, height: 18),
        const SizedBox(width: 10),
        Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    ),
  );
}
