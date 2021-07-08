import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'dart:io' as i;

String userName;
String userImgPath;
i.File _image;
List data;
int status = 0;
String jsonimg;
int len;

class second extends StatefulWidget {
  second(String name, String imgPath, List Data, int datalen) {
    userName = name;
    userImgPath = imgPath;
    _image = i.File(userImgPath);
    data = Data;
    len = datalen;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return secoundScreen();
  }
}

class secoundScreen extends State<second> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 4.0,
          brightness: Brightness.dark,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          leading: Builder(
            builder: (context) {
              return Icon(
                Icons.verified_user,
                size: 50,
              );
            },
          ),
          title: Text(
            userName,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 15),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white),
                  child: _image == null
                      ? Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Colors.blue,
                        )
                      : Image.file(_image),
                )),
            SizedBox(
              height: 50,
            )
          ],
        ),
        body: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          children: List.generate(len, (index) {
            var url = data[index]["download_url"].toString();

            return Container(
                height: 80,
                width: 80,
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Image.network(
                          url,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            return Center(
                              child: Text("Loding Image"),
                            );
                          },
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace st) {
                            return Center(
                              child: Image.asset(
                                "lib/assets/error.jpg",
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        data[index]["author"].toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ));
          }),
        ));
    //Container(
    //   height: height,
    //   width: width,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.only(
    //         topLeft: Radius.zero,
    //         topRight: Radius.zero,
    //         bottomLeft: Radius.circular(0),
    //         bottomRight: Radius.circular(0)),
    //   ),
    //   child: ListView(
    //     shrinkWrap: true,
    //     scrollDirection: Axis.vertical,
    //     children: [
    //       SizedBox(
    //         height: 10,
    //       ),
    //       Text("Click on the button to recive the data from server"),
    //       SizedBox(
    //         height: 10,
    //       ),
    //       ElevatedButton(
    //           style: ElevatedButton.styleFrom(
    //             primary: Colors.white70,
    //             onPrimary: Colors.blue,
    //             elevation: 10,
    //             shadowColor: Colors.blue,
    //             textStyle:
    //                 TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //             shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(50)),
    //           ),
    //           onPressed: () {
    //             getData();
    //           },
    //           child: Text("Get Data")),
    //       SizedBox(
    //         height: 10,
    //       ),
    //       // status == 200
    //       //     ? GridView.builder(
    //       //         itemCount: 3,
    //       //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       //             crossAxisCount: 1),
    //       //         itemBuilder: (ctx, index) {
    //       //           return Container(
    //       //             height: 100,
    //       //             width: width,
    //       //             decoration: BoxDecoration(color: Colors.black),
    //       //           );
    //       //         },
    //       //       )
    //       //     : Text("Click on Get Data to recive the data")
    //       SizedBox(
    //         height: 10,
    //       ),
    //       Text("I am Here"),
    //       SizedBox(
    //         height: 10,
    //       ),
    //       Container()
    //     ],
    //   ),
    // ));
  }
}
