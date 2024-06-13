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
  String _selectedStatus = 'All';

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

  List<HistoryM> _filterAndSortByStatus(List<HistoryM> histories) {
    List<HistoryM> filteredHistories;

    if (_selectedStatus == 'All') {
      filteredHistories = histories;
    } else {
      filteredHistories = histories
          .where((history) => history.status == _selectedStatus)
          .toList();
    }

    filteredHistories.sort((a, b) => b.orderDate.compareTo(a.orderDate));
    return filteredHistories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Color.fromRGBO(231, 229, 93, 1),
          elevation: 3,
          shadowColor: Colors.black,
          automaticallyImplyLeading: false,
          title: Text(
            "Order History",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Text(
                  'Filtered:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedStatus,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedStatus = newValue!;
                    });
                  },
                  items: <String>[
                    'All',
                    'Waiting',
                    'Pending',
                    'Approved',
                    'Repairing',
                    'Canceled',
                    'Done'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<HistoryM>>(
              future: _futureHistories,
              builder: (BuildContext context,
                  AsyncSnapshot<List<HistoryM>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No history available'));
                } else {
                  List<HistoryM> filteredHistories =
                      _filterAndSortByStatus(snapshot.data!);

                  return ListView.builder(
                    itemCount: filteredHistories.length,
                    itemBuilder: (BuildContext context, int index) {
                      HistoryM history = filteredHistories[index];
                      String formattedDate = DateFormat('dd MMM yyyy, HH:mm')
                          .format(history.orderDate);

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
                                  snapshot.data![index] = updatedHistory;
                                });
                              }
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
          ),
        ],
      ),
    );
  }
}
