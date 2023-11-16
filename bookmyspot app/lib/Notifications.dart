import 'package:bookmyspot/FireStoreService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'FireStoreService.dart';
import 'package:rxdart/rxdart.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  Color ThemeColor = Color.fromRGBO(170, 39, 98, 1);
  bool? availabe;
  bool _isConfirmed = false;

  void _isAmoutPaid() async {
    final collectionRef = FirebaseFirestore.instance.collection('Entry');
    final QuerySnapshot querySnapshot = await collectionRef.where('Payment', isEqualTo: 'PENDING').get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(170, 39, 98, 1),
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Color.fromRGBO(170, 39, 98, 1),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            color: Colors.white,
            Icons.arrow_back_ios_outlined,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 28.0),
          child: Text(
            "Notifications",
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
        ),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Entry').where('Email', isEqualTo: FirebaseAuth.instance.currentUser!.email).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        backgroundColor: ThemeColor,
                      ),
                    );
                  default:
                    // Map the documents to a list

                    // final myList = snapshot.data?.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
                    final myList = snapshot.data?.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
                    final filteredList = myList!.where((item) => item['CheckOutTime'] != null).toList();

                    final checkInList = myList.where((item) => item['Status'] == "IN").toList();

                    // if (checkInList.length > 0) FirestoreServices.sendNotif(checkInList, FirebaseAuth.instance.currentUser!.displayName);

                    return Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: filteredList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return (filteredList == null)
                              ? CircularProgressIndicator(
                                  color: ThemeColor,
                                  backgroundColor: Colors.white,
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(style: TextStyle(color: Color.fromRGBO(170, 39, 98, 1), fontSize: 20, fontWeight: FontWeight.bold), 'Location'),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            height: 40,
                                            width: 400,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Color.fromRGBO(217, 217, 217, 0.5),
                                            ),
                                            child: Center(
                                              child: Text(
                                                filteredList?[index]['ParkingName'],
                                                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(style: TextStyle(color: Color.fromRGBO(170, 39, 98, 1), fontSize: 20, fontWeight: FontWeight.bold), 'Check-in'),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 40,
                                                width: 200,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Color.fromRGBO(217, 217, 217, 0.5),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                                  child: Text(
                                                    DateFormat('dd-MM-yyyy').format((DateTime.fromMillisecondsSinceEpoch(filteredList?[index]['CheckIn'].millisecondsSinceEpoch))),
                                                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Container(
                                                height: 40,
                                                width: 110,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Color.fromRGBO(217, 217, 217, 0.5),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                                  child: Text(
                                                    DateFormat('HH:mm:ss').format((DateTime.fromMillisecondsSinceEpoch(filteredList?[index]['CheckIn'].millisecondsSinceEpoch))),
                                                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: const [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(170, 39, 98, 1),
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  'Check-Out'),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 40,
                                                width: 200,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Color.fromRGBO(217, 217, 217, 0.5),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                                  child: Text(
                                                    DateFormat('dd-MM-yyyy').format((DateTime.fromMillisecondsSinceEpoch(filteredList[index]['CheckOutTime'].millisecondsSinceEpoch))),
                                                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                height: 40,
                                                width: 110,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Color.fromRGBO(217, 217, 217, 0.5),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                                  child: Text(
                                                    DateFormat('HH:mm:ss').format((DateTime.fromMillisecondsSinceEpoch(filteredList?[index]['CheckOutTime'].millisecondsSinceEpoch))),
                                                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(170, 39, 98, 1),
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  'Duration'),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 40,
                                            width: 200,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Color.fromRGBO(217, 217, 217, 0.5),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                              child: Text(
                                                filteredList![index]['duration'].toString() + " Min",
                                                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                child: Text(style: TextStyle(color: Color.fromRGBO(170, 39, 98, 1), fontSize: 20, fontWeight: FontWeight.bold), 'Amount'),
                                              ),
                                              SizedBox(
                                                width: 120,
                                              ),
                                              Container(
                                                height: 40,
                                                width: 111,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Color.fromRGBO(217, 217, 217, 0.5),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                                  child: Text(
                                                    "₹ " + filteredList[index]['Amount'].toString(),
                                                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 175,
                                              ),
                                              filteredList[index]['Payment'] == 'PENDING'
                                                  ? GestureDetector(
                                                      onTap: () async {
                                                        FirebaseFirestore.instance
                                                            .collection('Entry')
                                                            // replace 'OrderId' with the actual field name
                                                            .where('Payment', isEqualTo: 'PENDING')
                                                            .get()
                                                            .then((querySnapshot) {
                                                          if (querySnapshot.size == 1) {
                                                            var docSnapshot = querySnapshot.docs[0];
                                                            docSnapshot.reference.update({'Payment': 'SUCCESS'});
                                                          }
                                                        });
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        height: 50,
                                                        width: 150,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Color.fromRGBO(170, 39, 98, 1),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                                          child: Center(
                                                            child: Text(
                                                              "Pay ₹ " + filteredList[index]['Amount'].toString(),
                                                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding: const EdgeInsets.only(left: 48.0),
                                                      child: Image.asset("assets/badge.png"),
                                                    ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                        },
                      ),
                    );
                }
              }),
        ],
      ),
    );
  }
}
