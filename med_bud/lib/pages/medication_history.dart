import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicationHistory extends StatefulWidget {
  @override
  _MedicationHistoryState createState() => _MedicationHistoryState();
}

class _MedicationHistoryState extends State<MedicationHistory> {
  String medicationDataOff;
  Map<String, dynamic> medicationData;
  String todayString = "c" +
      DateTime.now().day.toString() +
      "/" +
      DateTime.now().month.toString() +
      "/" +
      DateTime.now().year.toString();
  List<String> keys = [];
  updateMedictioonHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    medicationDataOff = prefs.getString('MedicationHistory');
    if (medicationDataOff != null) {
      medicationData = jsonDecode(medicationDataOff) as Map<String, dynamic>;
    }
    print(medicationData.toString());
    keys = medicationData.keys.toList().reversed.toList();
    setState(() {});
  }

  @override
  void initState() {
    updateMedictioonHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Med Bud'),
      ),
      body: medicationData == null
          ? Center(
              child: Text('No records found!'),
            )
          : ListView.builder(
              itemCount: medicationData.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding:
                      const EdgeInsets.only(right: 8.0, left: 8, bottom: 4),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              keys[i].substring(1),
                              style: TextStyle(fontSize: 20),
                            ),
                            Divider(),
                            Row(
                              children: [
                                Icon(
                                  medicationData[keys[i]]['Morning'] == "yes"
                                      ? Icons.check
                                      : Icons.close,
                                  color: medicationData[keys[i]]['Morning'] ==
                                          "yes"
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                Text('  Morning')
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  medicationData[keys[i]]['Afternoon'] == "yes"
                                      ? Icons.check
                                      : Icons.close,
                                  color: medicationData[keys[i]]['Afternoon'] ==
                                          "yes"
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                Text('  Afternoon')
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  medicationData[keys[i]]['Night'] == "yes"
                                      ? Icons.check
                                      : Icons.close,
                                  color:
                                      medicationData[keys[i]]['Night'] == "yes"
                                          ? Colors.green
                                          : Colors.red,
                                ),
                                Text('  Night')
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
