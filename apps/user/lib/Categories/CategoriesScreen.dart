/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mwafer/Coupons/CouponsScreen.dart';
import 'package:mwafer/data_base/Cat_database.dart';

import '../HomePage.dart';
import 'CategoriesProducts.dart';



class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  CATDatabse _databse = CATDatabse();
  String CATID = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الفئات" , style: GoogleFonts.athiti(
            color: Color(0xff02ab94),
            fontSize: 20,
            fontWeight: FontWeight.bold),),
        centerTitle: true,
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
      body: FutureBuilder<List<DocumentSnapshot>>(
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
              return GridView.builder(
                itemCount: data.data.length,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 0.9),
                itemBuilder: (context,index)
                {
                  return InkWell(
                    onTap: ()  {
                      setState(()
                      {
                        CATID = data.data[index].documentID;

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>  CouponScreen(CATID,)));
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top:10,right:4,left:4),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          width: 125,
                          child: ListTile(
                            onTap:()
                            {
                              setState(()
                              {
                                CATID = data.data[index].documentID;
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>  CouponScreen(CATID)));
                              });
                            },
                            title: Image.network(data.data[index]["imgurl"],height: 90,width: 150,fit: BoxFit.fill,),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child:  Container(
                                  width: 150,child: Text(data.data[index]["category"],textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize:data.data[index]['category'].length >12 ? 13: 16),  maxLines: 2,
                                overflow: TextOverflow.ellipsis,)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },

              );
            }
            return Container(child: Center(child: CircularProgressIndicator()));
          }
      ),
    );
  }
}
*/
