import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/models/historyModels.dart';
import 'package:kp_manajemen_bengkel/services/historyServices.dart';

// History Status (Waiting,Pending,Approved,Repairing,Canceled,Done)

class HistoryDetailScreenUser extends StatefulWidget {
  final HistoryM history;

  const HistoryDetailScreenUser({super.key, required this.history});

  @override
  _HistoryDetailScreenUserState createState() =>
      _HistoryDetailScreenUserState();
}

class _HistoryDetailScreenUserState extends State<HistoryDetailScreenUser> {
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _priceController =
        TextEditingController(text: widget.history.price?.toString() ?? '');
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _updateHistory(String status) async {
    HistoryM updatedHistory = widget.history.copyWith(
      status: status,
    );

    await HistoryService.updateHistory(updatedHistory);
    Navigator.pop(context, updatedHistory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(231, 229, 93, 1),
        title: Text('History Detail'),
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
              if (widget.history.status == 'Pending') ...[
                Text('Price: Rp.${widget.history.price}',
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => _updateHistory('Approved'),
                      child: Text(
                        'Approve',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _updateHistory('Canceled'),
                      child: Text(
                        'Reject',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
              ] else ...[
                Text("Status: ${widget.history.status}",
                    style: TextStyle(fontSize: 16)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
