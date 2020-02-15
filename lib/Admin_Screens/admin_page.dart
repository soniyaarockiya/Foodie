import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String price;
String itemName;
String _uploadImageUrl;
File sampleImage;

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();

  Future getImage() async {
    try {
      var img = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        sampleImage = img;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future upload() async {
    try {
      //add image to storage
      StorageReference filepath = FirebaseStorage.instance
          .ref()
          .child("item_images")
          .child("Images${TimeOfDay.now()}");

      StorageUploadTask uploadTask = filepath.putFile(sampleImage);
      await uploadTask.onComplete;
      print("Image uploaded ");

      //get image storage link to save it in the collection
      await filepath.getDownloadURL().then((fileUrl) async {
        setState(() {
          _uploadImageUrl = fileUrl;
        });
      });

      //upload the item to db
      try {
        await Firestore.instance.collection("items").document().setData({
          'name': itemNameController.text,
          'price': itemPriceController.text,
          'image': _uploadImageUrl
        });

        print(("Added to db succesffully"));
      } catch (e) {
        print("Error while uploading item details : $e");
      }
    } catch (e) {
      print("Error while uploading image to firebase : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            sampleImage = null;
          },
        ),
        title: Text('Hey Admin'),
      ),
      body: Builder(
        builder: (context) =>
            Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      child: SizedBox(
                        height: 200.0,
                        width: 200.0,
                        child: sampleImage == null
                            ? Text("No Image")
                            : Image(image: FileImage(sampleImage)),
                      ),
                    ),
                    IconButton(
                        onPressed: getImage,
                        icon: Icon(
                          Icons.camera_alt,
                        )),
                    TextFormField(
                      controller: itemNameController,
                      decoration:
                      InputDecoration(labelText: "Enter the name of the item"),
                    ),
                    TextFormField(
                      controller: itemPriceController,
                      decoration: InputDecoration(
                        labelText: "Enter the item price",
                      ),
                    ),
                    RaisedButton(
                      onPressed: upload,
                      child: Text('Upload to database'),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
