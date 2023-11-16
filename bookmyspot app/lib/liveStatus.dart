import 'package:bookmyspot/FireStoreService.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveStatus extends StatefulWidget {
  const LiveStatus({Key? key}) : super(key: key);

  @override
  _LiveStatusState createState() => _LiveStatusState();
}

class _LiveStatusState extends State<LiveStatus> {
  List<List<String>> parkingSpaces = [
    ['Spot1', 'Spot2', 'Spot3'],
    ['Spot4', 'Spot5', 'Spot6']
  ];

  int count = 0;
  Map<dynamic, dynamic>? res;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    countEmptySpots();
  }

  bool? flag;
  void countEmptySpots() {
    // Get a reference to the 'ParkingArea-1' object in the Realtime Database
    DatabaseReference parkingAreaRef = FirebaseDatabase.instance.ref().child('ParkingArea-1');

    // Set up a listener to track changes to the object
    parkingAreaRef.onValue.listen((DatabaseEvent event) {
      // Get the object containing spot status data from the event
      if (event.snapshot.value == null) {
        return; // nothing to do
      }
      Object? snapshotValue = event.snapshot.value;
      setState(() {
        res = snapshotValue is Map<dynamic, dynamic> ? snapshotValue : {};
      });

      int emptyCount = 0;

      for (String? status in res!.values) {
        if (status == "Empty") {
          emptyCount++;
        }
      }

      setState(() {
        count = emptyCount;
      });
      print(count);
    });
  }

  Color ThemeColor = Color(0x9abc0063);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              color: Colors.black,
              Icons.arrow_back_ios_outlined,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(right: 28.0),
            child: Text(
              "Parking Spots",
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
          ),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(parkingSpaces[0].length, (index) {
                    //final isSelected = index == _selectedContainerIndex;

                    return Container(
                      child: (res != null && res![parkingSpaces[0][index]] != 'Empty') ? Image.asset('assets/car.png') : SizedBox(),
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 3), borderRadius: BorderRadius.circular(10)),
                    );
                  }))),
          Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(parkingSpaces[1].length, (index) {
                    // final isSelected = index == _selectedContainerIndex;

                    return Container(
                      child: (res != null && res![parkingSpaces[1][index]] != 'Empty') ? Image.asset('assets/car.png') : SizedBox(),
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 3), borderRadius: BorderRadius.circular(10)),
                    );
                  }))),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              "Available  Spots",
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(color: ThemeColor, borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    count.toString(),
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                )),
          ),
          SizedBox(),
        ]));
  }
}
