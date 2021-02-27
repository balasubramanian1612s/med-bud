import 'package:flutter/material.dart';
import 'package:med_bud/pages/schedule_tablets_listing.dart';

class MedicineScheduler extends StatefulWidget {
  @override
  _MedicineSchedulerState createState() => _MedicineSchedulerState();
}

class _MedicineSchedulerState extends State<MedicineScheduler> {
  List<MedicineRoutine> morningMedicines = [];
  List<MedicineRoutine> nightMedicines = [];
  List<MedicineRoutine> afternoonMedicines = [];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Med Bud'),
      ),
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
                  height: 100 + morningMedicines.length * 20.toDouble(),
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
                        for (var item in morningMedicines) Text(item.name),
                        RaisedButton.icon(
                            onPressed: () async {
                              morningMedicines = await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (ctx) =>
                                          ScheduleTabletsListing()));
                              setState(() {});
                            },
                            icon: morningMedicines.isEmpty
                                ? Icon(Icons.add)
                                : Icon(Icons.edit),
                            color: Colors.pink[50],
                            label: morningMedicines.isEmpty
                                ? Text('Add your morning tablets')
                                : Text("Edit your morning tablets"))
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
                  height: 100 + afternoonMedicines.length * 20.toDouble(),
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
                        for (var item in afternoonMedicines) Text(item.name),
                        RaisedButton.icon(
                            onPressed: () async {
                              afternoonMedicines = await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (ctx) =>
                                          ScheduleTabletsListing()));
                              setState(() {});
                            },
                            icon: afternoonMedicines.isEmpty
                                ? Icon(Icons.add)
                                : Icon(Icons.edit),
                            color: Colors.pink[50],
                            label: morningMedicines.isEmpty
                                ? Text('Add your afternoon tablets')
                                : Text("Edit your afternoon tablets"))
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
                  height: 100 + nightMedicines.length * 20.toDouble(),
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
                        for (var item in nightMedicines) Text(item.name),
                        RaisedButton.icon(
                            onPressed: () async {
                              nightMedicines = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (ctx) =>
                                          ScheduleTabletsListing()));
                              setState(() {});
                            },
                            icon: nightMedicines.isEmpty
                                ? Icon(Icons.add)
                                : Icon(Icons.edit),
                            color: Colors.pink[50],
                            label: nightMedicines.isEmpty
                                ? Text('Add your night tablets')
                                : Text("Edit your night tablets"))
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
