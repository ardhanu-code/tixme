import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tixme/const/app_color.dart';
import 'package:tixme/services/movie_service.dart';

class TambahDataMovie extends StatefulWidget {
  const TambahDataMovie({super.key});

  @override
  State<TambahDataMovie> createState() => _TambahDataMovieState();
}

class _TambahDataMovieState extends State<TambahDataMovie> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _genreController = TextEditingController();
  final _directorController = TextEditingController();
  final _writerController = TextEditingController();
  final _statsController = TextEditingController();

  File? _selectedImage;
  String? _imageBase64;
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _genreController.dispose();
    _directorController.dispose();
    _writerController.dispose();
    _statsController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });

        // Convert image to base64
        final bytes = await image.readAsBytes();
        final base64String = base64Encode(bytes);
        setState(() {
          _imageBase64 = 'data:image/png;base64,$base64String';
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_imageBase64 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an image'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await MovieService.addMovie(
        title: _titleController.text,
        description: _descriptionController.text,
        genre: _genreController.text,
        director: _directorController.text,
        writer: _writerController.text,
        stats: _statsController.text,
        imageBase64: _imageBase64!,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Movie added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: const Text(
          'Tambah Data Movie',
          style: TextStyle(color: AppColor.textColor),
        ),
        backgroundColor: AppColor.primaryColor,
        iconTheme: const IconThemeData(color: AppColor.textColor),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Picker Section
                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            width: 200,
                            height: 280,
                            decoration: BoxDecoration(
                              color: AppColor.accentColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColor.accentColor,
                                width: 2,
                              ),
                            ),
                            child:
                                _selectedImage != null
                                    ? ClipRRect(
                                      borderRadius: BorderRadius.circular(14),
                                      child: Image.file(
                                        _selectedImage!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                    : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_photo_alternate,
                                          size: 64,
                                          color: AppColor.textColor,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Tap to add',
                                          style: TextStyle(
                                            color: AppColor.textColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // ElevatedButton.icon(
                        //   onPressed: _pickImage,
                        //   icon: const Icon(Icons.photo_library),
                        //   label: const Text('Pick Image'),
                        //   style: ElevatedButton.styleFrom(
                        //     backgroundColor: AppColor.secondaryColor,
                        //     foregroundColor: AppColor.primaryColor,
                        //     padding: const EdgeInsets.symmetric(
                        //       horizontal: 24,
                        //       vertical: 12,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Title Field
                  _buildTextField(
                    controller: _titleController,
                    label: 'Title',
                    hint: 'Enter movie title',
                    icon: Icons.movie,
                  ),
                  const SizedBox(height: 16),

                  // Description Field
                  _buildTextField(
                    controller: _descriptionController,
                    label: 'Description',
                    hint: 'Enter movie description',
                    icon: Icons.description,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),

                  // Genre Field
                  _buildTextField(
                    controller: _genreController,
                    label: 'Genre',
                    hint: 'Enter movie genre',
                    icon: Icons.category,
                  ),
                  const SizedBox(height: 16),

                  // Director Field
                  _buildTextField(
                    controller: _directorController,
                    label: 'Director',
                    hint: 'Enter director name',
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 16),

                  // Writer Field
                  _buildTextField(
                    controller: _writerController,
                    label: 'Writer',
                    hint: 'Enter writer name',
                    icon: Icons.edit,
                  ),
                  const SizedBox(height: 16),

                  // Stats Field
                  _buildTextField(
                    controller: _statsController,
                    label: 'Status',
                    hint: 'e.g., Now Showing, Coming Soon',
                    icon: Icons.info,
                  ),
                  const SizedBox(height: 32),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.secondaryColor,
                        foregroundColor: AppColor.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child:
                          _isLoading
                              ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColor.primaryColor,
                                  ),
                                ),
                              )
                              : const Text(
                                'Add Movie',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColor.textColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: AppColor.textColor),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AppColor.textColor.withOpacity(0.6)),
            prefixIcon: Icon(icon, color: AppColor.textColor),
            filled: true,
            fillColor: AppColor.accentColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColor.accentColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColor.accentColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColor.secondaryColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return '$label is required';
            }
            return null;
          },
        ),
      ],
    );
  }
}
