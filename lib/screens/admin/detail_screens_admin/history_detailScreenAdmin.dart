import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/models/historyModels.dart';
import 'package:kp_manajemen_bengkel/models/pegawaiModels.dart';
import 'package:kp_manajemen_bengkel/services/historyServices.dart';
import 'package:kp_manajemen_bengkel/services/pegawaiServices.dart';

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
            SnackBar(content: Text('Please select a pegawai')),
          );
          return;
        }
        newStatus = "Repairing";
      } else if (widget.history.status == "Repairing") {
        newStatus = "Done";
      } else {
        return;
      }

      HistoryM updatedHistory = widget.history.copyWith(
        price: newPrice,
        status: newStatus,
        pegawaiId: _selectedPegawaiId,
      );

      await HistoryService.updateHistory(updatedHistory);
      Navigator.pop(context, updatedHistory);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Please enter a valid price and select a pegawai')),
      );
    }
  }

  Future<void> _updatePriceOnly() async {
    int? newPrice = int.tryParse(_priceController.text);

    if (newPrice != null) {
      HistoryM updatedHistory = widget.history.copyWith(
        price: newPrice,
        status: 'Pending',
      );

      await HistoryService.updateHistory(updatedHistory);
      Navigator.pop(context, updatedHistory);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid price')),
      );
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
                double harga1 = service['harga1'];
                double? harga2 = service['harga2'];
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
                if (widget.history.status == 'Approved' ||
                    widget.history.status == 'Repairing') ...[
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
                              ? 'Repairing'
                              : widget.history.status == 'Repairing'
                                  ? 'Done'
                                  : 'Orderan Telah Selesai',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(231, 229, 93, 1),
                    ),
                  ),
                ),
              ] else ...[
                Text("This order has been canceled and cannot be modified.",
                    style: TextStyle(color: Colors.red)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
