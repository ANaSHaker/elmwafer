import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomDialog extends StatelessWidget {
  final String title, description;
  final IconData icon;
  final ElevatedButton btn;

  CustomDialog(
      {@required this.title,
        @required this.description,
        @required this.icon,
      this.btn});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 66.0 + 16.0,
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
          ),
          margin: EdgeInsets.only(top: 66.0),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[900] : Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16.0),

              ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 16.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style:GoogleFonts.cairo(
                    textStyle: TextStyle(
                      fontSize: 16
                    )),
              ),
              SizedBox(height: 24.0),
              Container(
                  height: 40,
                  child: btn)

            ],
          ),
        ),
        Positioned(
          left: 16.0,
          right: 16.0,
          child: Align(
            child: CircleAvatar(
              radius: 66.0,
              backgroundColor:  Theme.of(context).brightness == Brightness.dark
                  ?Colors.grey.shade800 :Colors.grey[300],
              child: Icon(icon),
            ),
          ),
        ),
      ],
    );
  }
}