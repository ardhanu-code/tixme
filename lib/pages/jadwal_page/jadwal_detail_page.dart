import 'package:flutter/material.dart';
import 'package:tixme/const/app_color.dart';
import 'package:tixme/pages/main_menu/ticket/checkout_page.dart';

class JadwalDetailPage extends StatefulWidget {
  final Map<String, dynamic> schedule;
  final String heroTag;
  final String Function(String?) formatDateTime;

  const JadwalDetailPage({
    super.key,
    required this.schedule,
    required this.heroTag,
    required this.formatDateTime,
  });

  @override
  State<JadwalDetailPage> createState() => _JadwalDetailPageState();
}

class _JadwalDetailPageState extends State<JadwalDetailPage> {
  int quantity = 1;
  int selectedTimeIndex = 0;
  String selectedTimeValue = '';

  @override
  Widget build(BuildContext context) {
    final film = widget.schedule['film'] ?? {};
    final imageUrl = film['image_url'] ?? film['image_base64'] ?? '';

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: Text(
          'Detail Tiket',
          style: TextStyle(color: AppColor.textColor),
        ),
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColor.textColor),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: widget.heroTag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child:
                      imageUrl.isNotEmpty
                          ? Image.network(
                            imageUrl,
                            height: 250,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) => Container(
                                  height: 250,
                                  color: AppColor.accentColor,
                                  child: Icon(
                                    Icons.movie,
                                    color: AppColor.textColor,
                                    size: 48,
                                  ),
                                ),
                          )
                          : Container(
                            height: 250,
                            color: AppColor.accentColor,
                            child: Icon(
                              Icons.movie,
                              color: AppColor.textColor,
                              size: 48,
                            ),
                          ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                film['title'] ?? 'No Title',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Text(
                'Sinopsis',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textColor,
                ),
              ),
              Text(
                film['description'] ?? 'No Description',
                style: TextStyle(fontSize: 16, color: AppColor.textColor),
              ),

              // Text(
              //   'Jam Tayang: ${widget.formatDateTime(widget.schedule['start_time'])}',
              //   style: TextStyle(fontSize: 16, color: AppColor.textColor),
              // ),
              const SizedBox(height: 12),
              // Daftar contoh jam tayang, bisa diganti sesuai kebutuhan
              Text(
                'Jam Tayang',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textColor,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: List.generate(3, (index) {
                  // Misal, untuk demo, kita pakai jam yang sama, bisa diganti dengan list jam berbeda
                  final times = [
                    widget.formatDateTime(widget.schedule['start_time']),
                    widget.formatDateTime(widget.schedule['start_time']),
                    widget.formatDateTime(widget.schedule['start_time']),
                  ];
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTimeIndex = index;
                          selectedTimeValue = times[index];
                        });
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        margin:
                            index != 2
                                ? const EdgeInsets.only(right: 12)
                                : null,
                        decoration: BoxDecoration(
                          color: AppColor.accentColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                selectedTimeIndex == index
                                    ? AppColor.secondaryColor
                                    : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${times[index]}',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColor.textColor,
                              fontWeight:
                                  selectedTimeIndex == index
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.accentColor,
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => CheckoutPage(
                            schedule: widget.schedule,
                            filmId: widget.schedule['film_id'] ?? 0,
                            quantity: quantity,
                          ),
                    ),
                  );
                },
                child: Text(
                  'Beli Tiket',
                  style: TextStyle(fontSize: 16, color: AppColor.textColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
