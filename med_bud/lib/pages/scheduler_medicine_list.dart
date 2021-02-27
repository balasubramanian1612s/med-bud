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
  Icon actionIcon = new Icon(Icons.search);
  TextEditingController controller = new TextEditingController();
  List<Medicine> allMedicines = [];
  List<Medicine> searchedMedicines = [];
  List<String> selectedIds = [];
  List<Medicine> selectedMedicinnes = [];
  loadAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.clear();
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
  void initState() {
    allMedicines.add(Medicine("id1", "med1"));
    allMedicines.add(Medicine("id2", "med2"));
    allMedicines.add(Medicine("id3", "med3"));
    allMedicines.add(Medicine("id4", "med4"));
    allMedicines.add(Medicine("id5", "med15"));
    allMedicines.add(Medicine("id6", "med16"));
    allMedicines.add(Medicine("id7", "med17"));
    allMedicines.add(Medicine("id8", "med18"));
    allMedicines.add(Medicine("id9", "med10"));
    loadAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    controller.addListener(() {
      searchedMedicines = [];
      setState(() {
        allMedicines.forEach((element) {
          if (element.name.toLowerCase().contains(controller.text)) {
            searchedMedicines.add(element);
          }
        });
      });
    });
    return Scaffold(
      appBar:
          new AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
        new IconButton(
          icon: actionIcon,
          onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = new Icon(Icons.close);
                this.appBarTitle = new TextField(
                  controller: controller,
                  style: new TextStyle(
                    color: Colors.white,
                  ),
                  decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search, color: Colors.white),
                      hintText: "Search...",
                      hintStyle: new TextStyle(color: Colors.white)),
                );
              } else {
                controller = new TextEditingController();
                this.actionIcon = new Icon(Icons.search);
                this.appBarTitle = new Text("AppBar Title");
              }
            });
          },
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
      body: ListView.builder(
          itemCount: controller.text == ""
              ? allMedicines.length
              : searchedMedicines.length,
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
                              controller.text == ""
                                  ? allMedicines[index].name
                                  : searchedMedicines[index].name,
                              style: TextStyle(fontSize: 20),
                            ),
                            Expanded(child: Container()),
                            ClipOval(
                              child: Material(
                                color: selectedIds.contains(
                                        controller.text == ""
                                            ? allMedicines[index].medId
                                            : searchedMedicines[index].medId)
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
                                          controller.text == ""
                                              ? allMedicines[index].medId
                                              : searchedMedicines[index]
                                                  .medId)) {
                                        selectedIds.remove(controller.text == ""
                                            ? allMedicines[index].medId
                                            : searchedMedicines[index].medId);
                                      } else {
                                        selectedIds.add(controller.text == ""
                                            ? allMedicines[index].medId
                                            : searchedMedicines[index].medId);
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
