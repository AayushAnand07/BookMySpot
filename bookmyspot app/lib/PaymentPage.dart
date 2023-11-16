import 'package:bookmyspot/FireStoreService.dart';
import 'package:bookmyspot/MyHomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Payments extends StatefulWidget {
  String? place;
  String? address;
  int? Amount;
  String? spot;
  DateTime? selectedDate;
  int? Duration;
  String? hours;
  bool? reservation;
  Payments({this.place, this.address, this.Amount, this.selectedDate, this.spot, this.Duration, this.hours, this.reservation});

  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
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
            "Review Summary",
            style: TextStyle(fontSize: 28, color: Colors.black),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 28, right: 28),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Paking Area",
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
                        ),
                        Text(
                          widget.place.toString(),
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 28, right: 28),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Address",
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
                        ),
                        Text(
                          widget.address.toString(),
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 28, right: 28),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Paking Spot",
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
                        ),
                        Text(
                          widget.spot.toString(),
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 28, right: 28),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Date",
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
                        ),
                        Text(
                          DateFormat.yMMMMd().format(widget.selectedDate!),
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 28, right: 28),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Duration",
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
                        ),
                        Text(
                          widget.Duration.toString() + " hrs",
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 28, right: 28),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hours",
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
                        ),
                        Text(
                          widget.hours.toString(),
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(color: Color(0xffF5F4F5), borderRadius: BorderRadius.circular(20)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 28, right: 28),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Amount",
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
                        ),
                        Text(
                          "₹ " + widget.Amount!.toDouble().toStringAsFixed(2),
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 28, right: 28),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Taxes(10%)",
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
                        ),
                        Text(
                          "₹ " + (widget.Amount! * 0.1).toStringAsFixed(2),
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0, right: 28, top: 5),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, left: 28, right: 28),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
                        ),
                        Text(
                          "₹ " + ((widget.Amount! * 0.1) + (widget.Amount!).toDouble()).toStringAsFixed(2),
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(color: Color(0xffF5F4F5), borderRadius: BorderRadius.circular(20)),
            ),
          ),
          GestureDetector(
            onTap: () {
              FirestoreServices.savePayment(widget.place.toString(), widget.address.toString(), widget.spot.toString(), widget.selectedDate.toString(), widget.hours, widget.Duration!.toInt(), (widget.Amount! * 0.1) + (widget.Amount!).toDouble());
              FirestoreServices.fillspot(widget.place.toString(), widget.spot.toString(), widget.reservation);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage()));
            },
            child: Padding(
              padding: const EdgeInsets.only(
                top: 50,
              ),
              child: Center(
                child: Container(
                  child: Center(
                    child: Text(
                      "Pay " + "₹ " + ((widget.Amount! * 0.1) + (widget.Amount!).toDouble()).toStringAsFixed(2),
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
        ],
      ),
    );
  }
}
