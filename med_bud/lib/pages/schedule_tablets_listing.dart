import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:med_bud/pages/scheduler_medicine_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicineRoutine {
  String medId;
  String name;
  int quantity;
  int when;

  MedicineRoutine(@required this.medId, @required this.name,
      @required this.quantity, @required this.when);
}

class ScheduleTabletsListing extends StatefulWidget {
  int when;
  ScheduleTabletsListing(this.when);
  @override
  _ScheduleTabletsListingState createState() => _ScheduleTabletsListingState();
}

class _ScheduleTabletsListingState extends State<ScheduleTabletsListing> {
  List<MedicineRoutine> mediNames = [];
  List<Medicine> selectedMedicines = [];
  loadAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.clear();
    String hasData = prefs.getString('RoutineDatabase');
    print(hasData);
    if (hasData != null) {
      Map<String, dynamic> user = jsonDecode(hasData) as Map<String, dynamic>;
      user.forEach((key, value) {
        if (key == "Morning" && widget.when == 0) {
          value.forEach((k, v) {
            mediNames.add(MedicineRoutine(k, v["name"], v["qty"], 0));
          });
        } else if (key == "Afternoon" && widget.when == 1) {
          value.forEach((k, v) {
            mediNames.add(MedicineRoutine(k, v["name"], v["qty"], 1));
          });
        } else if (key == "Evening" && widget.when == 2) {
          value.forEach((k, v) {
            mediNames.add(MedicineRoutine(k, v["name"], v["qty"], 2));
          });
        }
      });
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
    var rng = new Random();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Med Bud'),
          actions: [
            IconButton(
                icon: Icon(Icons.check),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String MorAorN = widget.when == 0
                      ? 'Morning'
                      : widget.when == 1
                          ? 'Afternoon'
                          : 'Evening';
                  var map1 = Map.fromIterable(mediNames,
                      key: (e) => e.medId,
                      value: (e) => {'name': e.name, 'qty': e.quantity});
                  print(map1.toString());

                  String hasData = prefs.getString('RoutineDatabase');
                  if (hasData == null) {
                    print(" i am in if");
                    String m1, m2;
                    if (MorAorN == "Morning") {
                      m1 = "Afternoon";
                      m2 = "Evening";
                    } else if (MorAorN == "Afternoon") {
                      m1 = "Morning";
                      m2 = "Evening";
                    } else if (MorAorN == "Evening") {
                      m1 = "Morning";
                      m2 = "Afternoon";
                    }
                    var mainMap = {MorAorN: map1, m1: {}, m2: {}};
                    prefs.setString("RoutineDatabase", jsonEncode(mainMap));
                  } else {
                    print(" i am in else");

                    Map<String, dynamic> dataFromDatabse =
                        jsonDecode(hasData) as Map<String, dynamic>;
                    dataFromDatabse.update(MorAorN, (value) => map1);

                    prefs.setString(
                        "RoutineDatabase", jsonEncode(dataFromDatabse));
                    Map<String, int> mainPills = {};

                    dataFromDatabse['Morning'].forEach((key, value) {
                      bool alreadyExist = mainPills.containsKey(value['name']);
                      if (alreadyExist) {
                        mainPills[value['name']] += value['qty'];
                      } else {
                        mainPills[value['name']] = value['qty'];
                      }
                    });
                    dataFromDatabse['Afternoon'].forEach((key, value) {
                      bool alreadyExist = mainPills.containsKey(value['name']);
                      if (alreadyExist) {
                        mainPills[value['name']] += value['qty'];
                      } else {
                        mainPills[value['name']] = value['qty'];
                      }
                    });
                    dataFromDatabse['Evening'].forEach((key, value) {
                      bool alreadyExist = mainPills.containsKey(value['name']);
                      if (alreadyExist) {
                        mainPills[value['name']] += value['qty'];
                      } else {
                        mainPills[value['name']] = value['qty'];
                      }
                    });
                    print(mainPills);
                    prefs.setString(
                        'DailyPillCountDatabase', jsonEncode(mainPills));

                    //new
                    List<String> dataPills = [];
                    Map<String, dynamic> pillsInDatabase;
                    String routineDatas = prefs.getString('RoutineDatabase');
                    Map<String, dynamic> routineDatabase =
                        jsonDecode(routineDatas) as Map<String, dynamic>;
                    routineDatabase.values.forEach((element) {
                      var thirdMap = {}
                        ..addAll(routineDatabase['Morning'])
                        ..addAll(routineDatabase['Afternoon'])
                        ..addAll(routineDatabase['Evening']);
                      print(thirdMap);
                      element.values.forEach((e) {
                        dataPills.add(e['name']);
                      });
                    });
                    var allPills = dataPills.toSet().toList();
                    Map<String, dynamic> pillsStockNewData = {};
                    allPills.forEach((element) {
                      pillsStockNewData.putIfAbsent(
                          element, () => {'expiryDate': '-', 'Qty': '0'});
                    });
                    prefs.setString(
                        'PillStockDatabase', jsonEncode(pillsStockNewData));
                    pillsInDatabase = pillsStockNewData;
                  }
                  String loadedData = prefs.getString('RoutineDatabase');
                  print(loadedData);
                  Navigator.of(context).pop();
                })
          ],
        ),
        floatingActionButton: FloatingActionButton(onPressed: () async {
          selectedMedicines = await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (ctx) => SchedulerMedicineList(widget.when)));
          if (selectedMedicines != null) {
            setState(() {
              selectedMedicines.forEach((element) {
                mediNames.add(
                    new MedicineRoutine(element.medId, element.name, 1, 0));
              });
            });
          }
        }),

        // child: Icon(Icons.add),
        // ),
        body: mediNames.isEmpty
            ? Center(
                child: Text('Click + and add your Morning routine tablets'),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                    child: ListView.builder(
                  // Let the ListView know how many items it needs to build.
                  itemCount: mediNames.length,
                  // Provide a builder function. This is where the magic happens.
                  // Convert each item into a widget based on the type of item it is.
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16, left: 16, right: 16),
                        child: Dismissible(
                          onDismissed: (direction) {
                            setState(() {
                              mediNames.removeAt(index);
                            });
                          },
                          background: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: Colors.red,
                            ),
                            child: Center(
                                child: Text(
                              'Remove Item',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )),
                          ),
                          key: Key(mediNames[index].name),
                          child: Card(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            mediNames[index].name,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Expanded(child: Container()),
                                          ClipOval(
                                            child: Material(
                                              color: Colors
                                                  .pink[50], // button color
                                              child: InkWell(
                                                splashColor:
                                                    Colors.red, // inkwell color
                                                child: SizedBox(
                                                    width: 30,
                                                    height: 30,
                                                    child: Icon(Icons.remove)),
                                                onTap: () {
                                                  setState(() {
                                                    mediNames[index].quantity -=
                                                        1;
                                                    if (mediNames[index]
                                                            .quantity ==
                                                        0) {
                                                      mediNames.removeAt(index);
                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20.0, left: 20),
                                            child: Text(mediNames[index]
                                                .quantity
                                                .toString()),
                                          ),
                                          ClipOval(
                                            child: Material(
                                              color: Colors
                                                  .pink[50], // button color
                                              child: InkWell(
                                                child: SizedBox(
                                                    width: 30,
                                                    height: 30,
                                                    child: Icon(Icons.add)),
                                                onTap: () {
                                                  setState(() {
                                                    mediNames[index].quantity +=
                                                        1;
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
                              )),
                        ));
                  },
                )),
              ));
  }
}
