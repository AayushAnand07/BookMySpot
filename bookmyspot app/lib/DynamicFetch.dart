// import 'package:bookmyspot/Booking.dart';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class DynamicFetch extends StatefulWidget {
//   const DynamicFetch({Key? key}) : super(key: key);
//
//   @override
//   _DynamicFetchState createState() => _DynamicFetchState();
// }
//
// class _DynamicFetchState extends State<DynamicFetch> {
//   Color ThemeColor = Color(0x9abc0063);
//   Color FontColor = Colors.white;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ThemeColor,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 80.0, left: 30, right: 30),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Welcome",
//                       style: TextStyle(fontSize: 15, color: FontColor),
//                     ),
//                     Text(
//                       "Aayush Anand",
//                       style: TextStyle(fontSize: 20, color: FontColor),
//                     ),
//                   ],
//                 ),
//                 GestureDetector(
//                   onTap: () => FirebaseAuth.instance.signOut(),
//                   child: Container(
//                     child: Icon(
//                       Icons.logout,
//                       color: FontColor,
//                       size: 35,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 30,
//           ),
//           Padding(
//             padding: EdgeInsets.all(14),
//             child: Text(
//               "Find the best place for your vehicle!",
//               style: TextStyle(fontSize: 30, color: FontColor),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(14.0),
//             child: TextFormField(
//               cursorColor: Colors.grey,
//
//               key: ValueKey('Place'),
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: FontColor,
//                 prefixIcon: Icon(
//                   Icons.search,
//                   color: Colors.grey,
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                   borderSide: BorderSide(color: Colors.white, width: 2),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                   borderSide: BorderSide(color: Colors.white, width: 2),
//                 ),
//                 hintText: 'Search Places',
//                 iconColor: Color(0xffF3CE39),
//               ),
//               //
//             ),
//           ),
//           SizedBox(
//             height: 40,
//           ),
//           Expanded(
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20, bottom: 15),
//                     child: Text(
//                       "Nearby Places",
//                       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
//                     ),
//                   ),
//                   StreamBuilder<QuerySnapshot>(
//                       stream: FirebaseFirestore.instance.collection('ParkingArea').snapshots(),
//                       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                         if (snapshot.hasError) {
//                           return Text('Error: ${snapshot.error}');
//                         }
//                         switch (snapshot.connectionState) {
//                           case ConnectionState.waiting:
//                             return Center(
//                               child: CircularProgressIndicator(
//                                 color: Colors.white,
//                                 backgroundColor: ThemeColor,
//                               ),
//                             );
//                           default:
//                             // Map the documents to a list
//                             final myList = snapshot.data?.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
//                             print(myList?[0]['Availability']);
//                             // Render the list
//                             return Expanded(
//                               child: ListView.builder(
//                                 scrollDirection: Axis.vertical,
//                                 shrinkWrap: true,
//                                 itemCount: myList?.length,
//                                 itemBuilder: (BuildContext context, int index) {
//                                   return Center(
//                                     child: GestureDetector(
//                                       onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Booking())),
//                                       child: Container(
//                                           height: MediaQuery.of(context).size.height * 0.14,
//                                           width: MediaQuery.of(context).size.width * 0.9,
//                                           child: Card(
//                                             child: Row(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 Padding(
//                                                   padding: const EdgeInsets.all(8.0),
//                                                   child: Center(
//                                                     child: ClipRRect(
//                                                         borderRadius: BorderRadius.circular(10.0),
//                                                         child: Image.network(
//                                                           myList?[index]['ImageUrl'],
//                                                           height: 80,
//                                                         )),
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20),
//                                                   child: Column(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       Text(
//                                                         myList?[index]['ParkingName'],
//                                                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                                                       ),
//                                                       SizedBox(
//                                                         height: 7,
//                                                       ),
//                                                       Text(
//                                                         myList?[index]['Address'],
//                                                         style: TextStyle(color: Colors.grey, fontSize: 15),
//                                                       ),
//                                                       SizedBox(
//                                                         height: 7,
//                                                       ),
//                                                       Row(
//                                                         children: [
//                                                           Text(
//                                                             myList?[index]['Charge'] + "/hr",
//                                                             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//                                                           ),
//                                                           SizedBox(
//                                                             width: 50,
//                                                           ),
//                                                           Container(
//                                                             decoration: BoxDecoration(border: Border.all(color: (myList?[index]['Availability'] == '0') ? Colors.red : Colors.green), borderRadius: BorderRadius.circular(20)),
//                                                             child: Padding(
//                                                               padding: const EdgeInsets.all(5.0),
//                                                               child: Text(
//                                                                 myList?[index]['Availability'] + " Available",
//                                                                 style: TextStyle(color: (myList?[index]['Availability'] == '0') ? Colors.red : Colors.green, fontWeight: FontWeight.w500),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             color: Colors.white,
//                                             elevation: 5,
//                                           )),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             );
//                         }
//                       })
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
