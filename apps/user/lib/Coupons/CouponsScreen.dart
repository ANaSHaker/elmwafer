import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mwafer/Categories/CategoriesScreen.dart';
import 'package:mwafer/data_base/Cat_database.dart';
import 'package:mwafer/data_base/store_database.dart';
import 'package:mwafer/widget/animatedbutton.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../HomePage.dart';

class CouponScreen extends StatefulWidget {
  //String CATID;
  StoreDatabse _storeDatabse = StoreDatabse();

 /* CouponScreen(String id)
  {
    this.CATID = id;
  }*/
  @override
  _CouponScreenState createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  Firestore _firestore = Firestore.instance;
  StoreDatabse _dataBase = StoreDatabse();
  ScrollController controller = ScrollController();
  ScrollController controller2 = ScrollController();
  bool loading = false;
  bool closeTopContainer = false;
  CATDatabse _databse = CATDatabse();
  Color iconcolor = Colors.blueGrey;
  List<String> selectedproducts = [];
  bool tosearch = false;
  String CATID = "db2262f0-012e-11ec-a133-1bfb3e1f863c";



  Icon Iconsearch = Icon(Icons.search, color: Colors.blueGrey);
  Icon Iconclose = Icon(Icons.close, color: Colors.blueGrey);
  Widget Titletext =
  Text("All products", style: GoogleFonts.cairo(
      textStyle: TextStyle(
        fontWeight: FontWeight
            .bold,
      )),);

  bool allselected = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final key = GlobalKey();
  double numberc=1;
  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        closeTopContainer = controller.offset > 50;
        //print(controller.offset);
      });
    });
    controller2.addListener(() {
      setState(() {
        closeTopContainer = true;
      //  print(controller.offset);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    var padding=              Padding(
      padding: const EdgeInsets.only(right:20.0,left:20),
      child: TypeAheadField(
        hideSuggestionsOnKeyboardHide: false,
        keepSuggestionsOnLoading: false,


        textFieldConfiguration: TextFieldConfiguration(
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(

              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.greenAccent, width: 1.0),
                  borderRadius: BorderRadius.circular(15)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.greenAccent, width: 1.0),
                  borderRadius: BorderRadius.circular(15)),
              prefixIcon: Icon(
                Icons.search,
                color: Color(0xff02ab94).withOpacity(0.5),
              ),
              filled: true,
              hintText: "Search ",

              hintStyle: TextStyle(
                  color: Color(0xff02ab94).withOpacity(0.5))),
          autofocus: false,
        ),
        suggestionsCallback: (pattern) async {
          return await _dataBase.getSuggestions(pattern);
        },
        itemBuilder: (context, DocumentSnapshot suggestion) {
          return MyCard(
            img: suggestion['imgurl'],
            txt: suggestion['category'],
            catDes: suggestion['catDes'],
            categorie: suggestion['category'],
            docId: suggestion.documentID,
              copUrl: suggestion["copUrl"],
              couCode: suggestion["couCode"],
            click:suggestion["click"]

          );







        },
        onSuggestionSelected: (suggestion) async {
          if (suggestion == null) {
            _dataBase.getAllCAT();
          } else {
            String id = "";
            QuerySnapshot querytSnapshot = await _firestore
                .collection('CouponScreen')
                .where("category",
                isEqualTo: suggestion['category'])
                .getDocuments();
            DocumentSnapshot snapshot = querytSnapshot.documents[5];
            id = snapshot.documentID;
            //print(suggestion);
           // print(id);


          }
        },
      ),
    );

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "كوبونات الخصم",
            style: GoogleFonts.cairo(
                color: Color(0xff02ab94),
                fontSize: 20,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Color(0xff02ab94),
                size: 30,
              )),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [

              Container(
                height: 60,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children:
                  [

                    Expanded(
                      child: FutureBuilder<List<DocumentSnapshot>>(
                          future:_databse.getAllCAT() ,
                          builder: (context,data)
                          {
                            if(data.hasError)
                            {
                              return Center(
                                child: Text("Error at   ${data.error.toString()}"),
                              );
                            }
                            else if (data.hasData)
                            {
                            if(data.data.isNotEmpty) {
                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right:20.0,left: 4),
                                    child: Container(
                                      child: InkWell(
                                        hoverColor: Colors.transparent,
                                        focusColor: Colors.transparent,

                                        onTap: () {
                                          setState(() {
                                            CATID =
                                                data.data[index].documentID;
                                            print(CATID);
                                          });
                                        },
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              Text(data
                                                  .data[index]["category"],
                                                textAlign: TextAlign
                                                    .center,
                                                style: GoogleFonts.cairo(
                                                  textStyle: TextStyle(
                                                    fontWeight: FontWeight
                                                        .bold,
                                                   )),),
                                              SizedBox(width: 8,),
                                              Image.network(data
                                                  .data[index]["imgurl"],
                                                height: 35, width: 20,),
                                            ]
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: data.data.length,
                                scrollDirection: Axis.horizontal,
                              );
                            }   else
                            {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>
                                [
                                  Center(child:Text("No News for that category")),
                                ],
                              );
                            }
                            }
                            return Container(child: Center(child: CircularProgressIndicator()));
                          }
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Container(
                  height: 40,
                  child: padding),

              loading
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                    child: Container(
             height: MediaQuery.of(context).size.height-215,
                      child: FutureBuilder<List<DocumentSnapshot>>(
                          future:  widget._storeDatabse.getallproductCategory( CATID),
                          builder: (context, data) {
                            if (data.hasError) {
                              return Center(
                                child: Text(
                                    "Error at   ${data.error.toString()}"),
                              );
                            } else if (data.hasData) {
                              if(data.data.isNotEmpty)
                              {

                                return ListView.builder(
                                  key: key,
                                  itemCount: data.data.length,
                                  //  physics:PageScrollPhysics(),
                                  controller: controller,
                                  itemBuilder: (context, index) {
                                    return MyCard(
                                        img: data.data[index]["imgurl"],
                                        txt: data.data[index]["category"],
                                        docId: data.data[index].documentID,
                                        categorie: data.data[index]["category"],
                                        catDes: data.data[index]["catDes"],
                                        copUrl: data.data[index]["copUrl"],
                                        couCode: data.data[index]["couCode"],
                                        click:data.data[index]["click"]

                                    );
                                  },
                                );
                              }else
                              {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>
                                  [
                                    Center(child:Text("No Coupons for that category")),
                                  ],
                                );
                              }
                            }
                            return Container(
                                child: Center(
                                    child: CircularProgressIndicator()));
                          }),
                    ),
                  ),
            ],
          ),
        ));
  }
}

class MyCard extends StatefulWidget {
  final String img;
  final String txt;
  final String copUrl;
  final docId;
  final categorie;
  final catDes;
  final String couCode;
  final int click;

  const MyCard(
      {Key key, this.img, this.txt, this.docId, this.categorie, this.catDes, this.copUrl,this.couCode,this.click})
      : super(key: key);

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  //String CATID = "All";
  String code="";

  Future<String> getCode()async{
    QuerySnapshot querytSnapshot = await Firestore
        .instance
        .collection('coupons')
        .where("category",
        isEqualTo: widget.docId)
        .getDocuments().then((event) {
      if (event.documents.isNotEmpty) {
        Map<String, dynamic> documentData = event.documents.single.data; //if it is a single document
        code = documentData['price'];
      }
    }).catchError((e) => print("error fetching data: $e"));


   //  DocumentSnapshot snapshot = querytSnapshot
   //      .documents[0];
   //
   // code = snapshot['price'];

    return code;
  }

  @override
  Widget build(BuildContext context) {
    getCode();
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;




    return Container(
      height: height / 4.5,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.green[500],
          ),
          borderRadius: BorderRadius.all(Radius.circular(7))),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    //  width:width/2,
                    height:30,
                    child: AnimatedButton(
                      initialText: "انسخ الكود ",
                      onTap: () {
                          Firestore firestore = Firestore.instance;
                          firestore.collection("categories").document(widget.docId).updateData(
                            {
                              "click":widget.click + 1
                            }).whenComplete(() => {
                          FlutterClipboard.copy(widget.couCode.isNotEmpty?widget.couCode:"empty"),
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(widget.couCode.isNotEmpty?"تم نسخ الكود ":"لا يوجد كود"),
                            duration: Duration(seconds: 1),)),
                          });

                        // });
                      },
                      animationDuration: Duration(seconds: 1),
                      finalText
                      :widget.couCode,
                      iconData: Icons.done,
                      iconSize: 20,
                      buttonStyle: mButtonStyle(borderRadius: 0.0,
                          elevation: 0.0,
                          primaryColor: Color(0xff02ab94),
                          secondaryColor: Colors.white,
                          finalTextStyle: GoogleFonts.cairo(
                              textStyle: TextStyle(
                                fontWeight: FontWeight
                                    .bold,
                              )),),
                    ),
                  ),
                  IconButton(icon: Icon(Icons.share),onPressed: (){
                    setState(() {
                      Share.share("https://play.google.com/store/apps/details?id=com.currency.den كوبون جديد من ${widget.txt} لدينا بتطبيقنا وعليه خصم ${widget.catDes} حمل الان تطبيقنا");

                    });
                  },),
                  Container(
                    width: 120,
                    child: ClipRRect(
                      borderRadius:
                      BorderRadius.only(topRight: Radius.circular(7)),
                      child: Image.network(
                        widget.img,
                        fit: BoxFit.fill,
                        //  data.data[index]["imgurl"],
                        // width: 50,
                        // height: 130,
                      ),
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(color: Colors.green),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("عدد مرات الاستخدام",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                          textStyle: TextStyle(
                            fontWeight: FontWeight
                                .bold,
                          )),),
                    Text(widget.click.toString(),
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.cairo(
                            textStyle: TextStyle(
                              fontWeight: FontWeight
                                  .bold,
                            )),)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(widget.txt,
                        textAlign: TextAlign.center,
                        style:GoogleFonts.cairo(
                            textStyle: TextStyle(
                              fontWeight: FontWeight
                                  .bold,
                              fontSize: 18
                            )),),
                    Text(widget.catDes,
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      style:GoogleFonts.cairo(
                          textStyle: TextStyle(
                            fontWeight: FontWeight
                                .bold,
                              fontSize: 12

                          )),)
                  ],
                ),

              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  setState(() async {
                    var canLaunch2 = await canLaunch(widget.copUrl);
                    canLaunch2 == true ? launch(widget.copUrl) : ScaffoldMessenger
                        .of(context).showSnackBar(SnackBar(
                      content: Text("الرابط غير صحيح "),
                      duration: Duration(seconds: 1),));
                  });

                },
                child: new Container(
                  width: width / 2,
                  height: 20,
                  decoration: new BoxDecoration(
                    color: Color(0xff02ab94),
                    borderRadius: new BorderRadius.circular(7.0),
                  ),
                  child: new Center(
                    child: new Text(
                      'تسوق الان',
                      style:  GoogleFonts.cairo(
                          textStyle: TextStyle(
                            fontWeight: FontWeight
                                .bold,
                          )),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
