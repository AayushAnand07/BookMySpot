import 'package:bookmyspot/Booking.dart';
import 'package:bookmyspot/GlobalVariables.dart';
import 'package:bookmyspot/FireStoreService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Notifications.dart';
import 'local_notification_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color ThemeColor = Color(0x9abc0063);
  Color FontColor = Colors.white;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotificationDetails();
    FirestoreServices.getNotificationDetail();
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }

  Future<void> getNotificationDetails() async {
    await FirestoreServices.getNotificationDetail();
  }

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser.toString());
    return Scaffold(
      backgroundColor: ThemeColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80.0, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/def.jpg',
                    width: 45,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome!",
                      style: TextStyle(fontSize: 15, color: FontColor),
                    ),
                    Text(
                      FirebaseAuth.instance.currentUser!.email.toString().split("@").first,
                      style: TextStyle(fontSize: 22, color: FontColor),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => FirebaseAuth.instance.signOut(),
                      child: Container(
                        child: Icon(
                          Icons.logout,
                          color: FontColor,
                          size: 35,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () => {Navigator.of(context).push(MaterialPageRoute(builder: (context) => Notifications()))},
                      child: Container(
                        child: Icon(
                          Icons.notifications,
                          color: FontColor,
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.all(14),
            child: Text(
              "Find the best place for your vehicle!",
              style: TextStyle(fontSize: 30, color: FontColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextFormField(
              cursorColor: Colors.grey,

              key: ValueKey('Place'),
              decoration: InputDecoration(
                filled: true,
                fillColor: FontColor,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
                hintText: 'Search Places',
                iconColor: Color(0xffF3CE39),
              ),
              //
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Nearby Places",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('ParkingArea').snapshots(),
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
                            final myList = snapshot.data?.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
                            print(myList?[0]['Availability']);
                            // Render the list
                            return Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: myList?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Center(
                                    child: GestureDetector(
                                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => Booking(
                                                place: myList![index]['ParkingName'],
                                                address: myList[index]['Address'],
                                                imageUrl: myList[index]['ImageUrl'],
                                                description: myList[index]['Description'],
                                              ))),
                                      child: Container(
                                          height: MediaQuery.of(context).size.height * 0.14,
                                          width: MediaQuery.of(context).size.width * 0.9,
                                          child: Card(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Center(
                                                    child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(10.0),
                                                        child: Image.network(
                                                          myList?[index]['ImageUrl'],
                                                          height: 80,
                                                        )),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        myList?[index]['ParkingName'],
                                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                                      ),
                                                      SizedBox(
                                                        height: 7,
                                                      ),
                                                      Text(
                                                        myList?[index]['Address'],
                                                        style: TextStyle(color: Colors.grey, fontSize: 15),
                                                      ),
                                                      SizedBox(
                                                        height: 7,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            myList?[index]['Charge'] + "/hr",
                                                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(
                                                            width: 50,
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(border: Border.all(color: (myList?[index]['Availability'] == '0') ? Colors.red : Colors.green), borderRadius: BorderRadius.circular(20)),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(5.0),
                                                              child: Text(
                                                                myList?[index]['Availability'] + " Available",
                                                                style: TextStyle(color: (myList?[index]['Availability'] == '0') ? Colors.red : Colors.green, fontWeight: FontWeight.w500),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            color: Colors.white,
                                            elevation: 5,
                                          )),
                                    ),
                                  );
                                },
                              ),
                            );
                        }
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
