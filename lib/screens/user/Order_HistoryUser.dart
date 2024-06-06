import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kp_manajemen_bengkel/models/historyModels.dart';
import 'package:kp_manajemen_bengkel/screens/user/detail_screens_user/history_detailScreenUser.dart';
import 'package:kp_manajemen_bengkel/services/historyServices.dart';
import 'package:intl/intl.dart';

class Order_HistoryUser extends StatefulWidget {
  const Order_HistoryUser({super.key});

  @override
  _Order_HistoryUserState createState() => _Order_HistoryUserState();
}

class _Order_HistoryUserState extends State<Order_HistoryUser> {
  late Future<List<HistoryM>> _futureHistories;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    final User? user = _auth.currentUser;
    if (user != null) {
      _futureHistories = HistoryService.getUserHistories(user.uid);
    } else {
      _futureHistories = Future.error("User not logged in");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(231, 229, 93, 1),
        title: Text('Order History'),
      ),
      body: FutureBuilder<List<HistoryM>>(
        future: _futureHistories,
        builder:
            (BuildContext context, AsyncSnapshot<List<HistoryM>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No history available'));
          } else {
            List<HistoryM> histories = snapshot.data!;
            return ListView.builder(
              itemCount: histories.length,
              itemBuilder: (BuildContext context, int index) {
                HistoryM history = histories[index];
                String formattedDate =
                    DateFormat('dd MMM yyyy, HH:mm').format(history.orderDate);

                return Column(
                  children: [
                    ListTile(
                      title: Text(history.id ?? 'Unknown ID'),
                      subtitle: Text(formattedDate),
                      trailing: Text(history.status),
                      onTap: () async {
                        final updatedHistory = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HistoryDetailScreenUser(history: history),
                          ),
                        );

                        if (updatedHistory != null) {
                          setState(() {
                            histories[index] = updatedHistory;
                          });
                        }
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
