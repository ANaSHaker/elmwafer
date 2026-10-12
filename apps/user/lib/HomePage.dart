import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Categories/CategoriesScreen.dart';
import 'Coupons/CouponsScreen.dart';
import 'Offers/offers_screen.dart';
import 'widget/home_screen_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: HomeScreenDrawer(),
      appBar: AppBar(
        centerTitle: true,
        shape: Cuvedshape(),

        title: Text("وفر قريشاتك",
            style: GoogleFonts.cairo(
                textStyle: TextStyle(
                  fontWeight: FontWeight
                      .bold,
                  fontSize: 20
                )),),

        elevation: 10,
        backgroundColor: Color(0xff02ab94),
      ),
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CouponScreen()));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.36,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(

                      children: [
                        Image.asset(
                          "assets/intro3.png",
                          width: 200,
                        ),
                        Text(
                          "كوبونات الخصم",
                          style: GoogleFonts.cairo(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Offers()));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.36,
                  width: MediaQuery.of(context).size.width * 0.91,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/intro2.png",
                          width: 200,
                        ),
                        Text(
                          "العروض",
                          style: GoogleFonts.cairo(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Cuvedshape extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) => Path()
    ..lineTo(0, rect.size.height)
    ..quadraticBezierTo(rect.size.width / 2, rect.size.height + 35 * 2,
        rect.size.width, rect.size.height)
    ..lineTo(rect.size.width, 0)
    ..close();
}
