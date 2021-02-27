import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_bud/cart.dart';

// ignore: deprecated_member_use
List<MedicinesInCart> cart = List<MedicinesInCart>();
double total = 0;
// ignore: deprecated_member_use
List<MedicinesRemaining> medRem = List<MedicinesRemaining>();

class MedicineShopping extends StatefulWidget {
  @override
  _MedicineShoppingState createState() => _MedicineShoppingState();
}

class _MedicineShoppingState extends State<MedicineShopping> {
  // List<MedicinesInCart> cart;
  List<MedicinesInShop> medicines = [
    MedicinesInShop(medId: 1, medName: 'Medicine 1', price: 29.99, quantity: 0),
    MedicinesInShop(medId: 2, medName: 'Medicine 2', price: 29.99, quantity: 0),
    MedicinesInShop(medId: 3, medName: 'Medicine 3', price: 29.99, quantity: 0),
    MedicinesInShop(medId: 4, medName: "Medicine 4", price: 29.99, quantity: 0),
    MedicinesInShop(medId: 5, medName: "Medicine 5", price: 29.99, quantity: 0),
    MedicinesInShop(medId: 6, medName: 'Medicine 6', price: 29.99, quantity: 0),
    MedicinesInShop(medId: 7, medName: 'Medicine 7', price: 29.99, quantity: 0),
    MedicinesInShop(medId: 8, medName: 'Medicine 8', price: 29.99, quantity: 0),
    MedicinesInShop(medId: 9, medName: 'Medicine 9', price: 29.99, quantity: 0),
    MedicinesInShop(
        medId: 10, medName: 'Medicine 10', price: 29.99, quantity: 0),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medicines"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          for (int i = 0; i < medicines.length; i++) {
            if (medicines[i].quantity > 0) {
              print(medicines[i].medName);
              cart.add(MedicinesInCart(
                  medId: medicines[i].medId,
                  medName: medicines[i].medName,
                  quantity: medicines[i].quantity,
                  price: medicines[i].price));
              total += medicines[i].price * medicines[i].quantity;
              print(medicines[i].medName);
            }
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Cart()),
          );
        },
        child: Icon(Icons.shopping_bag),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      body: Builder(
        builder: (context) {
          return ListView(
            children: <Widget>[
              //createHeader(),
              createMedicinesList(),
              SizedBox(
                height: 20,
              )
              // footer(context)
            ],
          );
        },
      ),
    );
  }

  footer(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Text(
                    "Total",
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 30),
                  child: Text(
                    "\$299.00",
                  ),
                ),
              ],
            ),
            RaisedButton(
              onPressed: () {},
              color: Colors.green,
              padding:
                  EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24))),
              child: Text(
                "Checkout",
              ),
            ),
          ],
        ),
        margin: EdgeInsets.only(top: 16),
      ),
    );
  }

  createHeader() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "SHOPPING CART",
      ),
      margin: EdgeInsets.only(left: 12, top: 12),
    );
  }

  createMedicinesList() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) {
        return createMedicineListItem(index);
      },
      itemCount: medicines.length,
    );
  }

  createMedicineListItem(index) {
    var remove;
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    // color: Colors.blue.shade200,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("images/tablet.jpg"))),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 8, top: 4),
                        child: Text(
                          medicines[index].medName,
                          maxLines: 2,
                          softWrap: true,
                        ),
                      ),
                      Text(
                        "for headache",
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              medicines[index].price.toString(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: medicines[index].quantity == 0
                                  ? RaisedButton.icon(
                                      onPressed: () {
                                        setState(() {
                                          medicines[index].quantity += 1;
                                          // medicines.sort((a, b) =>
                                          //     b.quantity.compareTo(a.quantity));
                                          // print(medicines);
                                        });
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(15.0)),
                                      icon: Icon(Icons.add),
                                      color: Colors.pink[50],
                                      label: Text('Add to Cart'))
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Colors.pink[500],
                                          radius: 17,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                medicines[index].quantity -= 1;
                                                // medicines.sort((a, b) => b
                                                //     .quantity
                                                //     .compareTo(a.quantity));
                                                // print(medicines);
                                              });
                                            },
                                            icon: Icon(Icons.remove),
                                            color: Colors.white,
                                            iconSize: 17,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8, bottom: 4),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 7, vertical: 6),
                                            child: Center(
                                              child: Text(
                                                medicines[index].quantity > 0
                                                    ? medicines[index]
                                                        .quantity
                                                        .toString()
                                                    : "0",
                                              ),
                                            ),
                                          ),
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Colors.pink[500],
                                          radius: 17,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                medicines[index].quantity += 1;
                                                // medicines.sort((a, b) => b
                                                //     .quantity
                                                //     .compareTo(a.quantity));
                                                // print(medicines);
                                              });
                                            },
                                            icon: Icon(Icons.add),
                                            color: Colors.white,
                                            iconSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 100,
              )
            ],
          ),
        ),
        // Align(
        //   alignment: Alignment.topRight,
        //   child: Container(
        //     width: 24,
        //     height: 24,
        //     alignment: Alignment.center,
        //     margin: EdgeInsets.only(right: 10, top: 8),
        //     child: Icon(
        //       Icons.close,
        //       color: Colors.white,
        //       size: 20,
        //     ),
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.all(Radius.circular(4)),
        //         color: Colors.green),
        //   ),
        // )
      ],
    );
  }
}

class MedicinesInShop {
  int medId;
  int quantity;
  String medName;
  double price;
  MedicinesInShop(
      {@required this.medId,
      @required this.medName,
      @required this.quantity,
      @required this.price});
}

class MedicinesInCart {
  int medId;
  int quantity;
  String medName;
  double price;
  MedicinesInCart(
      {@required this.medId,
      @required this.medName,
      @required this.quantity,
      @required this.price});
}

class MedicinesRemaining {
  int medId;
  int quantity;
  String medName;
  double price;
  MedicinesRemaining(
      {@required this.medId,
      @required this.medName,
      @required this.quantity,
      @required this.price});
}
