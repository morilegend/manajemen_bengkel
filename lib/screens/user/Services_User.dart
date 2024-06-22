import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/models/servicesModels.dart';
import 'package:kp_manajemen_bengkel/screens/user/detail_screens_user/services_detailScreenUser.dart';
import 'package:kp_manajemen_bengkel/screens/user/detail_screens_user/Screen_BookOrderNow.dart';
import 'package:kp_manajemen_bengkel/services/services.dart';
import 'package:kp_manajemen_bengkel/services/userServices.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final UserData getUserData = UserData();
  final ServiceService serviceService = ServiceService();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

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
        title: DefaultTextStyle(
          style: TextStyle(
            textBaseline: TextBaseline.alphabetic,
            color: Colors.white,
          ),
          child: Column(
            children: [
              Container(
                height: 50.0,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome,',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 75, 73, 73),
                      ),
                    ),
                    Container(
                      width: 190,
                      height: 31,
                      child: FutureBuilder<Map<dynamic, dynamic>?>(
                        future: getUserData.getUser(),
                        builder: (BuildContext context,
                            AsyncSnapshot<Map<dynamic, dynamic>?> snapshot) {
                          return Text(
                            snapshot.data?["username"] ?? "",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<ServiceM>>(
              future: serviceService.getServices(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ServiceM>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('No services available'),
                  );
                } else {
                  List<ServiceM> services = snapshot.data!;

                  // Sort services by timestamp (latest first)
                  services.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: services.length,
                    itemBuilder: (BuildContext context, int index) {
                      ServiceM service = services[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ServicesDetailScreenUser(service: service),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 120.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(service.urlImage ?? ''),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(6.0),
                                width: screenWidth * 0.6,
                                height: screenWidth * 0.11,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(231, 229, 93, 1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 10,
                                      spreadRadius: 1,
                                    )
                                  ],
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      service.name ?? '',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          // To Order Services
          Padding(
            padding: const EdgeInsets.only(bottom: 82),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Screen_BookOrderNow(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(231, 229, 93, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: Text(
                '+ Book Services Now',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
