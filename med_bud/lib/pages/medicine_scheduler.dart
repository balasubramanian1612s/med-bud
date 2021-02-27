import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:med_bud/pages/schedule_tablets_listing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicineScheduler extends StatefulWidget {
  @override
  _MedicineSchedulerState createState() => _MedicineSchedulerState();
}

class _MedicineSchedulerState extends State<MedicineScheduler> {
  List<MedicineRoutine> morningMedicines = [];
  List<MedicineRoutine> nightMedicines = [];
  List<MedicineRoutine> afternoonMedicines = [];

  loadAllData() async {
    morningMedicines = [];
    nightMedicines = [];
    afternoonMedicines = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.clear();
    String hasData = prefs.getString('RoutineDatabase');
    print(hasData);
    if (hasData != null) {
      Map<String, dynamic> user = jsonDecode(hasData) as Map<String, dynamic>;
      user.forEach((key, value) {
        if (key == "Morning") {
          value.forEach((k, v) {
            morningMedicines.add(MedicineRoutine(k, v["name"], v["qty"], 0));
          });
        } else if (key == "Afternoon") {
          value.forEach((k, v) {
            afternoonMedicines.add(MedicineRoutine(k, v["name"], v["qty"], 1));
          });
        } else if (key == "Evening") {
          value.forEach((k, v) {
            nightMedicines.add(MedicineRoutine(k, v["name"], v["qty"], 2));
          });
        }
      });
      setState(() {});
    }
    await prefs.setInt('counter', 1);
    int counter = (prefs.getInt('counter') ?? 0) + 1;
    print('Pressed $counter times.');
  }

  @override
  void initState() {
    loadAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Med Bud'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  height: 100 + morningMedicines.length * 20.toDouble(),
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Morning Routine',
                          style: TextStyle(fontSize: 20),
                        ),

                        for (var item in morningMedicines) Text(item.name),

                        RaisedButton.icon(
                            onPressed: () async {
                              await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          ScheduleTabletsListing(0)));
                              setState(() {
                                loadAllData();
                              });
                            },
                            icon: morningMedicines.isEmpty
                                ? Icon(Icons.add)
                                : Icon(Icons.edit),
                            color: Colors.pink[50],
                            label: morningMedicines.isEmpty
                                ? Text('Add your morning tablets')
                                : Text("Edit your morning tablets"))
                      ],
                    ),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
            child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  height: 100 + afternoonMedicines.length * 20.toDouble(),
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Afternoon Routine',
                          style: TextStyle(fontSize: 20),
                        ),

                        for (var item in afternoonMedicines) Text(item.name),

                        RaisedButton.icon(
                            onPressed: () async {
                              await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          ScheduleTabletsListing(1)));
                              setState(() {
                                loadAllData();
                              });
                            },
                            icon: afternoonMedicines.isEmpty
                                ? Icon(Icons.add)
                                : Icon(Icons.edit),
                            color: Colors.pink[50],
                            label: morningMedicines.isEmpty
                                ? Text('Add your afternoon tablets')
                                : Text("Edit your afternoon tablets"))
                      ],
                    ),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
            child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  height: 100 + nightMedicines.length * 20.toDouble(),
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Night Routine',
                          style: TextStyle(fontSize: 20),
                        ),

                        for (var item in nightMedicines) Text(item.name),

                        RaisedButton.icon(
                            onPressed: () async {
                              await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          ScheduleTabletsListing(2)));
                              setState(() {
                                loadAllData();
                              });
                            },
                            icon: nightMedicines.isEmpty
                                ? Icon(Icons.add)
                                : Icon(Icons.edit),
                            color: Colors.pink[50],
                            label: nightMedicines.isEmpty
                                ? Text('Add your night tablets')
                                : Text("Edit your night tablets"))
                      ],
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
