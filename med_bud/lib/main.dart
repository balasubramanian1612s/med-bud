import 'package:flutter/material.dart';
import 'package:med_bud/pages/MedicineShopping.dart';
import 'package:med_bud/pages/pill_stock_home.dart';
import 'package:med_bud/pages/remainder_home.dart';
import 'package:med_bud/provider/cart_provider.dart';
import 'package:med_bud/provider/medicine_shop_provider.dart';
import 'package:med_bud/provider/scheduler_medicine_provider.dart';
import 'package:med_bud/test/notificationPage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<SchedulerMedicineProvider>(
            create: (context) => SchedulerMedicineProvider(),
          ),
          ChangeNotifierProvider<MedicineShopProvider>(
            create: (context) => MedicineShopProvider(),
          ),
          ChangeNotifierProvider<CartProvider>(
            create: (context) => CartProvider(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.pink,
          ),
          home: MedicineShopping(),
        ));
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    PillStockHome(),
    RemainderHome(),
    MedicineShopping(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Med Bud'),
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Your Tablets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            label: 'Remainder',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Shop',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        onTap: _onItemTapped,
      ),
    );
  }
}
