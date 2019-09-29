import 'dart:io';
import 'package:face_detection_app/screens.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';

void main()=>runApp(
  MaterialApp(
    title: 'Face Regonisation',
    home: Home(),
  )
);

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<File> getImage() async{
    return ImagePicker.pickImage(source: ImageSource.gallery);
  }

  List<Face> faceListEntities;
  List<Barcode> barcodes;
  List<ImageLabel> labels;
  VisionText visionText;
  final FaceDetector faceDetector = FirebaseVision.instance.faceDetector();
  final BarcodeDetector barcodeDetector = FirebaseVision.instance.barcodeDetector();
  final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
  final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();

  void detectFace()async{
    File imageFile = await getImage();
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
    faceListEntities = await faceDetector.processImage(visionImage);
    print(faceListEntities);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Facedata(data: faceListEntities, imageFile: imageFile,).build(context)));
  }
  void scanBarCode()async{
    File imageFile = await getImage();
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
    barcodes = await barcodeDetector.detectInImage(visionImage);
    print(barcodes);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>BarcodeScreen(data: barcodes, imageFile: imageFile,)));
  }
  
  void textRecog()async{
    File imageFile = await getImage();
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
    visionText = await textRecognizer.processImage(visionImage);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>GetText(data: visionText.blocks, imageFile: imageFile,).build(context)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ML Kit"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50.0,),
            Text("Hands on ML Kit", style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 50.0,),
            Center(
              child: RaisedButton(
                onPressed: (){
                  detectFace();
                },
                child: Text("Detect Face"),
              ),
            ),
            Center(
              child: RaisedButton(
                onPressed: (){
                  scanBarCode();
                },
                child: Text("Scan BarCode"),
              ),
            ),
            Center(
              child: RaisedButton(
                onPressed: (){
                  textRecog();
                },
                child: Text("Text Recog"),
              ),
            ),
          ],
        )
      ),
    );
  }
}

