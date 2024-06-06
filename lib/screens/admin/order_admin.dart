import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kp_manajemen_bengkel/models/historyModels.dart';
import 'package:kp_manajemen_bengkel/screens/admin/detail_screens_admin/history_detailScreenAdmin.dart';
import 'package:kp_manajemen_bengkel/services/historyServices.dart';
import 'package:intl/intl.dart';

class OrderAdmin extends StatefulWidget {
  const OrderAdmin({super.key});

  @override
  _OrderAdminState createState() => _OrderAdminState();
}

class _OrderAdminState extends State<OrderAdmin> {
  late Future<List<HistoryM>> _futureHistories;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _futureHistories = HistoryService.getAllHistories();
  }

  Future<void> _updateStatus(String historyId, String status) async {
    await HistoryService.updateStatus(historyId, status);
    setState(() {
      _futureHistories = HistoryService.getAllHistories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(231, 229, 93, 1),
        title: Text('All Orders'),
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
                      title: Text(history.id!),
                      subtitle: Text(formattedDate),
                      trailing: Text(history.status),
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HistoryDetailScreenAdmin(history: history),
                          ),
                        );
                      },
                    ),
                    Divider()
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
