import 'package:bookmyspot/Booking.dart';
import 'package:bookmyspot/PreebokStatus.dart';
import 'package:bookmyspot/Status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class BookParking extends StatefulWidget {
  String? place;
  String? address;
  BookParking({this.place, this.address});

  @override
  _BookParkingState createState() => _BookParkingState();
}

class _BookParkingState extends State<BookParking> {
  Color ThemeColor = Color(0x9abc0063);
  Color ThemeColorLight = Color(0x4abc0063);
  var outputFormat = DateFormat('dd/MM/yyyy');
  var outputDay;
  TimeOfDay? _startTime = TimeOfDay.now();
  TimeOfDay? _endTime = TimeOfDay.now();

  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      outputDay = outputFormat.format(today);
      print(today);
    });
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _startTime ?? TimeOfDay.now(),
    );
    if (newTime != null && newTime != _startTime) {
      setState(() {
        _startTime = newTime;
        _duration = _calculateDuration();
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _endTime ?? TimeOfDay.now(),
    );
    if (newTime != null && newTime != _endTime) {
      setState(() {
        _endTime = newTime;
        _duration = _calculateDuration();
      });
    }
  }

  Duration? _calculateDuration() {
    if (_startTime != null && _endTime != null) {
      final start = DateTime(2023, 1, 1, _startTime!.hour, _startTime!.minute);
      final end = DateTime(2023, 1, 1, _endTime!.hour, _endTime!.minute);
      return end.difference(start);
    }

    return null;
  }

  var Today;
  TimeOfDay selectedTime = TimeOfDay.now();
  Duration? _duration;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    outputDay = outputFormat.format(DateTime.now());
    selectedTime = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            "Book Parking Details",
            style: TextStyle(fontSize: 28, color: Colors.black),
          ),
        ),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 28.0, top: 10),
              child: Text(
                "Select Date",
                style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                elevation: 2,
                child: TableCalendar(
                  calendarStyle: CalendarStyle(todayDecoration: BoxDecoration(color: ThemeColorLight, shape: BoxShape.circle), isTodayHighlighted: true, selectedDecoration: BoxDecoration(color: ThemeColor, shape: BoxShape.circle)),
                  locale: "en_US",
                  rowHeight: 42,
                  availableGestures: AvailableGestures.all,
                  selectedDayPredicate: (day) => isSameDay(day, today),
                  onDaySelected: _onDaySelected,
                  headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true, decoration: BoxDecoration(borderRadius: BorderRadius.circular(20))),
                  focusedDay: DateTime.now(),
                  lastDay: DateTime(2050),
                  firstDay: DateTime.now(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, top: 10),
              child: Text(
                "Selected Date",
                style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, top: 5),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.25,
                decoration: BoxDecoration(color: ThemeColor, borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    outputDay,
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 28, right: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Start Hour", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black)),
                  SizedBox(
                    width: 75,
                  ),
                  Text(
                    "End Hour",
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 28, right: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => _selectStartTime(context),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.050,
                      decoration: BoxDecoration(color: ThemeColor, borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width * 0.30,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (_startTime == null)
                                ? Text(
                                    TimeOfDay.now().format(context).toString(),
                                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                                  )
                                : Text(
                                    _startTime!.format(context).toString(),
                                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                                  ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.access_time_filled,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  GestureDetector(
                    onTap: () => _selectEndTime(context),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.050,
                      decoration: BoxDecoration(color: ThemeColor, borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width * 0.30,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (_endTime == null)
                                ? Text(TimeOfDay.now().format(context).toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ))
                                : Text(
                                    _endTime!.format(context).toString(),
                                    style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white),
                                  ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.access_time_filled,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, top: 15),
              child: Text(
                "Total",
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28.0, top: 0),
              child: (_duration == null)
                  ? Text(
                      "₹ 0",
                      style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: ThemeColor),
                    )
                  : Text(
                      "₹ ${_duration!.inMinutes.toInt() * 1}",
                      style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: ThemeColor),
                    ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BookingStatus(
                        isPrebooking: true,
                        place: widget.place,
                        address: widget.address,
                        Amount: (_duration != null) ? _duration!.inMinutes.toInt() * 1 : 0,
                        selectedDate: today,
                        Duration: (_duration != null) ? _duration!.inHours.toInt() : 0,
                        //hours: (_startTime != null && _endTime != null) ? _startTime!.format(context).toString() + " - " + _endTime!.format(context).toString() : "unkonwn",
                        startTime: _startTime,
                        endTime: _endTime,
                      ))),
              child: Center(
                child: Container(
                  child: Center(
                    child: Text(
                      "Continue",
                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ThemeColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
