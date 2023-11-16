import 'package:bookmyspot/BookPaking.dart';
import 'package:bookmyspot/GlobalVariables.dart';
import 'package:bookmyspot/Status.dart';
import 'package:bookmyspot/liveStatus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'PreebokStatus.dart';

class Booking extends StatefulWidget {
  final String place;
  final String address;
  final String imageUrl;
  final String description;
  Booking({required this.place, required this.address, required this.imageUrl, required this.description});

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  Globals variables = new Globals();

  Color ThemeColor = Color(0x9abc0063);
  @override
  Widget build(BuildContext context) {
    print(variables.ImageUrl);
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
            "Parking Details",
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 25.0, right: 25),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: (widget.imageUrl == null)
                  ? Center(
                      child: CircularProgressIndicator(
                        color: ThemeColor,
                      ),
                    )
                  : Image.network(
                      widget.imageUrl,
                    ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Container(
              child: Text(
                widget.place,
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Container(
              child: Text(
                widget.address,
                style: TextStyle(fontSize: 15, color: Colors.blueGrey),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    child: Icon(
                      Icons.directions,
                      color: Colors.white,
                    ),
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: ThemeColor),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time_filled,
                          color: Colors.white,
                        ),
                        Text(
                          " 8 AM - 10 PM ",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: ThemeColor,
                        ),
                        color: ThemeColor),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_view_day_rounded,
                          color: Colors.white,
                        ),
                        (widget.place.toString() == "Parking Area-1")
                            ? Text(
                                " On-Arrivals",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              )
                            : Text(
                                " Pre-Booking ",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              )
                      ],
                    ),
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: ThemeColor,
                        ),
                        color: ThemeColor),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Description",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  widget.description,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => (widget.place.toString() == "Parking Area-1")
                          ? LiveStatus()
                          : BookingStatus(
                              isPrebooking: false,
                              place: widget.place,
                            ))),
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Center(
                      child: Text(
                        "Show Status",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(color: ThemeColor, borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                (widget.place.toString() == "Parking Area-1")
                    ? SizedBox()
                    : GestureDetector(
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BookParking(
                                  place: widget.place,
                                  address: widget.address,
                                ))),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Center(
                            child: Text(
                              "Book",
                              style: TextStyle(color: ThemeColor, fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(color: Color(0xffC9C9C9), borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
