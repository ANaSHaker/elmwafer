import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:mwafer/data_base/Cat_database.dart';
import 'package:mwafer/data_base/product_database.dart';

class CategoryProduct extends StatefulWidget
{
  ProductDatabase _productDatabase = ProductDatabase();
  String CATID;
  CategoryProduct(String id)
  {
    this.CATID = id;
  }
  @override
  _CategoryProductState createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct>
{

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories", style: GoogleFonts.lobster(
          fontSize: 26,
        ),),
        centerTitle: true,
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: widget._productDatabase.getallproductCategory( widget.CATID),
        builder:(context,data)
        {
          if(data.hasData)
          {
            if(data.data.isNotEmpty)
            {
              return  GridView.builder(
                  itemCount: data.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: 1.7),

                  itemBuilder: (BuildContext context, int index)
                  {
                    return ProductItem(data.data[index]);
                  });
            }
            else
            {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>
                [

                  Center(child:Text("No product for that category yet",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                  SizedBox(height: 200,)

                ],
              );
            }
          }
          else if(data.hasError)
          {
            return Center(child: Text("Error at ${data.error.toString()}"),);
          }
          return  Container(

            child: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
//******************************************************************************
// class of product Item
class ProductItem extends StatelessWidget
{
  CATDatabse _CATDatabase = CATDatabse();

  final DocumentSnapshot _documentSnapshot;
  ProductItem(this._documentSnapshot);
  @override
  Widget build(BuildContext context)
  {

    return   InkWell(
      onTap: ()
      {
     //   Navigator.of(context).push(new MaterialPageRoute(builder: (context) => ProductDetails(_documentSnapshot)));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10, top: 4),
        child: Column(
          children: [
            /* Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _documentSnapshot['name'],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),*/
            ConstrainedBox(
                constraints: new BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * .25,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: Stack(
                  children: [
                    Hero(tag: _documentSnapshot['name'],
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                _documentSnapshot["images url"][0],
                              ),
                              fit: BoxFit.cover,

                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.8),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(5, 7), // changes position of shadow
                              ),
                            ],
                            color: Colors.white70),
                      ),
                    ),
                    Positioned(
                      bottom: 28,
                      right: 12,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.withOpacity(.7)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _documentSnapshot['name'].toString(),
                            style: GoogleFonts.cairo(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight
                                      .bold,
                                )),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 5,
                        left: 2,
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * .75,

                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FutureBuilder<DocumentSnapshot>(
                                  future: _CATDatabase.getCAT(_documentSnapshot["category"],),
                                  builder: (context, snapshot)
                                  {
                                    if (snapshot.hasData)
                                    {
                                      return ListTile(
                                        title: Text(snapshot.data["category"],
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.athiti(
                                            color: Colors.white,
                                            fontSize: 17,shadows: [Shadow(
                                            blurRadius: 10,
                                          )],
                                            fontWeight: FontWeight.w700,
                                          ),),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text("Error please try later");
                                    }
                                    return Text("loading ....");
                                  },
                                ),
                              ),
                            ),
                          ],
                        ))
                  ],
                )


            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width-150 ,
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}