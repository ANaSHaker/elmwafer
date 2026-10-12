
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:launch_review/launch_review.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'custom_dialog.dart';

_launchWhatsApp() async {
  // Support number is injected at build time: --dart-define=SUPPORT_WHATSAPP=9665XXXXXXXX
  const String phoneNumber = String.fromEnvironment('SUPPORT_WHATSAPP');
  String message = 'السلام عليكم';
  var whatsappUrl = "whatsapp://send?phone=$phoneNumber&text=$message";
  if (await canLaunch(whatsappUrl)) {
    await launch(whatsappUrl);
  } else {
    throw 'Could not launch $whatsappUrl';
  }
}

Future launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: true, forceWebView: true);
  } else {
    print("Can't Launch $url");
  }
}

class HomeScreenDrawer extends StatefulWidget {
  const HomeScreenDrawer({
    Key key,
  }) : super(key: key);

  @override
  _HomeScreenDrawerState createState() => _HomeScreenDrawerState();
}

class _HomeScreenDrawerState extends State<HomeScreenDrawer> {


  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeProvider>(context);

    return Drawer(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    image: AssetImage("assets/logo.jpg"),
                    fit: BoxFit.fill)
            ),
          ),
          ListTile(
              title: Text(
                Theme.of(context).brightness == Brightness.dark ?  "الوضع النهاري" : "الوضع الليلي",
                textAlign: TextAlign.right,
                style:GoogleFonts.cairo(
                    textStyle: TextStyle(
                      fontSize: 16
                    )),
              ),
              trailing: Icon(
                Icons.color_lens,

              ),
              leading: Switch(
                value: themeChange.darkTheme,
                onChanged: (value) {
                  setState(() {
                    themeChange.darkTheme = value;
                  });
                },
              )),
          ListTile(
            trailing: Icon(Icons.share),
            title: Text(
              "مشاركة التطبيق",
              style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                      fontSize: 16
                  )),
              textAlign: TextAlign.right,
            ),
            onTap: () async {
              Share.share(
                  "شاهد هذا التطبيق حيث ستجد عليه العديد من الكوبونات والعروض , If you love the app please review the app on playstore and share it with your friends. https://play.google.com/store/apps/details?id=com.offer.mwafer");

            },
          ),
          ListTile(
            trailing: Icon(Icons.stars),
            title: Text(
              "تقييم التطبيق",
              style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                      fontSize: 16
                  )),              textAlign: TextAlign.right,

            ),
            onTap: () async {
              LaunchReview.launch();

            },
          ),

          ListTile(
            trailing: Icon(Icons.info),
            title: Text(
              "عن التطبيق",
              style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                      fontSize: 16
                  )),              textAlign: TextAlign.right,
            ),
            onTap: () async {
              showDialog(context: context, builder: (BuildContext context) => CustomDialog(
                title: 'عن التطبيق',
                description: 'تطبيق مخصص لعرض أخر العروض والكوبونات لتحقيق أفضل تجربة أثناء التسوق .',
               icon: Icons.info,
              ));

            },
          ),
          ListTile(
            trailing: Icon(Icons.category),
            title: Text(
              "اضف كوبوناتك معنا",
              style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                      fontSize: 16
                  )),              textAlign: TextAlign.right,
            ),
            onTap: () async {
              showDialog(context: context, builder: (BuildContext context) => CustomDialog(
                title: 'اضف كوبوناتك معنا',
                description: 'في حال كان لديك كوبون وتريد عرضه علي تطبيقنا لكسب الأرباح منه . لا تتردد بالتواصل معنا',
                icon: Icons.privacy_tip,
                btn: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary:Color(0xff02ab94)),

                child: Text("تواصل معنا"),
                  onPressed: _launchWhatsApp,
                ),
              ));

            },
          ),

        ],
      ),
    );
  }


  }


class ThemePreference {
  static const THEME_STATUS = 'THEME_STATUS';

  void setTheme(bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(THEME_STATUS) ?? false;
  }
}

class ThemeProvider with ChangeNotifier{
  bool _darkTheme = false;
  ThemePreference preference = ThemePreference();

  //getter
  bool get darkTheme => _darkTheme;

  //setter
  set darkTheme(bool value) {
    _darkTheme = value;
    preference.setTheme(value);
    notifyListeners();
  }
}