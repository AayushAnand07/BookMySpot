import 'dart:collection';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'PaymentPage.dart';

class BookingStatus extends StatefulWidget {
  bool? isPrebooking;
  String? place;
  String? address;
  int? Amount;
  DateTime? selectedDate;
  int? Duration;
  String? hours;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  BookingStatus({required this.isPrebooking, this.place, this.address, this.Amount, this.selectedDate, this.Duration, this.startTime, this.endTime});

  @override
  _BookingStatusState createState() => _BookingStatusState();
}

class _BookingStatusState extends State<BookingStatus> {
  Color ThemeColor = Color(0x9abc0063);
  int _selectedContainerIndex = -1;
  bool reservation = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchDoc();
    if (CompareTime() == true)
      setState(() {
        reservation = true;
      });
    else
      setState(() {
        reservation = false;
      });

    // if (_currentTime.widget.startTime && _currentTime <= widget.endTime) {
    //   setState(() {
    //     reservation = true;
    //   });
    // }
  }

  bool? CompareTime() {
    DateTime now = DateTime.now();

    if (widget.selectedDate != null && widget.startTime != null && widget.endTime != null) {
      DateTime startDateTime = DateTime(widget.selectedDate!.year, widget.selectedDate!.month, widget.selectedDate!.day, widget.startTime!.hour, widget.startTime!.minute);
      DateTime endDateTime = DateTime(widget.selectedDate!.year, widget.selectedDate!.month, widget.selectedDate!.day, widget.endTime!.hour, widget.endTime!.minute);
      print(startDateTime.isBefore(now));
      print(endDateTime.isAfter(now));

      if (startDateTime.isBefore(now) && endDateTime.isAfter(now))
        return true;
      else
        return false;
    }
  }

  int? row;
  void _selectContainer(int index, List<String> fun, int Row) {
    if (index == _selectedContainerIndex) {
      setState(() {
        _selectedContainerIndex = -1;
      });
    } else {
      setState(() {
        selectedPaking = fun[index];
        _selectedContainerIndex = index;
        row = Row;
      });
    }
  }

  String? fieldValue;
  LinkedHashMap<String, dynamic>? Spotsdata;
  void _fetchDoc() async {
    final collectionRef = FirebaseFirestore.instance.collection('ParkingArea');

    final QuerySnapshot querySnapshot = await collectionRef.where('ParkingName', isEqualTo: widget.place).get();

    if (querySnapshot.docs.length > 0) {
      final docSnapshot = querySnapshot.docs[0];
      setState(() {
        fieldValue = docSnapshot.get('Availability');

        Spotsdata = docSnapshot.get("Spots");
      });

      // Use the fieldValue
    } else {
      setState(() {
        fieldValue = '0';
      });
    }
  }

  String selectedPaking = '';
  List<List<String>> parkingSpaces = [
    ['A1', 'A2', 'A3'],
    ['A4', 'A5', 'A6']
  ];
  bool available = false;

  @override
  Widget build(BuildContext context) {
    print(widget.Amount);
    print(reservation);
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
        body: (Spotsdata == null)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(parkingSpaces[0].length, (index) {
                          final isSelected = index == _selectedContainerIndex;

                          return GestureDetector(
                            onTap: () => (widget.isPrebooking == true) ? _selectContainer(index, parkingSpaces[0], 0) : {},
                            child: Container(
                              child: (Spotsdata![parkingSpaces[0][index]] != 'Empty') ? Image.asset('assets/car.png') : null,
                              height: MediaQuery.of(context).size.height * 0.20,
                              width: MediaQuery.of(context).size.width * 0.25,
                              decoration: BoxDecoration(color: (isSelected && (row == 0) && Spotsdata![parkingSpaces[0][index]] == "Empty") ? Color(0xffF9E6F0) : null, border: Border.all(color: Colors.black, width: 3), borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                        }))),
                Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(parkingSpaces[1].length, (index) {
                          final isSelected = index == _selectedContainerIndex;

                          return GestureDetector(
                            onTap: () => (widget.isPrebooking == true) ? _selectContainer(index, parkingSpaces[1], 1) : {},
                            child: Container(
                              child: (Spotsdata![parkingSpaces[1][index]] != 'Empty') ? Image.asset('assets/car.png') : null,
                              height: MediaQuery.of(context).size.height * 0.20,
                              width: MediaQuery.of(context).size.width * 0.25,
                              decoration: BoxDecoration(color: (isSelected && (row == 1) && (Spotsdata![parkingSpaces[1][index]] == "Empty")) ? Color(0xffF9E6F0) : null, border: Border.all(color: Colors.black, width: 3), borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                        }))),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text(
                    (widget.isPrebooking == true) ? "Selected Spot" : "Available  Spots",
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
                          (widget.isPrebooking == true)
                              ? selectedPaking
                              : (fieldValue == null)
                                  ? '0'
                                  : fieldValue!,
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      )),
                ),
                (widget.isPrebooking == false)
                    ? SizedBox()
                    : GestureDetector(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Payments(
                                  place: widget.place,
                                  address: widget.address,
                                  Amount: widget.Amount,
                                  selectedDate: widget.selectedDate,
                                  spot: selectedPaking,
                                  Duration: widget.Duration,
                                  hours: widget.startTime!.format(context).toString() + " - " + widget.endTime!.format(context).toString(),
                                  reservation: reservation,
                                ))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 50,
                          ),
                          child: Center(
                            child: Container(
                              child: Center(
                                child: Text(
                                  "Confirm Booking",
                                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.55,
                              height: MediaQuery.of(context).size.height * 0.07,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ThemeColor,
                              ),
                            ),
                          ),
                        ),
                      ),
              ]));
  }
}
