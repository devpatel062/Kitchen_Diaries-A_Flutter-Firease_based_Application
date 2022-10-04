import 'package:demo/Edituserprofile.dart';
import 'package:demo/HomePage.dart';
import 'package:demo/receipes/receipeform.dart';
import 'package:demo/receipes/showuserreceipes.dart';
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

class _navbarState extends State<navbar> {
  final Padding = EdgeInsets.symmetric(horizontal: 20, vertical: 30);

  // String get UserId => widget.UserId;

  @override
  Widget build(BuildContext context) {
    // print("${widget.UserId}");
    return Drawer(
      child: Material(
        color: Color.fromARGB(255, 195, 155, 254),
        child: ListView(
          padding: Padding,
          children: <Widget>[
            const SizedBox(height: 100),
            const SizedBox(height: 20),
            buildMenuItem(
              text: 'Home',
              icon: Icons.home,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePage("${widget.UserId}"))),
            ),
            const SizedBox(height: 20),
            buildMenuItem(
              text: 'User Profile',
              icon: Icons.man_rounded,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => edituserprofile("${widget.UserId}"))),
            ),
            const SizedBox(height: 20),
            buildMenuItem(
              text: 'User Receipes',
              icon: Icons.dining_sharp,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => showuserreceipes("${widget.UserId}"))),
            ),
            const SizedBox(height: 20),
            buildMenuItem(
              text: 'Upload New Receipes',
              icon: Icons.food_bank_rounded,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => receipeform("${widget.UserId}"))),
            ),
            const SizedBox(height: 20),
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
  final color = Colors.white;
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
