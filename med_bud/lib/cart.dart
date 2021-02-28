import 'package:flutter/material.dart';
import 'package:med_bud/main.dart';
import 'package:med_bud/provider/cart_provider.dart';
import 'package:provider/provider.dart';

import 'pages/MedicineShopping.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            cart.clear();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Builder(
        builder: (context) {
          return ListView(
            children: <Widget>[
              createCartList(),
              footer(context),
              SizedBox(
                height: 20,
              )
            ],
          );
        },
      ),
    );
  }

  createCartList() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) {
        return createCartListItem(index);
      },
      itemCount: cart.length,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    child: Text(
                      "Total",
                      style: TextStyle(
                          color: Colors.pink,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 30),
                    child: Text(
                      '₹ ${total.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: RaisedButton(
                onPressed: () async {
                  var provider =
                      Provider.of<CartProvider>(context, listen: false);
                  String name = await provider.placeOrder(cart, total);
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => AlertDialog(
                      title: Text("Order placed"),
                      content: Text(
                          "Congratulations $name ! Your order was placed successfully"),
                      actions: [
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => MyStatefulWidget()),
                                  (_) => false);
                            },
                            child: Text('Okay'))
                      ],
                    ),
                  );
                },
                color: Colors.pink[100],
                padding:
                    EdgeInsets.only(top: 12, left: 50, right: 50, bottom: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                child: Text(
                  "CHECKOUT",
                ),
              ),
            ),
          ],
        ),
        margin: EdgeInsets.only(top: 16),
      ),
    );
  }

  createCartListItem(index) {
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
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: Text(
                          "${cart[index].medName}      X    ${cart[index].quantity} ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                          maxLines: 2,
                          softWrap: true,
                        ),
                      ),
                      Text(
                        "₹ ${(cart[index].price * cart[index].quantity).toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Colors.pink,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      // Container(
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: <Widget>[
                      //       Text(
                      //         cart[index].price.toString(),
                      //       ),
                      //       Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: cart[index].quantity == 0
                      //             ? RaisedButton.icon(
                      //                 onPressed: () {
                      //                   setState(() {
                      //                     cart[index].quantity += 1;
                      //                   });
                      //                 },
                      //                 shape: RoundedRectangleBorder(
                      //                     borderRadius:
                      //                         new BorderRadius.circular(15.0)),
                      //                 icon: Icon(Icons.add),
                      //                 color: Colors.pink[50],
                      //                 label: Text('Add to Cart'))
                      //             : Row(
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.center,
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.end,
                      //                 children: <Widget>[
                      //                   CircleAvatar(
                      //                     backgroundColor: Colors.pink[50],
                      //                     radius: 17,
                      //                     child: IconButton(
                      //                       onPressed: () {
                      //                         setState(() {
                      //                           cart[index].quantity -= 1;
                      //                         });
                      //                       },
                      //                       icon: Icon(Icons.remove),
                      //                       color: Colors.grey.shade700,
                      //                       iconSize: 17,
                      //                     ),
                      //                   ),
                      //                   Padding(
                      //                     padding: const EdgeInsets.only(
                      //                         left: 8.0, right: 8, bottom: 4),
                      //                     child: Container(
                      //                       padding: const EdgeInsets.symmetric(
                      //                           horizontal: 7, vertical: 6),
                      //                       child: Center(
                      //                         child: Text(
                      //                           cart[index].quantity > 0
                      //                               ? cart[index]
                      //                                   .quantity
                      //                                   .toString()
                      //                               : "0",
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                   CircleAvatar(
                      //                     backgroundColor: Colors.pink[50],
                      //                     radius: 17,
                      //                     child: IconButton(
                      //                       onPressed: () {
                      //                         setState(() {
                      //                           cart[index].quantity += 1;
                      //                         });
                      //                       },
                      //                       icon: Icon(Icons.add),
                      //                       color: Colors.grey.shade700,
                      //                       iconSize: 17,
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                flex: 100,
              )
            ],
          ),
        ),
      ],
    );
  }
}
