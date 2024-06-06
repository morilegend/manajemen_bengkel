import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/models/servicesModels.dart';

class addServiceOrder extends StatefulWidget {
  final List<ServiceM> services;
  final List<Map<String, dynamic>> selectedServices;

  const addServiceOrder({
    Key? key,
    required this.services,
    required this.selectedServices,
  }) : super(key: key);

  @override
  _addServiceOrderState createState() => _addServiceOrderState();
}

class _addServiceOrderState extends State<addServiceOrder> {
  List<String> _tempSelectedServices = [];

  @override
  void initState() {
    super.initState();
    _tempSelectedServices = widget.selectedServices
        .map((service) => service['id'] as String)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(231, 229, 93, 1),
        automaticallyImplyLeading: false,
        elevation: 3,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        title: Center(
          child: Text(
            "Add Services",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.services.length,
                itemBuilder: (context, index) {
                  final service = widget.services[index];
                  return Column(
                    children: [
                      CheckboxListTile(
                        title: Text(service.name ?? ''),
                        subtitle: Text(
                          'Rp${service.harga1?.toInt()}${service.harga2 != null ? ' s/d Rp${service.harga2!.toInt()}' : ''}',
                        ),
                        value: _tempSelectedServices.contains(service.id),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              _tempSelectedServices.add(service.id!);
                            } else {
                              _tempSelectedServices.remove(service.id!);
                            }
                          });
                        },
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final selectedServiceDetails =
                    _tempSelectedServices.map((serviceId) {
                  final service = widget.services
                      .firstWhere((service) => service.id == serviceId);
                  return {
                    'id': service.id,
                    'name': service.name,
                    'harga1': service.harga1,
                    'harga2': service.harga2,
                  };
                }).toList();
                Navigator.pop(context, selectedServiceDetails);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(231, 229, 93, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child: Text(
                'Add Services',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
