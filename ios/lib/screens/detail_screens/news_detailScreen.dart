import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class newsDetailScreen extends StatelessWidget {
  final Map<String, dynamic> news;

  const newsDetailScreen({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      news['tittle'] ?? '',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        news['date'] ?? '',
                        style: TextStyle(
                          color: Color.fromRGBO(116, 117, 137, 1),
                          fontSize: 15.0,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 200.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(news['urlimage'] ?? ''),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 209, 209, 209),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 30.0,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        news['descr'] ?? '',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 15.0,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        child: Icon(
          Icons.menu_sharp,
        ),
        activeIcon: Icons.close,
        buttonSize: Size(10, 40),
        backgroundColor: Color.fromRGBO(231, 229, 93, 1),
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
              elevation: 0,
              child: Icon(Icons.favorite),
              labelWidget: Text("Favorites"),
              shape: CircleBorder(),
              onTap: () {}),
          SpeedDialChild(
            elevation: 0,
            child: Icon(Icons.comment),
            labelWidget: Text("Comments"),
            shape: CircleBorder(),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
