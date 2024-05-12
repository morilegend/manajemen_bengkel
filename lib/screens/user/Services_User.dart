import 'package:flutter/material.dart';
import 'package:kp_manajemen_bengkel/services/services_list.dart';

class ServicesUser extends StatefulWidget {
  const ServicesUser({Key? key}) : super(key: key);

  @override
  State<ServicesUser> createState() => _ServicesUserState();
}

final ServicesList getServices = ServicesList();

class _ServicesUserState extends State<ServicesUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(231, 229, 93, 1),
        automaticallyImplyLeading: false, //Menghilangkan Tombol Back
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
                      'Services List',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
      body: FutureBuilder(
        future: getServices.getServices(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // Buat menjadi 2 kotak
            List<Map<String, dynamic>> services = snapshot.data!;
            List<Map<String, dynamic>> leftColumn =
                services.sublist(0, (services.length / 2).ceil());
            List<Map<String, dynamic>> rightColumn =
                services.sublist((services.length / 2).ceil());

            return GridView.count(
              crossAxisCount: 2,
              children: [
                _buildColumn(leftColumn),
                _buildColumn(rightColumn),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildColumn(List<Map<String, dynamic>> columnData) {
    return Column(
      children: columnData.map((service) {
        return GestureDetector(
          // onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => newsDetailScreen(
          //         newsData: newsGet,
          //         newsId: newsId,
          //       ),
          //     ),
          //   );
          // },
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(service['urlimage'] ?? ''),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(6.0),
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
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            service['name'] ?? '',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
