import 'package:assigment/auth/login.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:assigment/db/DatabaseHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io' as i;

import 'package:image_picker/image_picker.dart';

class registration extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return registrationPage();
  }
}

class registrationPage extends State<registration> {
  var picPath, name, email, ph, pass;
  i.File _image;
  final picker = ImagePicker();

  Future getImagefromGallary() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _image = i.File(pickedImage.path);
        picPath = pickedImage.path;
      } else {
        print("Error");
      }
    });
  }

  var nameCon = TextEditingController();
  var emailCon = TextEditingController();
  var phCon = TextEditingController();
  var passCon = TextEditingController();
  var checkPassCon = TextEditingController();
  void add(
      String name, String email, String pass, String ph, String imgPath) async {
    Map<String, dynamic> reg = {
      "name": name,
      "email": email,
      "pass": pass,
      "ph": ph,
      "img": imgPath
    };
    var db = DatabaseHelper();
    var i = db.insert(reg);
    if (i != null) {
      Fluttertoast.showToast(msg: "Registration Succesfull");

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => login()));
    } else {
      Fluttertoast.showToast(msg: "Registration Failed. Try Again");
    }
  }

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
                    image: AssetImage("lib/assets/registration.png"),
                    fit: BoxFit.fill)),
            child: SingleChildScrollView(
                child: Column(children: [
              Container(
                  margin:
                      EdgeInsets.fromLTRB(0, height * 0.1, 0, height * 0.05),
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(width * 0.2, 0, 0, 0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.verified_user,
                            size: 50,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Demo Assigment",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ))),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, height * 0.1),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(width * 0.1, 0, 0, 0),
                    child: Text(
                      "Register Yourself",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )),
              InkWell(
                child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, height * 0.01),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(width * 0.03, 0, 0, 0),
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white),
                          child: _image == null
                              ? Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                )
                              : Image.file(
                                  _image,
                                  height: 80,
                                  width: 80,
                                ),
                        ))),
                onTap: getImagefromGallary,
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  "Click on Camera Icon to add Picture",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              Container(
                  width: width * 0.8,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, height * 0.01),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(width * 0.1, 0, 0, 0),
                    child: TextField(
                      controller: nameCon,
                      decoration: InputDecoration(hintText: "Enter Your Name"),
                    ),
                  )),
              Container(
                  width: width * 0.8,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, height * 0.01),
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(width * 0.1, 0, 0, 0),
                      child: TextField(
                        controller: emailCon,
                        decoration:
                            InputDecoration(hintText: "Enter Your Email"),
                      ))),
              Container(
                  width: width * 0.8,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, height * 0.01),
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(width * 0.1, 0, 0, 0),
                      child: TextField(
                          controller: passCon,
                          decoration:
                              InputDecoration(hintText: "Enter Password"),
                          obscureText: true))),
              Container(
                  width: width * 0.8,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, height * 0.01),
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(width * 0.1, 0, 0, 0),
                      child: TextField(
                        controller: checkPassCon,
                        decoration:
                            InputDecoration(hintText: "Confirm Password"),
                        obscureText: true,
                      ))),
              Container(
                  width: width * 0.8,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, height * 0.01),
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(width * 0.1, 0, 0, 0),
                      child: TextField(
                        controller: phCon,
                        decoration:
                            InputDecoration(hintText: "Enter Your number"),
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                      ))),
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
                                    name = nameCon.text;
                                    email = emailCon.text;
                                    ph = phCon.text;
                                    pass = passCon.text;

                                    if (ph.length != 10 || ph == null) {
                                      Fluttertoast.showToast(
                                          msg: "Enter valid Number");
                                    } else {
                                      if (pass != checkPassCon.text) {
                                        Fluttertoast.showToast(
                                            msg: "Confirm Password not match");
                                      } else {
                                        if (picPath == null) {
                                          Fluttertoast.showToast(
                                              msg: "Upload your Picture");
                                        } else {
                                          add(name, email, pass, ph, picPath);
                                        }
                                      }
                                    }
                                  },
                                  // id = nextDouble(min: 1000, max: 9999);

                                  child: Text("Register")),
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
                    "Already Registered ? Click Here to Login",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => login()));
                },
              ))
            ]))));
  }

  nextDouble({int min, int max}) {
    return min + Random().nextInt(max - min + 1);
  }
}
