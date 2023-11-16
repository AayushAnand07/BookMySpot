import 'package:flutter/material.dart';

class Status extends StatefulWidget {
  const Status({Key? key}) : super(key: key);

  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.40, vertical: MediaQuery.of(context).size.width * 0.15),
        child: Column(
          children: [
            Divider(
              color: Colors.black,
              thickness: 5,
              height: 20,
            ),
            SizedBox(
              child: Center(
                child: Text(
                  "A1",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              height: 30,
            ),
            Divider(
              color: Colors.black,
              thickness: 5,
              height: 20,
            ),
            SizedBox(
              child: Center(
                child: Image.asset(
                  "assets/car.png",
                ),
              ),
              height: 30,
            ),
            Divider(
              color: Colors.black,
              thickness: 5,
              height: 20,
            ),
            SizedBox(
              child: Center(
                  child: Image.asset(
                "assets/car.png",
              )),
              height: 30,
            ),
            Divider(
              color: Colors.black,
              thickness: 5,
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Divider(
              color: Colors.black,
              thickness: 5,
              height: 20,
            ),
            SizedBox(
              child: Center(
                  child: Image.asset(
                "assets/car.png",
                height: 100,
              )),
              height: 30,
            ),
            Divider(
              color: Colors.black,
              thickness: 5,
              height: 20,
            ),
            SizedBox(
              child: Center(
                child: Text(
                  "A5",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              height: 30,
            ),
            Divider(
              color: Colors.black,
              thickness: 5,
              height: 20,
            ),
            SizedBox(
              child: Center(
                child: Text(
                  "A6",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              height: 30,
            ),
            Divider(
              color: Colors.black,
              thickness: 5,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
