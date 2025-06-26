import 'package:flutter/material.dart';
import 'package:tixme/const/app_color.dart';
import 'package:tixme/pages/auth_page/login_page.dart';
import 'package:tixme/pages/jadwal_page/jadwal_detail_page.dart';
import 'package:tixme/services/jadwal_service.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  List<dynamic> _schedules = [];
  bool _isLoading = true;
  String _error = '';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchSchedules();
  }

  Future<void> _fetchSchedules() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });
    try {
      final data = await JadwalService.getSchedules();
      setState(() {
        _schedules = data['data'] ?? [];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  List<dynamic> get _filteredSchedules {
    if (_searchQuery.isEmpty) {
      return _schedules;
    }
    return _schedules.where((schedule) {
      final movieTitle =
          schedule['film']['title']?.toString().toLowerCase() ?? '';
      return movieTitle.contains(_searchQuery.toLowerCase());
    }).toList();
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

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                filled: true,
                fillColor: AppColor.accentColor,
                prefixIcon: Icon(Icons.search, color: AppColor.textColor),
                hintText: 'Cari nama film...',
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
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Jadwal Film Tersedia',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
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
                      : _filteredSchedules.isEmpty
                      ? Center(
                        child: Text(
                          'Tidak ada jadwal film ditemukan.',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                      : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.75,
                            ),
                        itemCount: _filteredSchedules.length,
                        itemBuilder: (context, index) {
                          final schedule = _filteredSchedules[index];
                          final film = schedule['film'] ?? {};
                          final imageUrl =
                              film['image_url'] ?? film['image_base64'] ?? '';
                          final heroTag = 'filmImage_${film['id'] ?? index}';

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => JadwalDetailPage(
                                        schedule: schedule,
                                        heroTag: heroTag,
                                        formatDateTime: _formatDateTime,
                                      ),
                                ),
                              );
                            },
                            child: Card(
                              margin: const EdgeInsets.all(4),
                              color: AppColor.accentColor,
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColor.accentColor,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child:
                                            imageUrl.isNotEmpty
                                                ? Hero(
                                                  tag: heroTag,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          16,
                                                        ),
                                                    child: Image.network(
                                                      imageUrl,
                                                      fit: BoxFit.cover,
                                                      errorBuilder:
                                                          (
                                                            context,
                                                            error,
                                                            stackTrace,
                                                          ) => Icon(
                                                            Icons.movie,
                                                            color:
                                                                AppColor
                                                                    .textColor,
                                                          ),
                                                    ),
                                                  ),
                                                )
                                                : Icon(
                                                  Icons.movie,
                                                  color: AppColor.textColor,
                                                  size: 48,
                                                ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      film['title'] ?? 'No Title',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.textColor,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Jam Tayang: ${_formatDateTime(schedule['start_time'])}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColor.textColor,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                  ],
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
    );
  }

  String _formatDateTime(String? dateTimeString) {
    if (dateTimeString == null) return 'Tidak tersedia';
    try {
      final dateTime = DateTime.parse(dateTimeString);
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return 'Format tidak valid';
    }
  }
}
