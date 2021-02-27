import 'package:flutter/material.dart';

class MedicineScheduler extends StatefulWidget {
  @override
  _MedicineSchedulerState createState() => _MedicineSchedulerState();
}

class _MedicineSchedulerState extends State<MedicineScheduler> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  height: 100,
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Morning Routine',
                          style: TextStyle(fontSize: 20),
                        ),
                        // ignore: deprecated_member_use
                        RaisedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.add),
                            color: Colors.pink[50],
                            label: Text('Add your morning tablets'))
                      ],
                    ),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
            child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  height: 100,
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Afternoon Routine',
                          style: TextStyle(fontSize: 20),
                        ),
                        // ignore: deprecated_member_use
                        RaisedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.add),
                            color: Colors.pink[50],
                            label: Text('Add your Afternoon tablets'))
                      ],
                    ),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
            child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  height: 100,
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Night Routine',
                          style: TextStyle(fontSize: 20),
                        ),
                        // ignore: deprecated_member_use
                        RaisedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.add),
                            color: Colors.pink[50],
                            label: Text('Add your Night tablets'))
                      ],
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
