import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/models/orderModels.dart';
import 'package:kp_manajemen_bengkel/models/servicesModels.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kp_manajemen_bengkel/screens/user/detail_screens_user/add_servicesUser.dart';
import 'package:kp_manajemen_bengkel/services/ordersServices.dart';
import 'package:kp_manajemen_bengkel/services/services.dart';

class Screen_BookOrderNow extends StatefulWidget {
  const Screen_BookOrderNow({Key? key}) : super(key: key);

  @override
  State<Screen_BookOrderNow> createState() => _Screen_BookOrderNowState();
}

final TextEditingController carTypeController = TextEditingController();
final TextEditingController notesController = TextEditingController();

class _Screen_BookOrderNowState extends State<Screen_BookOrderNow> {
  List<ServiceM> availableServices = [];
  List<Map<String, dynamic>> selectedServices = [];

  @override
  void initState() {
    super.initState();
    _fetchServices();
  }

  Future<void> _fetchServices() async {
    try {
      List<ServiceM> services = await ServiceService.getAllServices();
      setState(() {
        availableServices = services;
      });
    } catch (e) {
      // Handle error
    }
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
        title: Text(
          "Book Services",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Service Detail",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),

              // Menampilkan Servces yang dipilih
              selectedServices.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: selectedServices.map((service) {
                        final serviceDetail = availableServices.firstWhere(
                            (availableService) =>
                                availableService.id == service['id']);
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                serviceDetail.name ?? '',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'Rp${serviceDetail.harga1?.toInt()}${serviceDetail.harga2 != null ? ' s/d Rp${serviceDetail.harga2!.toInt()}' : ''}',
                                style: TextStyle(fontSize: 13),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.delete_forever_outlined),
                                onPressed: () {
                                  setState(() {
                                    selectedServices.remove(service);
                                  });
                                },
                              ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                          ],
                        );
                      }).toList(),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Center(
                        child: Text(
                          'Kosong',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                    ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  // Logic Add A Service
                  final result =
                      await showModalBottomSheet<List<Map<String, dynamic>>>(
                    isScrollControlled: false,
                    context: context,
                    builder: (context) => addServiceOrder(
                      services: availableServices,
                      selectedServices: selectedServices,
                    ),
                  );

                  if (result != null) {
                    setState(() {
                      selectedServices = result;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  minimumSize: Size(300, 40),
                  backgroundColor: Color.fromRGBO(231, 229, 93, 1),
                ),
                child: const Text(
                  'Tambah Services',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Tipe Mobil (Optional)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              TextFormField(
                controller: carTypeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                maxLines: null,
              ),
              SizedBox(height: 15),
              Text(
                "Notes (Optional)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              Container(
                constraints: BoxConstraints(
                  maxHeight: 200,
                ),
                child: TextFormField(
                  controller: notesController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                  ),
                  minLines: 1,
                  maxLines: null,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    width: 150,
                    height: 35,
                    child: ElevatedButton(
                      onPressed: selectedServices.isNotEmpty
                          ? () async {
                              // Logic Order Now
                              final User? user =
                                  FirebaseAuth.instance.currentUser;
                              if (user != null) {
                                OrderM order = OrderM(
                                  userId: user.uid,
                                  carType: carTypeController.text,
                                  notes: notesController.text,
                                  services: selectedServices,
                                  orderDate: DateTime.now(),
                                  status: "Waiting",
                                );
                                await OrderService.addOrder(order);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Berhasil Melakukan Booking')));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error')));
                              }
                              carTypeController.clear();
                              notesController.clear();
                              setState(() {
                                selectedServices.clear();
                              });
                            }
                          : null, // Menetapkan null untuk onPressed jika selectedServices kosong
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(231, 229, 93, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
