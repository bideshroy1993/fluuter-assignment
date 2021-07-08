import 'dart:convert';

import 'package:assigment/screens/second.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' as i;
import 'package:http/http.dart';

int userId;
String userName;
String userEmail;
String userPh;
String userImgPath;
i.File _image;
List data;
int status = 0;
String jsonimg;
var url;
int resLenth;

class home extends StatefulWidget {
  home(res) {
    userId = res[0]["id"];
    userName = res[0]["name"];
    userEmail = res[0]["email"];
    userPh = res[0]["ph"];
    userImgPath = res[0]["img"];
    _image = i.File(userImgPath);
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return homePage();
  }
}

class homePage extends State<home> {
  Position currentLocation;
  String lat;
  String lng;
  Future<Position> _detectPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(
          msg: "Please Keep Your Location On.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(
            msg: "Permission Access Denied",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg: "Permission Access Denied",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      lat = position.latitude.toString();
      lng = position.longitude.toString();
    });
  }

  Set<Marker> _marker = {};
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _marker.add(Marker(
          markerId: MarkerId('id-1'),
          position: LatLng(double.parse(lat), double.parse(lng)),
          infoWindow: InfoWindow(
              title: "Your Current Location",
              snippet: "App Getting Location")));
    });
  }

  getData() async {
    var url = Uri.parse('https://picsum.photos/v2/list');
    Response response = await get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Data Recived from server");
      data = jsonDecode(response.body);
      // jsonimg = data[0]["url"];
      resLenth = data.length;
      print(data.length);
      setState() {
        status = 200;
      }
    } else {
      Fluttertoast.showToast(msg: "Something Went Wrong");
    }
  }

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
        body: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.zero,
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0)),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                    height: height * 0.5,
                    width: width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blue,
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                              offset: Offset(2.0, 2.0)),
                        ]),
                    child: lng != null
                        ? GoogleMap(
                            mapType: MapType.normal,
                            onMapCreated: _onMapCreated,
                            markers: _marker,
                            initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    double.parse(lat), double.parse(lng)),
                                zoom: 20),
                          )
                        : Center(
                            child: Text(
                            "No Location Selected",
                            style: TextStyle(fontSize: 20),
                          ))),
                SizedBox(
                  height: 10,
                ),
                lat != null
                    ? Text("Lat:" + lat + " Lng:" + lng)
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white70,
                          onPrimary: Colors.blue,
                          elevation: 10,
                          shadowColor: Colors.blue,
                          textStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        onPressed: () {
                          _detectPosition();
                        },
                        child: Text("Get Position")),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Padding(
                  padding:
                      EdgeInsets.fromLTRB(0, height * 0.01, 0, height * 0.1),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white70,
                        onPrimary: Colors.blue,
                        elevation: 10,
                        shadowColor: Colors.blue,
                        textStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      onPressed: () {
                        getData();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                second(userName, userImgPath, data, resLenth)));
                      },
                      child: Text("Second Page ")),
                ))
              ],
            )));
  }
}
