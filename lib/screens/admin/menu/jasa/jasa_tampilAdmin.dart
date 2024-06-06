import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/models/servicesModels.dart';
import 'package:kp_manajemen_bengkel/screens/admin/detail_screens_admin/jasa_detailScreenAdmin.dart';
import 'package:kp_manajemen_bengkel/screens/admin/menu/jasa/jasa_tambahAdmin.dart';
import 'package:kp_manajemen_bengkel/services/services.dart';

class TampilJasaAdmin extends StatefulWidget {
  const TampilJasaAdmin({super.key});

  @override
  State<TampilJasaAdmin> createState() => _TampilJasaAdminState();
}

class _TampilJasaAdminState extends State<TampilJasaAdmin> {
  List<ServiceM> services = [];

  @override
  void initState() {
    super.initState();
    _fetchServices();
  }

  Future<void> _fetchServices() async {
    try {
      List<ServiceM> fetchedServices = await ServiceService.getAllServices();

      // Sort services by timestamp (latest first)
      fetchedServices.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));

      setState(() {
        services = fetchedServices;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch services: $e')));
    }
  }

  Future<void> _deleteService(String serviceId) async {
    try {
      await ServiceService.deleteService(serviceId);
      setState(() {
        services.removeWhere((service) => service.id == serviceId);
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Services Berhasil Dihapus')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Services Gagal Dihapus : $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Services'),
        backgroundColor: Color.fromRGBO(231, 229, 93, 1),
      ),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return Column(
            children: [
              ListTile(
                  title: Text(service.name ?? ''),
                  subtitle: Text(
                    'Harga: Rp${service.harga1?.toInt()}${service.harga2 != null ? ' s/d Rp${service.harga2!.toInt()}' : ''}',
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteService(service.id!),
                  ),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailServiceScreen(service: service)),
                    );
                  }),
              Divider(),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JasaTambahAdmin()),
          );

          if (result == true) {
            _fetchServices();
          }
        },
        backgroundColor: Color.fromRGBO(231, 229, 93, 1),
        child: Icon(Icons.add),
      ),
    );
  }
}
