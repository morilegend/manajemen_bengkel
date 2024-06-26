import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kp_manajemen_bengkel/services/newsServices.dart';
import 'dart:io';
import 'package:intl/intl.dart'; // Package for date formatting

class TambahNews extends StatefulWidget {
  TambahNews({super.key});

  @override
  State<TambahNews> createState() => _TambahNewsState();
}

class _TambahNewsState extends State<TambahNews> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  File? _imageFile;
  bool _isLoading = false;
  final NewsService _newsService = NewsService();

  @override
  void initState() {
    super.initState();
    // Set the current date in the _dateController
    _dateController.text = DateFormat('MM-dd-yyyy').format(DateTime.now());
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  Future<void> _submitNews() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final date = Timestamp.fromDate(DateTime.now());

    if (title.isEmpty || description.isEmpty || _imageFile == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Silakan isi semua field')));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final urlImage = await _newsService.uploadImage(_imageFile!);
      if (urlImage != null) {
        await _newsService.addNews(title, description, date, urlImage);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('News berhasil ditambahkan')));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Gagal upload gambar')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menambahkan dengan error: $e')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah News'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Judul'),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(style: BorderStyle.solid, width: 2),
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
                height: 200.0,
                width: double.infinity,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: _imageFile == null
                      ? Container(
                          color: Colors.grey[200],
                          height: 200,
                          width: double.infinity,
                          child: Icon(Icons.add_photo_alternate, size: 100),
                        )
                      : Image.file(_imageFile!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.fill),
                ),
              ),
              SizedBox(height: 2),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: null,
              ),
              SizedBox(
                height: 20,
              ),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submitNews,
                      child: Text('Kirim'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                        Color.fromRGBO(231, 229, 93, 1),
                      )),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
