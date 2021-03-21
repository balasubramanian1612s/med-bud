import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Medicine {
  String name;
  String medId;
  Medicine(@required this.medId, @required this.name);
}

class SchedulerMedicineList extends StatefulWidget {
  int when;
  SchedulerMedicineList(this.when);
  @override
  _SchedulerMedicineListState createState() => _SchedulerMedicineListState();
}

class _SchedulerMedicineListState extends State<SchedulerMedicineList> {
  Widget appBarTitle = new Text("Med Bud");
  TextEditingController controller = new TextEditingController();
  List<String> selectedIds = [];
  List<Medicine> allMedicines = [];
  var provider;
  var isInit = true;

  List<Medicine> selectedMedicinnes = [];
  loadAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String allMedicinesDatabase = prefs.getString('AllMedicinesDatabase');

    if (allMedicinesDatabase != null) {
      allMedicines = jsonDecode(allMedicinesDatabase);
    } else {
      allMedicines = [];
    }

    String hasData = prefs.getString('RoutineDatabase');
    print(hasData);
    List<Medicine> tabletsIntheSheduler = [];
    if (hasData != null) {
      Map<String, dynamic> user = jsonDecode(hasData) as Map<String, dynamic>;
      user.forEach((key, value) {
        if (key == "Morning" && widget.when == 0) {
          value.forEach((k, v) {
            tabletsIntheSheduler.add(Medicine(k, v["name"]));
          });
        } else if (key == "Afternoon" && widget.when == 1) {
          value.forEach((k, v) {
            tabletsIntheSheduler.add(Medicine(k, v["name"]));
          });
        } else if (key == "Evening" && widget.when == 2) {
          value.forEach((k, v) {
            tabletsIntheSheduler.add(Medicine(k, v["name"]));
          });
        }
      });
      List<String> tempIds = [];
      tabletsIntheSheduler.forEach((element) {
        tempIds.add(element.medId);
      });
      print(tempIds);
      List<Medicine> tempMedicines = [];
      allMedicines.forEach((element) {
        print(element.medId);
        if (tempIds.contains(element.medId)) {
          print("in if");
        } else {
          tempMedicines.add(element);
        }
      });
      print(tempMedicines);
      setState(() {
        allMedicines = tempMedicines;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      loadAllData();
      isInit = false;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:
          new AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
        new IconButton(
          icon: Icon(Icons.add),
          onPressed: () {},
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          allMedicines.forEach((element) {
            if (selectedIds.contains(element.medId)) {
              selectedMedicinnes.add(element);
            }
          });
          Navigator.of(context).pop(selectedMedicinnes);
        },
        child: Icon(Icons.check),
      ),
      body: allMedicines.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: allMedicines.length,
              itemBuilder: (context, index) {
                return Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      height: 70,
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  allMedicines[index].name,
                                  style: TextStyle(fontSize: 20),
                                ),
                                Expanded(child: Container()),
                                ClipOval(
                                  child: Material(
                                    color: selectedIds
                                            .contains(allMedicines[index].medId)
                                        ? Colors.pink[200]
                                        : Colors.grey[200], // button color
                                    child: InkWell(
                                      child: SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: Icon(Icons.check)),
                                      onTap: () {
                                        setState(() {
                                          if (selectedIds.contains(
                                              allMedicines[index].medId)) {
                                            selectedIds.remove(
                                                allMedicines[index].medId);
                                          } else {
                                            selectedIds
                                                .add(allMedicines[index].medId);
                                          }
                                          // mediNames[index].quantity += 1;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ));
              }),
    );
  }
}
