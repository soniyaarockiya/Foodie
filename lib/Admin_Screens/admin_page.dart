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

//Firestore db = Firestore.instance;
//StorageReference storageReference;
//
//CollectionReference collectionReference = db.collection("Journal");

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
      print("sample image got : $sampleImage");
    } catch (e) {
      print('Error: $e');
    }
  }

  Future upload() async {
    try {
      StorageReference filepath = FirebaseStorage.instance
          .ref()
          .child("item_images")
          .child("Images${TimeOfDay.now()}");

      StorageUploadTask uploadTask = filepath.putFile(sampleImage);
      await uploadTask.onComplete;
      print("Image uploaded ");
      //todo: add a toast or something to show successfull upload
      //todo: onsuccess, onfailure, on complete actions can also be added

      await filepath.getDownloadURL().then((fileUrl) async {
        setState(() {
          _uploadImageUrl = fileUrl;
          print("upload url got at : $_uploadImageUrl");
        });
      });


      try {
        print("${itemNameController.text}");
        print("${itemPriceController.text}");

        await Firestore.instance.collection("items").document().setData(
            {'name': itemNameController.text,
              'price': itemPriceController.text,
              'image': _uploadImageUrl});

        //ItemModel itemModel = new ItemModel();
//        var itemModel = ItemModel.items();

//       DocumentReference df =  collectionReference.document();
//
//
//       await df.setData({
//
//       'itemName':itemNameController.text,
//         'itemPrice': itemPriceController.text       });


//          collectionReference.document().setData({
//          'itemName':itemNameController.text,
//          'itemPrice': itemPriceController.text
//          //'itemImage': _uploadImageUrl
//        });

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
                      //onSaved: (value) => itemName.toString(),
                      decoration:
                      InputDecoration(labelText: "Enter the name of the item"),
                    ),
                    TextFormField(
                      //keyboardType: TextInputType.number,
                      controller: itemPriceController,
                      //onSaved: (value) => price.toString(),
                      decoration: InputDecoration(
                        labelText: "Enter the item price",
                      ),
                    ),
                    RaisedButton(
                      onPressed: upload,
                      child: Text('Upload to database'),
                    )
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
