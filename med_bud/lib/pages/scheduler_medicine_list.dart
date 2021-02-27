import 'package:flutter/material.dart';

class Medicine {
  String name;
  int medId;
  Medicine(@required this.medId, @required this.name);
}

class SchedulerMedicineList extends StatefulWidget {
  @override
  _SchedulerMedicineListState createState() => _SchedulerMedicineListState();
}

class _SchedulerMedicineListState extends State<SchedulerMedicineList> {
  Widget appBarTitle = new Text("Med Bud");
  Icon actionIcon = new Icon(Icons.search);
  TextEditingController controller = new TextEditingController();
  List<Medicine> allMedicines = [];
  List<Medicine> searchedMedicines = [];
  List<int> selectedIds = [];
  List<Medicine> selectedMedicinnes = [];

  @override
  void initState() {
    allMedicines.add(Medicine(1, "med1"));
    allMedicines.add(Medicine(2, "med2"));
    allMedicines.add(Medicine(3, "med3"));
    allMedicines.add(Medicine(4, "med4"));
    allMedicines.add(Medicine(5, "med15"));
    allMedicines.add(Medicine(6, "med16"));
    allMedicines.add(Medicine(7, "med17"));
    allMedicines.add(Medicine(8, "med18"));
    allMedicines.add(Medicine(9, "med10"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    controller.addListener(() {
      searchedMedicines = [];
      setState(() {
        allMedicines.forEach((element) {
          if (element.name.toLowerCase().contains(controller.text)) {
            searchedMedicines.add(element);
          }
        });
      });
    });
    return Scaffold(
      appBar:
          new AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
        new IconButton(
          icon: actionIcon,
          onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = new Icon(Icons.close);
                this.appBarTitle = new TextField(
                  controller: controller,
                  style: new TextStyle(
                    color: Colors.white,
                  ),
                  decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search, color: Colors.white),
                      hintText: "Search...",
                      hintStyle: new TextStyle(color: Colors.white)),
                );
              } else {
                controller = new TextEditingController();
                this.actionIcon = new Icon(Icons.search);
                this.appBarTitle = new Text("AppBar Title");
              }
            });
          },
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          allMedicines.forEach((element) {
            if (selectedIds.contains(element.medId)) {
              selectedMedicinnes.add(element);
            }
          });
          Navigator.of(context).pop(selectedMedicinnes);
        },
        child: Icon(Icons.check),
      ),
      body: ListView.builder(
          itemCount: controller.text == ""
              ? allMedicines.length
              : searchedMedicines.length,
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
                              controller.text == ""
                                  ? allMedicines[index].name
                                  : searchedMedicines[index].name,
                              style: TextStyle(fontSize: 20),
                            ),
                            Expanded(child: Container()),
                            ClipOval(
                              child: Material(
                                color: selectedIds.contains(
                                        controller.text == ""
                                            ? allMedicines[index].medId
                                            : searchedMedicines[index].medId)
                                    ? Colors.pink[200]
                                    : Colors.grey[200], // button color
                                child: InkWell(
                                  child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: Icon(Icons.check)),
                                  onTap: () {
                                    setState(() {
                                      if (selectedIds.contains(
                                          controller.text == ""
                                              ? allMedicines[index].medId
                                              : searchedMedicines[index]
                                                  .medId)) {
                                        selectedIds.remove(controller.text == ""
                                            ? allMedicines[index].medId
                                            : searchedMedicines[index].medId);
                                      } else {
                                        selectedIds.add(controller.text == ""
                                            ? allMedicines[index].medId
                                            : searchedMedicines[index].medId);
                                      }
                                      // mediNames[index].quantity += 1;
                                    });
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
