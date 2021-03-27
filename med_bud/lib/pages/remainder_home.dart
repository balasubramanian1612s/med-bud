import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:med_bud/pages/medicine_scheduler.dart';
import 'package:med_bud/pages/my_medicines.dart';
import 'package:med_bud/pages/schedule_tablets_listing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'medication_history.dart';

class RemainderHome extends StatefulWidget {
  @override
  _RemainderHomeState createState() => _RemainderHomeState();
}

class _RemainderHomeState extends State<RemainderHome> {
  bool isLoading;
  List<MedicineRoutine> morningMedicines = [];
  List<MedicineRoutine> nightMedicines = [];
  List<MedicineRoutine> afternoonMedicines = [];
  String morningText = "";
  String afternoonText = "";
  String eveningText = "";
  bool tMorn = false;
  bool tAfter = false;
  bool tEve = false;
  var now = new DateTime.now();
  var hour = DateTime.now().hour;
  loadAllData() async {
    morningText = "";
    afternoonText = "";
    eveningText = "";
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
    }
  }

  String medicationDataOff;
  Map<String, dynamic> medicationData;
  String todayString = "c" +
      DateTime.now().day.toString() +
      "/" +
      DateTime.now().month.toString() +
      "/" +
      DateTime.now().year.toString();

  updateMedictioonHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    medicationDataOff = prefs.getString('MedicationHistory');
    if (medicationDataOff != null) {
      medicationData = jsonDecode(medicationDataOff) as Map<String, dynamic>;
      print("In if");
      medicationData.putIfAbsent(
          todayString,
          () => {
                "Morning": "no",
                "Afternoon": "no",
                "Evening": "no",
              });
      setState(() {
        tMorn = medicationData[todayString]['Morning'] == "yes";
        tAfter = medicationData[todayString]['Afternoon'] == "yes";
        tEve = medicationData[todayString]['Evening'] == "yes";
      });
      prefs.setString("MedicationHistory", jsonEncode(medicationData));
    } else {
      medicationData = {
        todayString: {
          "Morning": "no",
          "Afternoon": "no",
          "Evening": "no",
        }
      };
      setState(() {
        tMorn = medicationData[todayString]['Morning'] == "yes";
        tAfter = medicationData[todayString]['Afternoon'] == "yes";
        tEve = medicationData[todayString]['Evening'] == "yes";
      });
      prefs.setString("MedicationHistory", jsonEncode(medicationData));
    }
    print(medicationData.toString());
  }

  void ddd() async {
    await loadAllData();
    await updateMedictioonHistory();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    isLoading = true;
    ddd();
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
      body: isLoading
          ? CircularProgressIndicator()
          : Column(
              children: [
                morningText == "" && afternoonText == "" && eveningText == ""
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "You don't have any medications added, Please all your medicines by clicking Change your daily medication",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : Container(),
                tMorn == true
                    ? Container()
                    : morningText == ""
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Container(
                                  // height: 100 +
                                  //     (((nightMedicines.length / 5).ceil()) * 30)
                                  //         .toDouble(),
                                  width: width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Took you Morning medication?',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Center(
                                            child: Text(
                                          morningText,
                                          textAlign: TextAlign.center,
                                        )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        RaisedButton.icon(
                                            onPressed: hour >= 6
                                                ? () async {
                                                    SharedPreferences prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    // await prefs.clear();
                                                    String hasData =
                                                        prefs.getString(
                                                            'MedicationHistory');
                                                    medicationData[todayString]
                                                        .update('Morning',
                                                            (value) => 'yes');
                                                    prefs.setString(
                                                        "MedicationHistory",
                                                        jsonEncode(
                                                            medicationData));
                                                    try {
                                                      String pillsDatas =
                                                          prefs.getString(
                                                              'PillStockDatabase');
                                                      Map<String, dynamic>
                                                          pillsStockNewData =
                                                          jsonDecode(
                                                              pillsDatas);
                                                      Map<String, dynamic>
                                                          pillsInDatabase =
                                                          pillsStockNewData;
                                                      morningMedicines
                                                          .forEach((element) {
                                                        pillsInDatabase[
                                                                element.name][
                                                            'Qty'] = (int.parse(
                                                                    pillsInDatabase[
                                                                            element.name]
                                                                        [
                                                                        'Qty']) -
                                                                element
                                                                    .quantity)
                                                            .toString();
                                                      });
                                                      prefs.setString(
                                                          'PillStockDatabase',
                                                          jsonEncode(
                                                              pillsInDatabase));
                                                    } catch (e) {
                                                      print(e);
                                                    }
                                                    print(medicationData);
                                                    updateMedictioonHistory();
                                                  }
                                                : null,
                                            icon: Icon(Icons.check),
                                            color: Colors.pink[50],
                                            label: Text("I took My medication"))
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                tAfter == true
                    ? Container()
                    : afternoonText == ""
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8, left: 8, right: 8),
                            child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Container(
                                  // height: 100 +
                                  //     (((nightMedicines.length / 5).ceil()) * 30)
                                  //         .toDouble(),
                                  width: width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Took you Afternoon medication?',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Center(
                                            child: Text(
                                          afternoonText,
                                          textAlign: TextAlign.center,
                                        )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        RaisedButton.icon(
                                            onPressed: hour >= 2
                                                ? () async {
                                                    SharedPreferences prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    // await prefs.clear();

                                                    String hasData =
                                                        prefs.getString(
                                                            'MedicationHistory');
                                                    medicationData[todayString]
                                                        .update('Afternoon',
                                                            (value) => 'yes');
                                                    prefs.setString(
                                                        "MedicationHistory",
                                                        jsonEncode(
                                                            medicationData));
                                                    print(medicationData);
                                                    try {
                                                      String pillsDatas =
                                                          prefs.getString(
                                                              'PillStockDatabase');
                                                      Map<String, dynamic>
                                                          pillsStockNewData =
                                                          jsonDecode(
                                                              pillsDatas);
                                                      Map<String, dynamic>
                                                          pillsInDatabase =
                                                          pillsStockNewData;
                                                      afternoonMedicines
                                                          .forEach((element) {
                                                        // pillsInDatabase.
                                                        pillsInDatabase[
                                                                element.name][
                                                            'Qty'] = (int.parse(
                                                                    pillsInDatabase[
                                                                            element.name]
                                                                        [
                                                                        'Qty']) -
                                                                element
                                                                    .quantity)
                                                            .toString();
                                                      });
                                                      print(pillsInDatabase);
                                                      prefs.setString(
                                                          'PillStockDatabase',
                                                          jsonEncode(
                                                              pillsInDatabase));
                                                    } catch (e) {}
                                                    updateMedictioonHistory();
                                                  }
                                                : null,
                                            icon: Icon(Icons.check),
                                            color: Colors.pink[50],
                                            label: Text("I took My medication"))
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                tEve == true
                    ? Container()
                    : eveningText == ""
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8, left: 8, right: 8),
                            child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Container(
                                  // height: 100 +
                                  //     (((nightMedicines.length / 5).ceil()) * 30)
                                  //         .toDouble(),
                                  width: width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Took you Night medication?',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Center(
                                            child: Text(
                                          eveningText,
                                          textAlign: TextAlign.center,
                                        )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        RaisedButton.icon(
                                            onPressed: hour >= 1
                                                ? () async {
                                                    SharedPreferences prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    // await prefs.clear();
                                                    String hasData =
                                                        prefs.getString(
                                                            'MedicationHistory');
                                                    medicationData[todayString]
                                                        .update('Evening',
                                                            (value) => 'yes');
                                                    prefs.setString(
                                                        "MedicationHistory",
                                                        jsonEncode(
                                                            medicationData));
                                                    print(medicationData);
                                                    try {
                                                      String pillsDatas =
                                                          prefs.getString(
                                                              'PillStockDatabase');
                                                      Map<String, dynamic>
                                                          pillsStockNewData =
                                                          jsonDecode(
                                                              pillsDatas);
                                                      Map<String, dynamic>
                                                          pillsInDatabase =
                                                          pillsStockNewData;
                                                      nightMedicines
                                                          .forEach((element) {
                                                        // pillsInDatabase.
                                                        pillsInDatabase[
                                                                element.name][
                                                            'Qty'] = (int.parse(
                                                                    pillsInDatabase[
                                                                            element.name]
                                                                        [
                                                                        'Qty']) -
                                                                element
                                                                    .quantity)
                                                            .toString();
                                                      });
                                                      print(pillsInDatabase);
                                                      prefs.setString(
                                                          'PillStockDatabase',
                                                          jsonEncode(
                                                              pillsInDatabase));
                                                    } catch (e) {}
                                                    updateMedictioonHistory();
                                                  }
                                                : null,
                                            icon: Icon(Icons.check),
                                            color: Colors.pink[50],
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => MedicationHistory()));
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
                      onTap: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => MedicineScheduler()));
                        setState(() {
                          ddd();
                        });
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
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    await Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => MyMedicines()));
                    setState(() {
                      ddd();
                    });
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
                              Icons.add,
                              color: Colors.pink,
                              size: 40,
                            ),
                            Center(
                                child: Text(
                              'Manage all your medicines',
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
    );
  }

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Notif clicked'),
        content: Text('Notification clicked $payload'),
      ),
    );
  }
}
