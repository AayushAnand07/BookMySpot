import 'package:bookmyspot/AuthFunction.dart';
import 'package:bookmyspot/Registeration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//import 'package:flutterapp/services/functions/authFunctions.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool isPasswordHidden = false;
  String email = '';
  String password = '';
  bool isloading = false;
  bool login = false;
  Color ThemeColor = Color(0xffBC0063);
  Color iconColor = Color(0xffA9A9A9);
  Color formColor = Color(0xffD9D9D9);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isloading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(170, 39, 98, 1),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 55.0),
              child: Text(style: GoogleFonts.poppins(fontSize: 40, color: Colors.white, fontWeight: FontWeight.w500), "BookMySpot"),
            ),
            Image(
              image: AssetImage("assets/caranimation.gif"),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 14, top: 28),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            cursorColor: Colors.black,
                            key: ValueKey('email'),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: formColor,
                              prefixIcon: Icon(
                                Icons.person,
                                color: iconColor,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(color: formColor, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(color: Colors.black, width: 2),
                              ),
                              hintText: 'Email',
                              hintStyle: GoogleFonts.poppins(textStyle: TextStyle(color: iconColor)),
                              iconColor: Color(0xffF3CE39),
                            ),
                            //
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
                            cursorColor: Colors.black,
                            key: ValueKey('password'),
                            obscureText: true,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: formColor,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: iconColor,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(color: formColor, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  borderSide: BorderSide(color: formColor, width: 2),
                                ),
                                hintText: 'Password',
                                hintStyle: GoogleFonts.poppins(color: iconColor),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isPasswordHidden = !isPasswordHidden;
                                      });
                                    },
                                    child: Icon(
                                      isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                                      color: iconColor,
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
                          isloading
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
                                          isloading = true;
                                          _formKey.currentState!.save();

                                          AuthServices.signinUser(email, password, context);
                                        }
                                      },
                                      child: Text(
                                        'Login',
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      )),
                                ),

                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Dont have an account?",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                TextButton(
                  child: Text(
                    "SingUp",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.yellow),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Registeration(),
                      ),
                    );
                  },
                )
              ],
            ),
          ],
        ));
  }
}
