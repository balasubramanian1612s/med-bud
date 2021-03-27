import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicineStock {
  final String name;
  final DateTime expiryDate;
  final int quantity;
  MedicineStock(
      @required this.name, @required this.expiryDate, @required this.quantity);
}

class PillStockHome extends StatefulWidget {
  @override
  _PillStockHomeState createState() => _PillStockHomeState();
}

class _PillStockHomeState extends State<PillStockHome> {
  Map<String, dynamic> pillsInDatabase;
  Map<String, dynamic> dailyPillCountDatabase;
  List<String> keys = [];
  bool isLoading = false;
  loadData() async {
    List<String> dataPills = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pillsDatas = prefs.getString('PillStockDatabase');

    if (pillsDatas == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String routineDatas = prefs.getString('RoutineDatabase');

      if (routineDatas == null) {
      } else {
        print(dailyPillCountDatabase);
        dailyPillCountDatabase =
            jsonEncode(prefs.getString('DailyPillCountDatabase'))
                as Map<String, int>;
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
        prefs.setString('PillStockDatabase', jsonEncode(pillsStockNewData));
        pillsInDatabase = pillsStockNewData;
        keys = pillsInDatabase.keys.toList();
      }

      setState(() {});
    } else {
      print(pillsDatas);
      String xxx = prefs.getString('DailyPillCountDatabase');
      print(xxx);
      dailyPillCountDatabase = jsonDecode(xxx);
      Map<String, dynamic> pillsStockNewData = jsonDecode(pillsDatas);
      pillsInDatabase = pillsStockNewData;
      keys = pillsInDatabase.keys.toList();

      setState(() {});
    }
    print(pillsInDatabase);
    // keys = pillsInDatabase.keys.toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
  }

  Future<void> _showMyDialog(
      Map<String, dynamic> pillsInDatabase, String selectedId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return MyDialog(pillsInDatabase, selectedId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLow = false;
    keys.forEach((element) {
      if (int.parse(pillsInDatabase[element]['Qty']) <
          dailyPillCountDatabase[element] * 5) {
        setState(() {
          isLow = true;
        });
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Med Bud'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: keys.isEmpty
                      ? Center(
                          child: Text(
                            'Add your daily medications and come up to update pill stock and expiry date!',
                            textAlign: TextAlign.center,
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              isLow
                                  ? Text(
                                      'Your have medicines stock less than 5 days',
                                      style: TextStyle(color: Colors.red),
                                    )
                                  : Container(),
                              Text(
                                'Update your pill stock and expiry date for safety!',
                                style: TextStyle(fontSize: 25),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Colors.red[500],
                                    ),
                                    Text(
                                        '   Stocks are availbe for less than 5 days')
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 5,
                                    backgroundColor: Colors.orange[500],
                                  ),
                                  Text(
                                      '   Stocks are availbe for less than 10 days')
                                ],
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 5,
                                    backgroundColor: Colors.green[500],
                                  ),
                                  Text('   No need to worry about the stock')
                                ],
                              ),
                              Divider(),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, i) {
                                  return Container(
                                    child: Card(
                                      elevation: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              color: pillsInDatabase[keys[i]]
                                                          ['Qty'] ==
                                                      '-'
                                                  ? Colors.white
                                                  : int.parse(pillsInDatabase[keys[i]]
                                                              ['Qty']) <
                                                          dailyPillCountDatabase[
                                                                  keys[i]] *
                                                              5
                                                      ? Colors.red[500]
                                                      : int.parse(pillsInDatabase[
                                                                      keys[i]]
                                                                  ['Qty']) <
                                                              dailyPillCountDatabase[
                                                                      keys[i]] *
                                                                  10
                                                          ? Colors.orange[500]
                                                          : Colors.green[500],
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      keys[i],
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    IconButton(
                                                        icon: Icon(
                                                          Icons.edit,
                                                          size: 20,
                                                        ),
                                                        onPressed: () async {
                                                          await _showMyDialog(
                                                              pillsInDatabase,
                                                              keys[i]);
                                                          setState(() {});
                                                        })
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Divider(),
                                            Text(
                                                'Expiry Date: ${pillsInDatabase[keys[i]]['expiryDate']}'),
                                            Text(
                                                'Quantity: ${pillsInDatabase[keys[i]]['Qty']}'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: keys.length,
                              )
                            ],
                          ),
                        ),
                ),
              ),
            ),
    );
  }
}

class MyDialog extends StatefulWidget {
  Map<String, dynamic> pillsInDatabase;
  String selectedId;
  MyDialog(@required this.pillsInDatabase, @required this.selectedId);
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  DateTime currentDate = DateTime.now();
  TextEditingController _controller = new TextEditingController();
  var text = 'Expiry Date';

  updateQuantity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pillsDatas = prefs.getString('PillStockDatabase');

    widget.pillsInDatabase.update(widget.selectedId,
        (value) => {'expiryDate': text, 'Qty': _controller.text});
    prefs.setString('PillStockDatabase', jsonEncode(widget.pillsInDatabase));
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _selectDate(BuildContext context) async {
      final DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: currentDate,
          firstDate: DateTime(2015),
          lastDate: DateTime(2050));
      if (pickedDate != null && pickedDate != currentDate)
        setState(() {
          currentDate = pickedDate;
          text = '${currentDate.day}/${currentDate.month}/${currentDate.year}';
        });
    }

    return AlertDialog(
      title: Text('Update Stock'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextFormField(
                controller: _controller,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                    labelText: "Quantity Available",
                    hintText: "Quantity",
                    icon: Icon(Icons.all_inbox))),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () async {
                        await _selectDate(context);
                      },
                      child: Icon(Icons.calendar_today_rounded)),
                  Text("     " + text),
                ],
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text("Don't Update"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Update'),
          onPressed: () async {
            await updateQuantity();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
