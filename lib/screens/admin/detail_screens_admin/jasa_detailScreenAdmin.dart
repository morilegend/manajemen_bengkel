import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/models/servicesModels.dart';
import 'package:kp_manajemen_bengkel/screens/user/detail_screens_user/Screen_BookOrderNow.dart';

class DetailServiceScreen extends StatelessWidget {
  final ServiceM service;

  DetailServiceScreen({required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Details'),
        backgroundColor: Color.fromRGBO(231, 229, 93, 1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                service.name ?? 'No Name',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'Harga: Rp${service.harga1?.toInt()}${service.harga2 != null ? ' s/d Rp${service.harga2!.toInt()}' : ''}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 300,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(width: 2)),
                child: service.urlImage != null
                    ? Image.network(
                        service.urlImage!,
                        fit: BoxFit.fill,
                      )
                    : Container(
                        height: 200,
                        color: Colors.grey[300],
                        child: Center(
                          child: Text('No Image Available'),
                        ),
                      ),
              ),
              SizedBox(height: 10),
              Text(
                'Description: ${service.descr ?? 'No Description'}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
