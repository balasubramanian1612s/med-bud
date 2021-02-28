import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  var allOrders;
  var parsedMeds;
  bool _isLoading = false;
  getAllData() async {
    var medResponse = await http.get('https://med-bud.herokuapp.com/med');
    parsedMeds = jsonDecode(medResponse.body);

    var orderResponse = await http
        .get('https://med-bud.herokuapp.com/order/6039fb8a194c020cc6c75f92');
    allOrders = jsonDecode(orderResponse.body);
    print(allOrders);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    getAllData();
    _isLoading = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Med Bud'),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: ListView.builder(
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                    'Order ID: ${allOrders['orders'][i]['_id']}'),
                                Text(
                                    'Delivery by: ${allOrders['orders'][i]['deliveryDate']}'),
                                Text(
                                    'Total Payable: ${allOrders['orders'][i]['amount']}'),
                                // Divider(),
                                // for (var item in allOrders['orders'][i]['content'])
                                //   Text('${item['qty']}')
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: allOrders.length,
                ),
              ));
  }
}
