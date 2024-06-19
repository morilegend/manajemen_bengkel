import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kp_manajemen_bengkel/models/historyModels.dart';
import 'package:kp_manajemen_bengkel/services/historyServices.dart';

class LaporanAdmin extends StatefulWidget {
  const LaporanAdmin({super.key});

  @override
  State<LaporanAdmin> createState() => _LaporanAdminState();
}

class _LaporanAdminState extends State<LaporanAdmin> {
  late Future<List<HistoryM>> _doneHistoriesFuture;
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _doneHistoriesFuture = HistoryService.getDoneHistories();
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDateRange: _selectedDateRange,
    );
    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  List<HistoryM> _filterHistoriesByDateRange(List<HistoryM> histories) {
    if (_selectedDateRange == null) return histories;
    return histories.where((history) {
      return history.orderDate.isAfter(
              _selectedDateRange!.start.subtract(const Duration(days: 1))) &&
          history.orderDate
              .isBefore(_selectedDateRange!.end.add(const Duration(days: 1)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(231, 229, 93, 1),
        title: const Text(
          'Laporan',
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: _selectDateRange,
                  child: const Text(
                    'Waktu:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
                if (_selectedDateRange != null)
                  Text(
                    '${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.start)} - ${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.end)}',
                    style: const TextStyle(fontSize: 16),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Container(
                    height: 80,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(231, 229, 93, 1),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 1,
                          spreadRadius: 0.1,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Center(
                            child: Column(
                              children: [
                                const Text(
                                  'Total Pendapatan',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(201, 0, 0, 0)),
                                ),
                                FutureBuilder<List<HistoryM>>(
                                  future: _doneHistoriesFuture,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return const Text('No data found');
                                    } else {
                                      final filteredHistories =
                                          _filterHistoriesByDateRange(
                                              snapshot.data!);
                                      final totalRevenue =
                                          filteredHistories.isNotEmpty
                                              ? filteredHistories
                                                  .map((history) =>
                                                      history.price ?? 0)
                                                  .reduce((a, b) => a + b)
                                              : 0;
                                      return Text(
                                        'Rp${NumberFormat("#,###").format(totalRevenue)}',
                                        style: const TextStyle(fontSize: 16),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
            Expanded(
              child: FutureBuilder<List<HistoryM>>(
                future: _doneHistoriesFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No data found');
                  } else {
                    final filteredHistories =
                        _filterHistoriesByDateRange(snapshot.data!);
                    return ListView.builder(
                      itemCount: filteredHistories.length,
                      itemBuilder: (context, index) {
                        final history = filteredHistories[index];
                        return Column(
                          children: [
                            ListTile(
                              title: Text('Order ID : ${history.id}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Price: Rp${NumberFormat("#,###").format(history.price ?? 0)}',
                                  ),
                                  Text(
                                    'Tanggal Pesanan: ${DateFormat('dd/MM/yyyy').format(history.orderDate)}',
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.black,
                              thickness: 0.5,
                              endIndent: 10,
                              indent: 10,
                            ),
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
      ),
    );
  }
}
