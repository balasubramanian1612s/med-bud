import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:med_bud/pages/medicine_scheduler.dart';
import 'package:med_bud/pages/schedule_tablets_listing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemainderHome extends StatefulWidget {
  @override
  _RemainderHomeState createState() => _RemainderHomeState();
}

class _RemainderHomeState extends State<RemainderHome> {
  List<MedicineRoutine> morningMedicines = [];
  List<MedicineRoutine> nightMedicines = [];
  List<MedicineRoutine> afternoonMedicines = [];
  String morningText = "";
  String afternoonText = "";
  String eveningText = "";
  var now = new DateTime.now();
  var hour = DateTime.now().hour;
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
      for (var item in afternoonMedicines) {
        if (afternoonText == "") {
          afternoonText += "${item.quantity} X ${item.name}";
        } else {
          afternoonText += ", ${item.quantity} X ${item.name}";
        }
      }
      for (var item in morningMedicines) {
        if (morningText == "") {
          morningText += "${item.quantity} X ${item.name}";
        } else {
          morningText += ", ${item.quantity} X ${item.name}";
        }
      }
      for (var item in nightMedicines) {
        if (eveningText == "") {
          eveningText += "${item.quantity} X ${item.name}";
        } else {
          eveningText += ", ${item.quantity} X ${item.name}";
        }
      }
      setState(() {});
    }
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
                  height: 100 +
                      (((nightMedicines.length / 5).ceil()) * 30).toDouble(),
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Took you Morning medication?',
                          style: TextStyle(fontSize: 20),
                        ),
                        Center(
                            child: Text(
                          morningText,
                          textAlign: TextAlign.center,
                        )),
                        RaisedButton.icon(
                            onPressed: hour >= 6
                                ? () async {
                                    await Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                ScheduleTabletsListing(0)));
                                    setState(() {
                                      loadAllData();
                                    });
                                  }
                                : null,
                            icon: Icon(Icons.check),
                            color:
                                hour > 6 ? Colors.pink[50] : Colors.grey[200],
                            label: Text("I took My medication"))
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
                  height: 100 +
                      (((nightMedicines.length / 5).ceil()) * 30).toDouble(),
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Took you Afternoon medication?',
                          style: TextStyle(fontSize: 20),
                        ),
                        Center(
                            child: Text(
                          afternoonText,
                          textAlign: TextAlign.center,
                        )),
                        RaisedButton.icon(
                            onPressed: hour >= 2
                                ? () async {
                                    await Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                ScheduleTabletsListing(1)));
                                    setState(() {
                                      loadAllData();
                                    });
                                  }
                                : null,
                            icon: Icon(Icons.check),
                            color:
                                hour >= 2 ? Colors.pink[50] : Colors.grey[200],
                            label: Text("I took My medication"))
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
                  height: 100 +
                      (((nightMedicines.length / 5).ceil()) * 30).toDouble(),
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Took you Night medication?',
                          style: TextStyle(fontSize: 20),
                        ),
                        Center(
                            child: Text(
                          eveningText,
                          textAlign: TextAlign.center,
                        )),
                        RaisedButton.icon(
                            onPressed: hour >= 19
                                ? () async {
                                    await Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                ScheduleTabletsListing(2)));
                                    setState(() {
                                      loadAllData();
                                    });
                                  }
                                : null,
                            icon: Icon(Icons.check),
                            color:
                                hour >= 19 ? Colors.pink[50] : Colors.grey[200],
                            label: Text("I took My medication"))
                      ],
                    ),
                  ),
                )),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (ctx) => MedicineScheduler()));
                },
                child: Card(
                  elevation: 5,
                  color: Colors.pink[50],
                  child: Container(
                    width: width * 0.45,
                    height: height * 0.12,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.history,
                            size: 40,
                            color: Colors.pink,
                          ),
                          Center(
                              child: Text(
                            'Check your Medication history',
                            textAlign: TextAlign.center,
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => MedicineScheduler()));
                },
                child: Card(
                  color: Colors.pink[50],
                  elevation: 5,
                  child: Container(
                    width: width * 0.45,
                    height: height * 0.12,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.medical_services_outlined,
                            color: Colors.pink,
                            size: 40,
                          ),
                          Center(
                              child: Text(
                            'Change your daily medication',
                            textAlign: TextAlign.center,
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
