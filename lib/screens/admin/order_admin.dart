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
  String _selectedStatus = 'All';

  @override
  void initState() {
    super.initState();
    _futureHistories = HistoryService.getAllHistories();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _futureHistories = HistoryService.getAllHistories();
    });
  }

  Future<void> _updateStatus(String historyId, String status) async {
    await HistoryService.updateStatus(historyId, status);
    setState(() {
      _futureHistories = HistoryService.getAllHistories();
    });
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
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(231, 229, 93, 1),
        title: Text('All Orders'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Text(
                  'Filter::',
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
                      String formattedDate = DateFormat('dd/MM/yyyy, HH:mm')
                          .format(history.orderDate);

                      return Column(
                        children: [
                          ListTile(
                            title: Text(history.id!),
                            subtitle: Text(formattedDate),
                            trailing: Text(history.status),
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HistoryDetailScreenAdmin(
                                          history: history),
                                ),
                              );
                              setState(() {
                                _futureHistories =
                                    HistoryService.getAllHistories();
                              });
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
