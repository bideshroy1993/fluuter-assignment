import 'package:assigment/auth/registration.dart';
import 'package:assigment/db/DatabaseHelper.dart';
import 'package:assigment/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return loginPage();
  }
}

class loginPage extends State<login> {
  var email, pass, session;

  var emailCon = TextEditingController();
  var passCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.zero,
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0)),
              image: DecorationImage(
                  image: AssetImage("lib/assets/login.png"), fit: BoxFit.fill)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, height * 0.2, 0, 0),
                    child: Icon(
                      Icons.verified_user,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin:
                        EdgeInsets.fromLTRB(0, height * 0.01, 0, height * 0.1),
                    child: Text(
                      "Demo Assigment",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                    margin:
                        EdgeInsets.fromLTRB(0, height * 0.01, 0, height * 0.1),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(width * 0.3, 0, 0, 0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.supervised_user_circle,
                              size: 30,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Log In",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ))),
                Padding(
                  padding: EdgeInsets.fromLTRB(width * 0.2, 0, width * 0.2, 0),
                  child: Container(
                    height: 80,
                    width: width * 0.6,
                    child: TextField(
                      controller: emailCon,
                      decoration: InputDecoration(
                        hintText: "Enter Register Email",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(width * 0.2, 0, width * 0.2, 0),
                  child: Container(
                    height: 80,
                    width: width * 0.6,
                    child: TextField(
                      controller: passCon,
                      decoration: InputDecoration(
                        hintText: "Enter your Password",
                      ),
                      obscureText: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 80,
                    width: width * 0.8,
                    child: Center(
                      child: Row(
                        children: [
                          SizedBox(width: width * 0.2),
                          Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Container(
                                height: 30,
                                width: width * 0.3,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white70,
                                      onPrimary: Colors.blue,
                                      elevation: 10,
                                      shadowColor: Colors.blue,
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                                    onPressed: () {
                                      email = emailCon.text;
                                      pass = passCon.text;
                                      var db = DatabaseHelper();

                                      if (email == null || pass == null) {
                                        Fluttertoast.showToast(
                                            msg: "Enter Email and Password");
                                      } else {
                                        db.getLogin(email, pass, context);
                                      }
                                    },
                                    child: Text("Log In")),
                              )),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: InkWell(
                  child: Container(
                    height: 30,
                    width: width * 0.4,
                    child: Text(
                      "New User ? Click Here to Create Account",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => registration()));
                  },
                ))
              ],
            ),
          )),
    );
  }
}
