import 'package:flutter/material.dart';
import 'package:tixme/const/app_color.dart';
import 'package:tixme/services/movie_service.dart';

class SetJadwal extends StatefulWidget {
  const SetJadwal({super.key});

  @override
  State<SetJadwal> createState() => _SetJadwalState();
}

class _SetJadwalState extends State<SetJadwal> {
  List<Map<String, dynamic>> _films = [];
  int? _selectedFilmId;
  List<DateTime?> _selectedSchedules = [null, null, null];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFilms();
  }

  Future<void> _fetchFilms() async {
    setState(() => _isLoading = true);
    try {
      final data = await MovieService.getMovies();
      print('Data film dari API: $data'); // Debug: cek data di console
      setState(() {
        _films = List<Map<String, dynamic>>.from(data['data'] ?? []);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _films = [];
        _isLoading = false;
      });
      print('Gagal mengambil data film: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal memuat film: $e')));
    }
  }

  Future<void> _pickDateTime(int index) async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedSchedules[index] = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _saveSchedules() {
    if (_selectedFilmId == null || _selectedSchedules.any((dt) => dt == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih film dan isi semua jadwal!')),
      );
      return;
    }
    // Kirim ke API di sini
    print('Film ID: $_selectedFilmId');
    print('Jadwal: $_selectedSchedules');
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Jadwal berhasil disimpan!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: Text(
          'Set Jadwal',
          style: TextStyle(
            color: AppColor.textColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColor.textColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih Film:',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 8),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : DropdownButtonFormField<int>(
                  value: _selectedFilmId,
                  items:
                      _films
                          .map(
                            (film) => DropdownMenuItem<int>(
                              value: film['id'],
                              child: Text(film['title']),
                            ),
                          )
                          .toList(),
                  onChanged: (val) => setState(() => _selectedFilmId = val),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.accentColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  dropdownColor: AppColor.accentColor,
                  style: TextStyle(color: AppColor.textColor),
                ),
            const SizedBox(height: 24),
            const Text(
              'Set 3 Jadwal:',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 8),
            ...List.generate(
              3,
              (i) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.accentColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _selectedSchedules[i] != null
                              ? '${_selectedSchedules[i]!.day.toString().padLeft(2, '0')}-${_selectedSchedules[i]!.month.toString().padLeft(2, '0')}-${_selectedSchedules[i]!.year}  ${_selectedSchedules[i]!.hour.toString().padLeft(2, '0')}:${_selectedSchedules[i]!.minute.toString().padLeft(2, '0')}'
                              : 'Pilih tanggal & jam',
                          style: TextStyle(
                            color: AppColor.textColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.secondaryColor,
                        foregroundColor: AppColor.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => _pickDateTime(i),
                      child: const Text('Pilih'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.secondaryColor,
                  foregroundColor: AppColor.primaryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _saveSchedules,
                child: const Text(
                  'Simpan Semua Jadwal',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
