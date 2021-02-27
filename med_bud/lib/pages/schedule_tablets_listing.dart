import 'dart:math';
import 'package:flutter/material.dart';
import 'package:med_bud/cart.dart';

class MedicineRoutine {
  int medId;
  String name;
  int quantity;
  int when;

  MedicineRoutine(@required this.medId, @required this.name,
      @required this.quantity, @required this.when);
}

class ScheduleTabletsListing extends StatefulWidget {
  @override
  _ScheduleTabletsListingState createState() => _ScheduleTabletsListingState();
}

class _ScheduleTabletsListingState extends State<ScheduleTabletsListing> {
  List<MedicineRoutine> mediNames = [];

  @override
  Widget build(BuildContext context) {
    var rng = new Random();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: UniqueKey(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("dnjksnvlsd");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScheduleTabletsListing()),
            );
          },
          child: Icon(Icons.add),
        ),
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
                                          // IconButton(
                                          //   color: Colors.red,
                                          //   icon: Icon(Icons.close_rounded),
                                          //   onPressed: () {
                                          //     setState(() {
                                          //       mediNames.removeAt(index);
                                          //     });
                                          //   },
                                          // )
                                        ],
                                      ),
                                      // Row(
                                      //   crossAxisAlignment:
                                      //       CrossAxisAlignment.center,
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceAround,
                                      //   children: [
                                      //     Expanded(child: Container()),
                                      //     ClipOval(
                                      //       child: Material(
                                      //         color:
                                      //             Colors.pink[50], // button color
                                      //         child: InkWell(
                                      //           splashColor:
                                      //               Colors.red, // inkwell color
                                      //           child: SizedBox(
                                      //               width: 40,
                                      //               height: 40,
                                      //               child: Icon(Icons.remove)),
                                      //           onTap: () {
                                      //             setState(() {
                                      //               mediNames[index].quantity -= 1;
                                      //               if (mediNames[index].quantity ==
                                      //                   0) {
                                      //                 mediNames.removeAt(index);
                                      //               }
                                      //             });
                                      //           },
                                      //         ),
                                      //       ),
                                      //     ),
                                      //     Padding(
                                      //       padding: const EdgeInsets.only(
                                      //           right: 20.0, left: 20),
                                      //       child: Text(mediNames[index]
                                      //           .quantity
                                      //           .toString()),
                                      //     ),
                                      //     ClipOval(
                                      //       child: Material(
                                      //         color:
                                      //             Colors.pink[50], // button color
                                      //         child: InkWell(
                                      //           child: SizedBox(
                                      //               width: 40,
                                      //               height: 40,
                                      //               child: Icon(Icons.add)),
                                      //           onTap: () {
                                      //             setState(() {
                                      //               mediNames[index].quantity += 1;
                                      //             });
                                      //           },
                                      //         ),
                                      //       ),
                                      //     ),
                                      //     Expanded(child: Container()),
                                      //   ],
                                      // )
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
