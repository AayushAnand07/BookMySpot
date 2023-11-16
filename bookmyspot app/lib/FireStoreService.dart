import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class FirestoreServices {
  static bool? isUser;
  static saveUser(String name, email, uid, mob, plate) async {
    await FirebaseFirestore.instance.collection('Users').doc(uid).set({'Email': email, 'Name': name, 'MobileNumber': mob, 'NumberPlate': plate});
  }

  static savePayment(String place, address, spot, selectedDate, hours, int duration, Amount) async {
    await FirebaseFirestore.instance.collection("Reservations").doc().set({'Booking Place': place, "Address": address, "Spot": spot, "BookingDate": selectedDate, "TimeSlot": hours, "Duration": duration, "Amount": Amount});
  }

  static fillspot(String place, BookSpot, bool? reserv) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('ParkingArea').where('ParkingName', isEqualTo: place).get();

// Loop through the documents and update the field
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      // Get a reference to the document

      DocumentReference docRef = FirebaseFirestore.instance.collection('ParkingArea').doc(doc.id);
      DocumentSnapshot snap = await docRef.get();
      int spots = (int.tryParse(snap['Availability']))!.toInt();
      spots--;
      String spot = spots.toString();
      // Update the field within the map
      if (reserv == true) {
        await docRef.update({'Availability': spot});
        await docRef.update({'Spots.${BookSpot}': 'Filled'});
      }
    }
  }

  static Future<bool> fetchUser(String PlateNumber) async {
    final collectionRef = FirebaseFirestore.instance.collection('Users');
    //  final //collectionRef1 = FirebaseFirestore.instance.collection('Entry');
    final QuerySnapshot querySnapshot = await collectionRef.where('NumberPlate', isEqualTo: PlateNumber).get();
    // final QuerySnapshot querySnapshot1 = await collectionRef.where('Payment', isEqualTo: "PENDING").get();
    if (querySnapshot.docs.length > 0) {
      print("working");
      final docSnapshot = querySnapshot.docs[0];
      return Future.delayed(Duration(seconds: 1), () => ("Rishabh Sharma" == docSnapshot.get("Name")));
    }
    return false;
  }

  static fetchDoc(String place) async {
    final collectionRef = FirebaseFirestore.instance.collection('ParkingArea');

    final QuerySnapshot querySnapshot = await collectionRef.where('ParkingName', isEqualTo: place).get();

    if (querySnapshot.docs.length > 0) {
      final docSnapshot = querySnapshot.docs[0];
      int space = docSnapshot.get("Availability");

      // Use the fieldValue
    }
  }

  static countEmptySpots() {
    DatabaseReference parkingAreaRef = FirebaseDatabase.instance.ref().child('ParkingArea-1');

    parkingAreaRef.onValue.listen((DatabaseEvent event) {
      Object? snapshotValue = event.snapshot.value;
      Map<dynamic, dynamic> valueMap = snapshotValue is Map<dynamic, dynamic> ? snapshotValue : {};
      int count = 0;
      for (String status in valueMap.values) {
        if (status == "Empty") count++;
      }
      print(count);
    });
  }

  static sendNotif(QueryDocumentSnapshot data, String? name) async {
    var serverKey = 'AAAAVaYlwrU:APA91bFE6_LscEUyDIahg0n_nn4-aE0z8Fn2BX45i0w5Vsk6k9v3b-PGhqWilDxP9X5VHEy5cGDdeqKTW8ZGdvKo97WN6tq7t1cn_MlpjlFjkq56TpPhxwnVMc4V7bqlA5WjZaT5nDw-';
    final collectionRef = FirebaseFirestore.instance.collection('Entry');
    final QuerySnapshot querySnapshot = await collectionRef.where('NotificationSent', isEqualTo: "false").where('Email', isEqualTo: FirebaseAuth.instance.currentUser!.email).get();
    print(querySnapshot.docs.length);
    if (querySnapshot.docs.length > 0) {
      http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{'body': ' Welcome ${name}! \nCheckInTime:${DateFormat('dd/MM/yyyy HH:mm').format((DateTime.fromMillisecondsSinceEpoch(data.get('CheckIn').millisecondsSinceEpoch)))} ', 'title': 'Welcome to Parking Area-1'},
            'priority': 'high',
            //'data': <String, dynamic>{'click_action': 'FLUTTER_NOTIFICATION_CLICK', 'id': '1', 'status': 'done'},
            'to': "ee3DI8K0QEGnLB6u8j74sz:APA91bH8NHuLs3dJxK9jk034ngurKUAfSoFTkztOIa3NB6CZnzNcuKtZTaTwKQngDic5XDMb9q-wq4jFGdS87mvB77vXHKjnO4EqQNAsPycE7WOfPieUuLfuHT9m3KHhgxt_kmhIG1da",
          },
        ),
      );
      final docRef = querySnapshot.docs[0].reference;
      await docRef.update({'NotificationSent': "true"});
    }
  }

  static getNotificationDetail() async {
    final collectionRef = FirebaseFirestore.instance.collection('Entry');
    final currentUserEmail = FirebaseAuth.instance.currentUser!.email;
    final currentUserName = FirebaseAuth.instance.currentUser!.displayName;

    collectionRef.where('Status', isEqualTo: "IN").where('NotificationSent', isEqualTo: "false").where('Email', isEqualTo: currentUserEmail).snapshots().listen((querySnapshot) {
      print('from getnotification ${querySnapshot.docs.length}');
      if (querySnapshot.docs.isNotEmpty) {
        final docSnapshot = querySnapshot.docs[0];
        FirestoreServices.sendNotif(docSnapshot, currentUserName);
      }
    });
  }
}
