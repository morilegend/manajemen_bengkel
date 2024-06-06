import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:kp_manajemen_bengkel/models/servicesModels.dart';
import 'package:kp_manajemen_bengkel/screens/admin/menu/jasa/jasa_tampiladmin.dart';
import 'package:kp_manajemen_bengkel/services/services.dart';

class JasaTambahAdmin extends StatefulWidget {
  @override
  _JasaTambahAdminState createState() => _JasaTambahAdminState();
}

class _JasaTambahAdminState extends State<JasaTambahAdmin> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _harga1Controller = TextEditingController();
  final _harga2Controller = TextEditingController();
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  Future<void> _addService() async {
    if (_formKey.currentState!.validate() && _imageFile != null) {
      String imageUrl = await ServiceService.uploadImage(_imageFile!);

      ServiceM newService = ServiceM(
        name: _nameController.text,
        descr: _descriptionController.text,
        harga1: double.tryParse(_harga1Controller.text),
        harga2: _harga2Controller.text.isEmpty
            ? null
            : double.tryParse(_harga2Controller.text),
        urlImage: imageUrl,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TampilJasaAdmin(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Berhasil Menambahkan Jasa/Services')));

      await ServiceService.addService(newService);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(231, 229, 93, 1),
        elevation: 3,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        title: DefaultTextStyle(
          style: TextStyle(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Container(
                height: 50.0,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Services Add',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Nama Jasa';
                    }
                    return null;
                  },
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: null,
                ),
                TextFormField(
                  controller: _harga1Controller,
                  decoration: InputDecoration(labelText: 'Harga 1'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Harga';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _harga2Controller,
                  decoration: InputDecoration(labelText: 'Harga 2 (Optional)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      final n = num.tryParse(value);
                      if (n == null) {
                        return 'Masukkan Harga';
                      }
                    }
                    return null;
                  },
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
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addService,
                  child: Text(
                    'Add Service',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(231, 229, 93, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
