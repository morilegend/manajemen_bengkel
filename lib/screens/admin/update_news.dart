import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kp_manajemen_bengkel/models/newsModels.dart';
import 'package:kp_manajemen_bengkel/services/newsServices.dart';

class EditNewsScreen extends StatefulWidget {
  final NewsM newsData;

  EditNewsScreen({required this.newsData});

  @override
  _EditNewsScreenState createState() => _EditNewsScreenState();
}

class _EditNewsScreenState extends State<EditNewsScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _deskripsiController;
  File? _selectedImage;
  final NewsService _newsService = NewsService();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.newsData.tittle);
    _deskripsiController =
        TextEditingController(text: widget.newsData.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _updateNews() async {
    if (_formKey.currentState!.validate()) {
      String? imageUrl = widget.newsData.urlImage;

      if (_selectedImage != null) {
        imageUrl = await _newsService.uploadImage(_selectedImage!);
      }

      NewsM updatedNews = NewsM(
        id: widget.newsData.id,
        tittle: _titleController.text,
        description: _deskripsiController.text,
        urlImage: imageUrl,
        date: widget.newsData.date,
      );

      await _newsService.updateNews(updatedNews);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit News'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Judul'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Judulnya';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(style: BorderStyle.solid, width: 2),
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  height: 200.0,
                  width: double.infinity,
                  child: _selectedImage != null
                      ? Image.file(
                          _selectedImage!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.fill,
                        )
                      : widget.newsData.urlImage != null
                          ? Image.network(
                              widget.newsData.urlImage!,
                              height: 100,
                              width: 100,
                              fit: BoxFit.fill,
                            )
                          : Container(
                              height: 100, width: 100, color: Colors.grey),
                ),
                SizedBox(height: 3),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text(
                    'Change Image',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromRGBO(231, 229, 93, 1))),
                ),
                TextFormField(
                  controller: _deskripsiController,
                  decoration: InputDecoration(labelText: 'Deskripsi'),
                  maxLines: null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Deskripsi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _updateNews,
                  child: Text(
                    'Update News',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromRGBO(231, 229, 93, 1))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
