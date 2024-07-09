import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/models/historyModels.dart';
import 'package:kp_manajemen_bengkel/models/pegawaiModels.dart';
import 'package:kp_manajemen_bengkel/services/historyServices.dart';
import 'package:kp_manajemen_bengkel/services/pegawaiServices.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HistoryDetailScreenAdmin extends StatefulWidget {
  final HistoryM history;

  HistoryDetailScreenAdmin({required this.history});

  @override
  _HistoryDetailScreenAdminState createState() =>
      _HistoryDetailScreenAdminState();
}

class _HistoryDetailScreenAdminState extends State<HistoryDetailScreenAdmin> {
  late TextEditingController _priceController;
  late Future<List<Pegawai>> _futurePegawai;
  String? _selectedPegawaiId;
  File? _beforeImageFile;
  File? _afterImageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _priceController =
        TextEditingController(text: widget.history.price?.toString() ?? '');
    _futurePegawai = PegawaiService.getAllPegawai();
    _selectedPegawaiId = widget.history.pegawaiId;
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _updateHistory() async {
    int? newPrice = int.tryParse(_priceController.text);

    if (newPrice != null) {
      String newStatus;
      if (widget.history.status == "Approved") {
        if (_selectedPegawaiId == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Select Employee To Doing Services')),
          );
          return;
        } else if (_beforeImageFile == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Select Before Images')),
          );
          return;
        }
        newStatus = "Repairing";
      } else if (widget.history.status == "Repairing") {
        if (_afterImageFile == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Select After Images')),
          );
          return;
        }
        newStatus = "Done";
      } else {
        return;
      }

      String? beforeImageUrl;
      if (_beforeImageFile != null) {
        beforeImageUrl = await HistoryService.uploadImage(
            _beforeImageFile!, 'images/beforeCar');
        if (widget.history.beforeCarImageUrl != null) {
          await HistoryService.deleteImage(widget.history.beforeCarImageUrl!);
        }
      }

      String? afterImageUrl;
      if (_afterImageFile != null && newStatus == "Done") {
        afterImageUrl = await HistoryService.uploadImage(
            _afterImageFile!, 'images/afterCar');
        if (widget.history.afterCarImageUrl != null) {
          await HistoryService.deleteImage(widget.history.afterCarImageUrl!);
        }
      }

      HistoryM updatedHistory = widget.history.copyWith(
        price: newPrice,
        status: newStatus,
        pegawaiId: _selectedPegawaiId,
        beforeCarImageUrl: beforeImageUrl ?? widget.history.beforeCarImageUrl,
        afterCarImageUrl: afterImageUrl ?? widget.history.afterCarImageUrl,
      );

      await HistoryService.updateHistory(updatedHistory);
      Navigator.pop(context, updatedHistory);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Create Validate Price')),
      );
    }
  }

  Future<void> _updatePriceOnly() async {
    int? newPrice = int.tryParse(_priceController.text);

    if (newPrice != null) {
      String newStatus = widget.history.userId == '8QWQNEozu4XAHqMSOwdQWgCBkmR2'
          ? 'Approved'
          : 'Pending';

      HistoryM updatedHistory = widget.history.copyWith(
        price: newPrice,
        status: newStatus,
      );

      await HistoryService.updateHistory(updatedHistory);
      Navigator.pop(context, updatedHistory);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Masukkan harga yang valid')),
      );
    }
  }

  Future<void> _pickBeforeImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _beforeImageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickAfterImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _afterImageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(231, 229, 93, 1),
        title: Text('Edit History'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Car Type: ${widget.history.carType}',
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Text('Services:', style: TextStyle(fontSize: 16)),
              ...widget.history.services.map((service) {
                String serviceName = service['name'];
                double harga1 = (service['harga1'] as num).toDouble();
                double? harga2 = service['harga2'] != null
                    ? (service['harga2'] as num).toDouble()
                    : null;
                String hargaText =
                    harga2 != null ? 'Rp.$harga1 - Rp.$harga2' : 'Rp.$harga1';
                return Text('$serviceName: $hargaText');
              }).toList(),
              SizedBox(height: 16),
              Text('Notes: ${widget.history.notes}',
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              if (widget.history.status != 'Canceled') ...[
                if (widget.history.status == 'Approved') ...[
                  Text('Pegawai yang akan melakukan Repairing:',
                      style: TextStyle(fontSize: 16)),
                  FutureBuilder<List<Pegawai>>(
                    future: _futurePegawai,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Text("No Pegawai available");
                      } else {
                        List<Pegawai> pegawaiList = snapshot.data!;
                        return DropdownButton<String>(
                          value: _selectedPegawaiId,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedPegawaiId = newValue!;
                            });
                          },
                          items: pegawaiList
                              .map<DropdownMenuItem<String>>((Pegawai pegawai) {
                            return DropdownMenuItem<String>(
                              value: pegawai.id,
                              child: Text(pegawai.name),
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  Text('Upload Before Image', style: TextStyle(fontSize: 16)),
                  GestureDetector(
                    onTap: _pickBeforeImage,
                    child: Container(
                      width: 300,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _beforeImageFile != null
                          ? Image.file(
                              _beforeImageFile!,
                              width: 300,
                              height: 190,
                              fit: BoxFit.cover,
                            )
                          : Center(child: Text('Select Before Image')),
                    ),
                  ),
                ],
                if (widget.history.status == 'Repairing') ...[
                  Text('Upload After Image', style: TextStyle(fontSize: 16)),
                  GestureDetector(
                    onTap: _pickAfterImage,
                    child: Container(
                      width: 300,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _afterImageFile != null
                          ? Image.file(
                              _afterImageFile!,
                              width: 300,
                              height: 190,
                              fit: BoxFit.cover,
                            )
                          : Center(child: Text('Select After Image')),
                    ),
                  ),
                ],
                SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (widget.history.status == 'Waiting') {
                        _updatePriceOnly();
                      } else if (widget.history.status != 'Pending') {
                        _updateHistory();
                      }
                    },
                    child: Text(
                      widget.history.status == 'Waiting'
                          ? 'Berikan Harga'
                          : widget.history.status == 'Approved'
                              ? 'Lakukan Repairing'
                              : widget.history.status == "Pending"
                                  ? 'Sedang Menunggu User'
                                  : widget.history.status == "Repairing"
                                      ? "Done"
                                      : "Telah Selesai",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(231, 229, 93, 1),
                    ),
                  ),
                ),
                if (widget.history.status == 'Done') ...[
                  SizedBox(height: 16),
                  Text('Before Image', style: TextStyle(fontSize: 16)),
                  Container(
                    width: 300,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: widget.history.beforeCarImageUrl != null
                        ? Image.network(
                            widget.history.beforeCarImageUrl!,
                            width: 300,
                            height: 190,
                            fit: BoxFit.cover,
                          )
                        : Center(child: Text('No Before Image')),
                  ),
                  SizedBox(height: 16),
                  Text('After Image', style: TextStyle(fontSize: 16)),
                  Container(
                    width: 300,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: widget.history.afterCarImageUrl != null
                        ? Image.network(
                            widget.history.afterCarImageUrl!,
                            width: 300,
                            height: 190,
                            fit: BoxFit.cover,
                          )
                        : Center(child: Text('No After Image')),
                  ),
                ],
              ] else ...[
                Center(
                  child: Text("User Telah Mengcancel Orderan",
                      style: TextStyle(color: Colors.red)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
