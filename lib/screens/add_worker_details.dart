// ignore_for_file: missing_return, prefer_final_fields, must_call_super, avoid_unnecessary_containers, sized_box_for_whitespace, deprecated_member_use, prefer_const_constructors, avoid_print, unnecessary_new, unused_element

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:looking_for_me/database/product.dart';




class AddWorkerDetails extends StatefulWidget {
  const AddWorkerDetails({ Key? key }) : super(key: key);

  @override
  _AddWorkerDetailsState createState() => _AddWorkerDetailsState();
}

class _AddWorkerDetailsState extends State<AddWorkerDetails> {

   ProductService productService = ProductService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController quatityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
   TextEditingController locationController = TextEditingController();
  final priceController = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
 
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;
  List<String> selectedSizes = <String>[];
  

  File? _image1;
  bool isLoading = false;

  Future pickImage(Widget widget) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => _image1 = imageTemporary);
    } on PlatformException catch (e) {
      print('Faild to pick image: $e');
    }
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: white,
        leading: Icon(
          Icons.close,
          color: black,
        ),
        title: Text(
          "add User detials",
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: isLoading
              ? const CircularProgressIndicator()
              : Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 120,
                              child: OutlineButton(
                                  borderSide: BorderSide(
                                      color: grey.withOpacity(0.5), width: 2.5),
                                  onPressed: () {
                                    pickImage(_image1 != null
                                        ? Image.file(
                                            _image1!,
                                          )
                                        : _displayChild1());
                                  },
                                  child: _displayChild1()),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Enter your details',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: red, fontSize: 12),
                      ),
                    ),

                 
                        

                    Text('Available Jobs'),

                    Row(
                      children: <Widget>[
                        Checkbox(
                            value: selectedSizes.contains('Plumber'),
                            onChanged: (value) => changeSelectedSize('Plumber')),
                        Text('Plumber'),
                        Checkbox(
                            value: selectedSizes.contains('Electrician'),
                            onChanged: (value) => changeSelectedSize('Electrician')),
                            Text('Electrician'),
                      
                      ],
                    ),
                    
                    Row(
                      children: <Widget>[
                       
                        Checkbox(
                            value: selectedSizes.contains('HouseKeeper'),
                            onChanged: (value) => changeSelectedSize('HouseKeeper')),
                        Text('HouseKeeper'),
                        Checkbox(
                            value: selectedSizes.contains('Janitor'),
                            onChanged: (value) => changeSelectedSize('Janitor')),
                        Text('JanitorL'),
                        Checkbox(
                            value: selectedSizes.contains('Carpenter'),
                            onChanged: (value) => changeSelectedSize('Carpenter')),
                        Text('Carpenter'),
                      ],
                    ),

                   
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: productNameController,
                        decoration: InputDecoration(hintText: 'User Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Name';
                          } else if (value.length > 20) {
                            return 'Product name cant have more than 10 letters';
                          }
                        },
                      ),
                    ),

                      
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: locationController,
                        decoration: InputDecoration(hintText: 'User location'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your location';
                          } 
                        },
                      ),
                    ),

                     Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: phoneController,
                      //  keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'User phone Number',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'phoneNumber';
                          }
                        },
                      ),
                    ),

                    FlatButton(
                      color: red,
                      textColor: white,
                      child: Text('add Details'),
                      onPressed: () {
                        validateAndUpload();
                      },
                    )
                  ],
                ),
                  
        ),
      
      ),
    );
  }





  void changeSelectedSize(String size) {
    if (selectedSizes.contains(size)) {
      setState(() {
        selectedSizes.remove(size);
      });
    } else {
      setState(() {
        selectedSizes.insert(0, size);
      });
    }
  }

  void _selectImage(Future<File> pickImage) async {
    File tempImg = await pickImage;
    setState(() => _image1 = tempImg);
  }

  Widget _displayChild1() {
    if (_image1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _image1!,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  void validateAndUpload() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      if (_image1 != null) {
        if (selectedSizes.isNotEmpty) {
          String imageUrl1;

          final FirebaseStorage storage = FirebaseStorage.instance;
          final String picture1 =
              "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          UploadTask task1 = storage.ref().child(picture1).putFile(_image1!);

          TaskSnapshot snapshot1 = await task1.then((snapshot) => snapshot);

          task1.then((snapshot3) async {
            imageUrl1 = await snapshot1.ref.getDownloadURL();

            productService.uploadProduct({
              "name": productNameController.text,
              "location": locationController.text,
              
              "job": selectedSizes,
            
              "picture": imageUrl1,
              "phoneNo": phoneController.text,
              
             
            });
            _formKey.currentState!.reset();
            setState(() => isLoading = false);
            Navigator.pop(context);
          });
        } else {
          setState(() => isLoading = false);
        }
      } else {
        setState(() => isLoading = false);

//        Fluttertoast.showToast(msg: 'all the images must be provided');
      }
    }
  }
}
