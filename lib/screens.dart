import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';

class BarcodeScreen extends StatelessWidget {
  final List<Barcode> data;
  final File imageFile;
  BarcodeScreen({@required this.data, @required this.imageFile});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Barcode Detector"),
        ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, i) {
          return Card(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20.0),
                  height: 400.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: FileImage(imageFile),
                    fit: BoxFit.fitHeight,
                  )),
                ),
                Text("Type : " + data[i].valueType.toString()),
                Text("Raw Value : " + data[i].rawValue),
                Text("Bounding Points : " + data[i].boundingBox.toString()),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Facedata extends StatelessWidget {
  final List<Face> data;
  final File imageFile;
  Facedata({@required this.data, @required this.imageFile});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Face Recog"),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, i) {
          return Card(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20.0),
                  height: 400.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: FileImage(imageFile),
                    fit: BoxFit.fitHeight,
                  )),
                ),
                Text("Rotation Y : " + data[i].headEulerAngleY.toString()),
                Text("Rotation Z : " + data[i].headEulerAngleZ.toString()),
                Text("Left Eye Open Probability : " +
                    data[i].leftEyeOpenProbability.toString()),
                Text("Right Eye Open Probability : " +
                    data[i].rightEyeOpenProbability.toString()),
              ],
            ),
          );
        },
      ),
    );
  }
}

class GetText extends StatelessWidget {
  final List<TextBlock> data;
  final File imageFile;
  GetText({@required this.data, @required this.imageFile});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Text Recog"),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
              Container(
                          margin: EdgeInsets.all(20.0),
                          height: 400.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: FileImage(imageFile),
                            fit: BoxFit.fitHeight,
                          )),
                        ),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: data.length,
                itemBuilder: (context, i) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        Text("Text : " + data[i].text.toString()),
                        Text("Languages : " + data[i].recognizedLanguages.toString()),
                      ],
                    ),
                  );
                },
              ),
            ],
          )],
        ));
  }
}
