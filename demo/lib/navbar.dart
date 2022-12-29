import 'package:demo/Edituserprofile.dart';
import 'package:demo/HomePage.dart';
import 'package:demo/receipes/favoriterecipes.dart';
import 'package:demo/receipes/receipeform.dart';
import 'package:demo/receipes/useruploadedreceipes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class navbar extends StatefulWidget {
  // const navbar({Key? key}) : super(key: key);
  String UserId;
  navbar(this.UserId);

  @override
  State<navbar> createState() => _navbarState();
}

// ignore: camel_case_types
class _navbarState extends State<navbar> {
  final Padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 30);

  // String get UserId => widget.UserId;

  @override
  Widget build(BuildContext context) {
    // print("${widget.UserId}");
    return Drawer(//A Material Design panel that slides in horizontally from the edge of a Scaffold to show navigation links in an application.
      child: Material(
        color: Color.fromARGB(255, 195, 155, 254),
        child: ListView(
          padding: Padding,
          children: <Widget>[
            const SizedBox(height: 20),
            buildMenuItem(
              text: "signed in as\n${widget.UserId}",
              icon: Icons.verified_user_outlined,
            ),
            const Divider(color: Colors.white),
            const SizedBox(height: 60),
            
            buildMenuItem(
              text: 'Home',
              icon: Icons.home,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePage("${widget.UserId}"))),
            ),
            const SizedBox(height: 10),
            buildMenuItem(
              text: 'User Profile',
              icon: Icons.person,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => edituserprofile("${widget.UserId}"))),
            ),
            
            const SizedBox(height: 10),
            buildMenuItem(
              text: 'Favorite Recipes',
              icon: Icons.favorite,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Favorites("${widget.UserId}"))),
            ),

            const SizedBox(height: 10),
            buildMenuItem(
              text: 'Upload New Receipes',
              icon: Icons.food_bank_rounded,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => receipeform("${widget.UserId}"))),
            ),
            const SizedBox(height: 10),
            buildMenuItem(
              text: 'User Uploaded Receipes',
              icon: Icons.receipt_long_rounded,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => useruploadedreceipes("${widget.UserId}"))),
            ),
            
            const SizedBox(height: 10),
            Divider(color: Colors.white),
          ],
        ),
      ),
    );
  }
}

Widget buildMenuItem({
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
}) {
  // ignore: prefer_const_declarations
  final color = Colors.white;
  // ignore: prefer_const_declarations
  final hoverColor = Colors.white70;

  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(text, style: TextStyle(color: color)),
    hoverColor: hoverColor,
    onTap: onClicked,
  );
}

// selectedItem(BuildContext context, int index) {
//   Navigator.of(context).pop();
//   switch (index) {
//     case 0:
//       // print("${widget.userId}");
//       Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => edituserprofile("${widget.UserId}")));
//       break;

//     case 1:
//       Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => showuserreceipes("${widget.UserId}")));
//       break;

//     case 2:
//       Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => receipeform("${widget.UserId}")));
//       break;
//     case 3:
//       Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => HomePage("${widget.UserId}")));
//   }
//   // ));
// }
