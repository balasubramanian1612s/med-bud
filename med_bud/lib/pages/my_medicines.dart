import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:med_bud/pages/scheduler_medicine_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyMedicines extends StatefulWidget {
  @override
  _MyMedicinesState createState() => _MyMedicinesState();
}

class _MyMedicinesState extends State<MyMedicines> {
  Widget appBarTitle = new Text("Med Bud");
  List<String> selectedIds = [];
  List<Medicine> allMedicines = [];
  var provider;
  var isInit = true;

  List<Medicine> selectedMedicinnes = [];

  updateMedicinesDatabase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List dataForAllmedicineDatabase = [];
    allMedicines.forEach((element) {
      dataForAllmedicineDatabase
          .add({'name': element.name, 'id': element.medId});
    });
    prefs.setString(
        'AllMedicinesDatabase', jsonEncode(dataForAllmedicineDatabase));
  }

  loadAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String allMedicinesDatabase = prefs.getString('AllMedicinesDatabase');

    if (allMedicinesDatabase != null) {
      print(allMedicinesDatabase);
      List ModifiedallMedicinesDatabase = jsonDecode(allMedicinesDatabase);
      ModifiedallMedicinesDatabase.forEach((element) {
        allMedicines.add(Medicine(element['id'], element['name']));
      });
      setState(() {});
    } else {
      allMedicines = [];
      setState(() {});
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

  showDeleteAlertDialog(BuildContext context, Medicine medicine) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        setState(() {
          allMedicines.remove(medicine);
          updateMedicinesDatabase();
        });
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert!"),
      content: Text("Are you sure you want to delete this medicine?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog(BuildContext context) {
    TextEditingController controller = new TextEditingController();
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Save"),
      onPressed: () {
        setState(() {
          var rng = new Random();
          allMedicines
              .add(Medicine(rng.nextInt(100000).toString(), controller.text));
          updateMedicinesDatabase();
        });
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Add Medicine"),
      content: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: 'Enter tablet name'),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:
          new AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
        new IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            showAlertDialog(context);
          },
        ),
      ]),
      body: allMedicines.isEmpty
          ? Center(
              child: Text(
                  'All you medicines will be listed here, Click on + and add New one.'))
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
                                    color: Colors.grey[400], // button color
                                    child: InkWell(
                                      child: SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: Icon(
                                            Icons.delete,
                                            // c,
                                          )),
                                      onTap: () {
                                        showDeleteAlertDialog(
                                            context, allMedicines[index]);
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
