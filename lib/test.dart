// import 'dart:io';
import 'dart:io';
import 'dart:math';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:image_picker/image_picker.dart';

class Jeep extends StatefulWidget {
  @override
  _JeepState createState() => _JeepState();
}

class _JeepState extends State<Jeep> {
  var _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isError = false;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  File _image1;
  TextEditingController _productTitleController = TextEditingController();
  TextEditingController _productDescriptionController = TextEditingController();
  TextEditingController _productPriceController = TextEditingController();
  TextEditingController _productKmew = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _productDescriptionController.dispose();
    _productPriceController.dispose();
    _productTitleController.dispose();
    _productKmew.dispose();
  }
  var body = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'اضافه طلب',

          ),
          leading: IconButton(icon: Icon(Icons.keyboard_arrow_left,color: Colors.yellow.shade700,size: 35,), onPressed:(){
            Navigator.pop(context);
          }),
        ),
        body: ( isLoading ) ? _loading() : _chald()
    );
  }
  Widget _loading(){
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<String> uploadImage(File image) async {
    String name = Random().nextInt(1000).toString() + '_product';
    final StorageReference storageReference =
    FirebaseStorage().ref().child(name);
    final StorageUploadTask uploadTask = storageReference.putFile(image);
    StorageTaskSnapshot response = await uploadTask.onComplete;
    String url = await response.ref.getDownloadURL();
    return url;
  }
  Widget _image() {
    return Align(
      child: SizedBox(
        height: 150.0,
        child: new ListView.builder(
            itemCount: 1,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return new Container(
                alignment: Alignment.center,
                padding: new EdgeInsets.only(left: 3.0,),
                child: new Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    new Container(
                      alignment: Alignment.center,
                      width: 150.0,
                      height: 150.0,
                      decoration: new BoxDecoration(
                          color: Colors.grey.withAlpha(100),
                          borderRadius:
                          new BorderRadius.all(new Radius.circular(15.0)),
                          image: new DecorationImage(
                              fit: BoxFit.cover, image: new FileImage(_image1))),
                    ),

                  ],
                ),
              );
            }),
      ),
    );
  }
  Widget _chald(){
    return Container(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 10, bottom: 5),
                alignment: Alignment.centerRight,
                child: Text(
                  "اسم الجرار",style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey),

                ),
              ),
              Container(
                child: TextFormField(
                    textDirection: TextDirection.rtl,
                    controller: _productTitleController,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.amber,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'لطفا ادخل العنوان';
                      }
                      return null;
                    }),
              ),
              SizedBox(height: 30,),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text("الموقع",
                    style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey),)),
              SizedBox(height: 5,),
              Container(
                child: TextFormField(
                    textDirection: TextDirection.rtl,
                    controller: _productPriceController,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.amber,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'لطفا ادخل العنوان';
                      }
                      return null;
                    }),
              ),
              SizedBox(height: 30,),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text("السعر",
                    style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey),)),
              SizedBox(height: 5,),
              Container(
                child: TextFormField(
                    textDirection: TextDirection.rtl,
                    controller: _productKmew,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.amber,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'لطفا ادخل معرف الخدمة';
                      }
                      return null;
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(right: 10, bottom: 5),
                alignment: Alignment.centerRight,
                child: Text(
                  "اضافه رابط الواتساب",
                  style: TextStyle(
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey),
                ),
              ),
              Container(
                child: TextFormField(
                    maxLines: 5,
                    textDirection: TextDirection.rtl,
                    controller: _productDescriptionController,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.amber,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'لطفا ادخل الوصف';
                      }
                      return null;
                    }),
              ),
              SizedBox(
                height: 30,
              ),
              (_image1 != null
                  ? _image()
                  : Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: <Widget>[
                      Text("اضافة صوره",style: TextStyle(
                          fontFamily: ArabicFonts.Cairo,
                          package: 'google_fonts_arabic',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey),),
                      SizedBox(height: 5,),
                      DottedBorder(
                        borderType: BorderType.Rect,
                        color: Colors.grey,
                        strokeWidth: 2,
                        child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          width: 60,
                          child: IconButton(
                            icon: Icon(Icons.add_circle),
                            onPressed: () async {
                              var image = await ImagePicker.pickImage(
                                  source: ImageSource.gallery);
                              setState(() {
                                _image1 = image;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ))),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
              ),
              SizedBox(
                height: 32,
              ),
              SizedBox(
                height: 32,
              ),
              MaterialButton(

                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width*0.5,
                  height: MediaQuery.of(context).size.height*0.06,
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade900,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    'اضاقة',
                    style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
                onPressed: () async {
                  if( _formKey.currentState.validate() ){
                    setState(() {
                      isLoading = true;
                    });
                    String imageUrl1;

                    if (_image1 != null) {
                      imageUrl1 = await uploadImage(_image1);
                    }
                    String images = imageUrl1;
                    var map = {
                      'product_title': _productTitleController.text,
                      'product_description':
                      _productDescriptionController.text,
                      'products_price':_productPriceController.text,
                      "products_knew":_productKmew.text
                    };
                    if (_image1 != null) {
                      map['images'] = images;
                    }
                    var response = await Firestore.instance.collection('categorie').snapshots().first;
                    if( response.documents.length >= 1000 ){
                      setState(() {
                        isLoading = false;
                        isError = true;
                      });
                    }else{
                      Firestore.instance.collection('jeep').document() .setData(map).then(( onValue ){
                      });
                      setState(() {
                        isLoading = false;
                        isError = false;
                      });
                      Navigator.pop(context);
                    }
                  }
                },
              ),
              SizedBox(
                height: 32,
              ),
              SizedBox(
                width: double.infinity,
                child: (isError)
                    ? Text(
                  'Error Slecting Category',
                  style: TextStyle(color: Colors.red),
                )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _error(){
    return Container(
      child: Center(
        child: Text('Error, duplicate entry' , style: TextStyle(color: Colors.red),),
      ),
    );
  }
}
//() async {
//                  if (_formKey.currentState.validate()) {
//                    String imageUrl1;
//
//                    if (_image1 != null) {
//                      imageUrl1 = await uploadImage(_image1);
//                    }
//                    String images = imageUrl1;
//                    var map = {
//                      'product_title': _productTitleController.text,
//                      'product_description':
//                      _productDescriptionController.text,
//                    };
//                    if (_image1 != null) {
//                      map['images'] = images;
//                    }
//                    await Firestore.instance
//                        .collection('HomeScreenAdd')
//                        .document()
//                        .setData(map)
//                        .then((_) {
//                      Navigator.pop(context);
//                    });
//                  }
//                },