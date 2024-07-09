import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/models/orderModels.dart';
import 'package:kp_manajemen_bengkel/models/servicesModels.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kp_manajemen_bengkel/screens/user/detail_screens_user/add_servicesUser.dart';
import 'package:kp_manajemen_bengkel/services/ordersServices.dart';
import 'package:kp_manajemen_bengkel/services/services.dart';

class Screen_BookOrderNowAdmin extends StatefulWidget {
  const Screen_BookOrderNowAdmin({Key? key}) : super(key: key);

  @override
  State<Screen_BookOrderNowAdmin> createState() =>
      _Screen_BookOrderNowAdminState();
}

final TextEditingController carTypeController = TextEditingController();
final TextEditingController notesController = TextEditingController();
final TextEditingController licensePlateController = TextEditingController();

class _Screen_BookOrderNowAdminState extends State<Screen_BookOrderNowAdmin> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedReservationDate;
  TimeOfDay? _selectedReservationTime;
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

  Future<void> _selectReservationDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedReservationDate) {
      setState(() {
        _selectedReservationDate = picked;
      });
    }
  }

  Future<void> _selectReservationTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedReservationTime) {
      setState(() {
        _selectedReservationTime = picked;
      });
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Service Detail",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),

                // Menampilkan Services yang dipilih
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
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
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
                            'Empty',
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
                    'Add Services',
                    style: TextStyle(
                        fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Reservation Date",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                ListTile(
                  title: Text(_selectedReservationDate == null
                      ? 'Select Reservation Date'
                      : '${_selectedReservationDate!.day}/${_selectedReservationDate!.month}/${_selectedReservationDate!.year}'),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () => _selectReservationDate(context),
                ),
                SizedBox(height: 15),
                Text(
                  "Reservation Time",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                ListTile(
                  title: Text(_selectedReservationTime == null
                      ? 'Select Reservation Time'
                      : '${_selectedReservationTime!.format(context)}'),
                  trailing: Icon(Icons.access_time),
                  onTap: () => _selectReservationTime(context),
                ),
                const SizedBox(height: 15),
                Text(
                  "Car Licenses",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                TextFormField(
                  controller: licensePlateController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  maxLines: null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the car license';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                Text(
                  "Car Type",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                TextFormField(
                  controller: carTypeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  maxLines: null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the car type';
                    }
                    return null;
                  },
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
                                if (_formKey.currentState!.validate()) {
                                  if (_selectedReservationDate == null ||
                                      _selectedReservationTime == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Please select a reservation date and time')),
                                    );
                                    return;
                                  }

                                  // Combine date and time
                                  final reservationDateTime = DateTime(
                                    _selectedReservationDate!.year,
                                    _selectedReservationDate!.month,
                                    _selectedReservationDate!.day,
                                    _selectedReservationTime!.hour,
                                    _selectedReservationTime!.minute,
                                  );

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
                                      reservationDate: reservationDateTime,
                                      licensePlate: licensePlateController.text,
                                      status: "Waiting",
                                    );
                                    await OrderService.addOrder(order);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Successfully Booked Services')));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Error')));
                                  }
                                  carTypeController.clear();
                                  notesController.clear();
                                  licensePlateController.clear();
                                  setState(() {
                                    selectedServices.clear();
                                    _selectedReservationDate = null;
                                    _selectedReservationTime = null;
                                  });
                                }
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
      ),
    );
  }
}
