import 'package:bookmyspot/Login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'AuthFunction.dart';

class Registeration extends StatefulWidget {
  const Registeration({Key? key}) : super(key: key);

  @override
  _RegisterationState createState() => _RegisterationState();
}

class _RegisterationState extends State<Registeration> {
  final _formKey = GlobalKey<FormState>();
  bool isPasswordHidden = false;
  String email = '';
  String name = '';
  String mob = '';
  String plate = '';
  String password = '';
  bool isloading = false;
  bool login = false;
  Color ThemeColor = Color(0xffBC0063);
  Color iconColor = Color(0xffA9A9A9);
  bool _isloading = false;
  Color formColor = Color(0xffD9D9D9);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: ThemeColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            color: Colors.white,
            Icons.arrow_back_ios_outlined,
          ),
        ),
        title: Center(
          child: Text(
            "Register Profile",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        style: TextStyle(color: ThemeColor),
                        cursorColor: ThemeColor,
                        key: ValueKey('Name'),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: ThemeColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide(color: ThemeColor, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide(color: ThemeColor, width: 2),
                            ),
                            hintText: 'Enter Your Name',
                            hintStyle: TextStyle(color: ThemeColor)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter valid Name';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          setState(() {
                            name = value!;
                          });
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        style: TextStyle(color: ThemeColor),
                        cursorColor: ThemeColor,
                        key: ValueKey('Mobile'),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.mobile_friendly,
                              color: ThemeColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide(color: ThemeColor, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide(color: ThemeColor, width: 2),
                            ),
                            hintText: 'Enter Your Mobile Number',
                            hintStyle: TextStyle(color: ThemeColor)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your mobile number';
                          } else {
                            // Define the regular expression for a valid mobile number
                            RegExp mobileRegex = new RegExp(r'^[0-9]{10}$');
                            if (!mobileRegex.hasMatch(value)) {
                              return 'Please enter a valid mobile number';
                            }
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            mob = value!;
                          });
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        style: TextStyle(color: ThemeColor),
                        cursorColor: ThemeColor,
                        key: ValueKey('Liscence'),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.add,
                              color: ThemeColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide(color: ThemeColor, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide(color: ThemeColor, width: 2),
                            ),
                            hintText: 'Add Your Number Plate ',
                            hintStyle: TextStyle(color: ThemeColor)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter valid Plate Number';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          setState(() {
                            plate = value!;
                          });
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        style: TextStyle(color: ThemeColor),
                        cursorColor: ThemeColor,
                        key: ValueKey('Email'),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: ThemeColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide(color: ThemeColor, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide(color: ThemeColor, width: 2),
                            ),
                            hintText: 'Enter Your Email',
                            hintStyle: TextStyle(color: ThemeColor)),
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Please Enter valid Email';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          setState(() {
                            email = value!;
                          });
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      // ======== Password ========
                      TextFormField(
                        style: TextStyle(color: ThemeColor),
                        cursorColor: ThemeColor,
                        key: ValueKey('password'),
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: ThemeColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide(color: ThemeColor, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide(color: ThemeColor, width: 2),
                            ),
                            hintText: 'Password',
                            hintStyle: GoogleFonts.poppins(color: ThemeColor),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPasswordHidden = !isPasswordHidden;
                                  });
                                },
                                child: Icon(
                                  isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                                  color: ThemeColor,
                                ))),
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Please Enter Password of min length 6';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          setState(() {
                            password = value!;
                          });
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      _isloading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                              backgroundColor: ThemeColor,
                            )
                          : Container(
                              height: 55,
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      //Color(0xffF3CE39)
                                      backgroundColor: MaterialStateProperty.all(ThemeColor),
                                      elevation: MaterialStateProperty.all<double>(10),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                      ))),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _isloading = true;
                                      _formKey.currentState!.save();

                                      AuthServices.signupUser(email, password, name, mob, plate, context);
                                    }
                                  },
                                  child: Text(
                                    'SignUp',
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  )),
                            ),
                      Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
