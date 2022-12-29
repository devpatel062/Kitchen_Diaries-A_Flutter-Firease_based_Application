// ignore_for_file: unnecessary_string_interpolations

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/SignUp.dart';
import 'package:demo/login_page.dart';
import 'package:demo/userreceipedetail.dart';
import 'package:demo/navbar.dart';
import 'package:demo/receipes/receipeform.dart';
import 'package:demo/receipeview.dart';
import 'package:demo/search.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Model.dart';
import 'package:clock/clock.dart';
import 'package:demo/search.dart';

class HomePage extends StatefulWidget {
  String userId;
  HomePage(this.userId);
  // const HomePage({Key? key , required String UserId}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Future getvalidationData() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   var obtainedemail = sharedPreferences.getString('email');
  //   setState(() {
  //     widget.finalemail = obtainedemail!;
  //   });
  // }

  bool isLoading = true;

  List<ReceipeModel> receipes = <ReceipeModel>[];

  String get userId => widget.userId; //to take value from string-widget->userId

  getreceipe(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=cac09239&app_key=2a0165b7a3909e97cc9cecf161d66653"; //Fetching recipes from API
    http.Response response = await http.get(Uri.parse(url));
    Map data = jsonDecode(response.body);

    data["hits"].forEach((element) {
      ReceipeModel receipeModel = new ReceipeModel();
      receipeModel = ReceipeModel.fromMap(element["recipe"]);
      receipes.add(receipeModel);

      setState(() {
        isLoading = false;
      });
      // log(receipes.toString());
    });

    receipes.forEach((receipes) {
      print(receipes.label);
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getreceipe("LADOO");
  }

  bool nothomepagebool = true;

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    /*A controller for an editable text field.Whenever the user modifies a text field with an associated TextEditingController, the text field updates value and the controller notifies its listeners. Listeners can then read the text and selection properties to learn what the user has typed or how the selection has been updated */
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      /*Implements the basic Material Design visual layout structure.This class provides APIs for showing drawers and bottom sheets.*/
      drawer: navbar(
          "${widget.userId}"), //A Material Design panel that slides in horizontally from the edge of a Scaffold to show navigation links in an application.
      appBar: AppBar(
        //App bars are typically used in the Scaffold.appBar property, which places the app bar as a fixed-height widget at the top of the screen.
        title: Text(
          "Kitchen Diaries",
          style: GoogleFonts.balooPaaji2(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 195, 155, 254),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                //Navigator helps us navigate to new route. Navigator.push() method is used to switch to a new route.
                context,
                MaterialPageRoute(
                  //MaterialPageRoute - A modal route that replaces the entire screen with a platform-adaptive transition. By default, when a modal route is replaced by another, the previous route remains in memory.
                  builder: (context) => receipeform(userId),
                ),
              );
            },
            icon: const Icon(Icons.food_bank_rounded),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                //Navigator helps us navigate to new route. Navigator.push() method is used to switch to a new route.
                context,
                MaterialPageRoute(
                  //MaterialPageRoute - A modal route that replaces the entire screen with a platform-adaptive transition. By default, when a modal route is replaced by another, the previous route remains in memory.
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            icon: const Icon(Icons.login),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          /*SingleChildScrollView - A box in which a single widget can be scrolled.
        This widget is useful when you have a single box that will normally be entirely visible,
         but you need to make sure it can be scrolled if the container gets too small in one axis
         (the scroll direction).It is also useful if you need to shrink-wrap in both axes
         (the main scrolling direction as well as the cross axis), as one might see in a dialog or pop-up menu.*/
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 195, 155, 254),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                        /*By default a GestureDetector with an invisible child ignores touches; this behavior can be controlled with behavior. Detects various gestures and events using the supplied MotionEvents. The OnGestureListener callback will notify users when a particular motion event has occurred.*/
                        onTap: () {
                          if ((searchController.text).replaceAll(" ", "") ==
                              "") {
                            print("Blank search");
                          } else {
                            // getreceipe(searchController.text);
                            Navigator.push(
                                //Navigator helps us navigate to new route. Navigator.push() method is used to switch to a new route.
                                context,
                                MaterialPageRoute(
                                  //MaterialPageRoute - A modal route that replaces the entire screen with a platform-adaptive transition. By default, when a modal route is replaced by another, the previous route remains in memory.
                                  builder: (context) => search(
                                      searchController.text,
                                      "${widget.userId}"),
                                ));
                          }
                        },
                        child: const Icon(Icons.search)),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: "Search Receipe",
                        border: InputBorder.none,
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Icon(
                      Icons.restaurant_menu,
                      size: 100,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Search the favourite receipe",
                      style: GoogleFonts.balooPaaji2(
                        fontSize: 15,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("You are Craving For . . .",
                        style: GoogleFonts.balooPaaji2(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(
                      height: 50,
                    ),
                  ])),
              SingleChildScrollView(
                /*SingleChildScrollView - A box in which a single widget can be scrolled.
              This widget is useful when you have a single box that will normally be entirely visible,
               but you need to make sure it can be scrolled if the container gets too small in one axis
               (the scroll direction).It is also useful if you need to shrink-wrap in both axes
               (the main scrolling direction as well as the cross axis), as one might see in a dialog or pop-up menu.*/
                child: Column(
                  children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("userreceipes")
                            // .doc("${widget.userId}").collection("ReceipeImage")
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (!snapshot.hasData) {
                            return (const Center(
                              child: Text("No Images "),
                            ));
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  QueryDocumentSnapshot x =
                                      snapshot.data!.docs[index];

                                  return Material(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            //Navigator helps us navigate to new route. Navigator.push() method is used to switch to a new route.
                                            context,
                                            MaterialPageRoute(
                                              //MaterialPageRoute - A modal route that replaces the entire screen with a platform-adaptive transition. By default, when a modal route is replaced by another, the previous route remains in memory.
                                              builder: (context) => details(
                                                  "${widget.userId}",
                                                  x["Receipe Name"],
                                                  false),
                                            ));
                                      },
                                      child: Card(
                                          margin: const EdgeInsets.all(20),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          elevation: 10.0,
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                /*A widget that clips its child using a rounded rectangle.
                                       By default, ClipRRect uses its own bounds as the base rectangle for the clip, but the size and location of the clip can be customized using a custom clipper.*/
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  x['Receipe Image'],
                                                  height: 300,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Positioned(
                                                right: 0,
                                                left: 0,
                                                bottom: 0,
                                                child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.black26,
                                                    ),
                                                    child: Text(
                                                      snapshot.data!.docs[index]
                                                          ['Receipe Name'],
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                      ),
                                                    )),
                                              ),
                                              Positioned(
                                                right: 0,
                                                height: 30,
                                                width: 80,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: const Color.fromARGB(
                                                        255, 255, 255, 255),
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                            Icons
                                                                .local_fire_department,
                                                            size: 20),
                                                        Text(
                                                          snapshot
                                                              .data!
                                                              .docs[index][
                                                                  'Receipe Calories']
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    0,
                                                                    0),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  left: 0,
                                                  top: 0,
                                                  height: 30,
                                                  width: 30,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      // color: Colors.white,
                                                    ),
                                                    child: Center(
                                                      child: IconButton(
                                                        icon: const Icon(
                                                            Icons.favorite),
                                                        onPressed: () {
                                                          addtofav(snapshot.data!.docs[index]['Receipe Name']);
                                                        },
                                                      ),
                                                    ),
                                                  ))
                                            ],
                                          )),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        }),
                    Container(
                      //A convenience widget that combines common painting, positioning, and sizing widgets.
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: receipes.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  // customBorder: RoundedRectangleBorder(
                                  //   borderRadius: BorderRadius.circular(20),
                                  // ),
                                  onTap: () {
                                    Navigator.push(
                                        //Navigator helps us navigate to new route. Navigator.push() method is used to switch to a new route.
                                        context,
                                        MaterialPageRoute(
                                          //MaterialPageRoute - A modal route that replaces the entire screen with a platform-adaptive transition. By default, when a modal route is replaced by another, the previous route remains in memory.
                                          builder: (context) =>
                                              receipeview(receipes[index].url),
                                        ));
                                  },
                                  child: Card(
                                    margin: const EdgeInsets.all(20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 0.0,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          /*A widget that clips its child using a rounded rectangle.
                                     By default, ClipRRect uses its own bounds as the base rectangle for the clip, but the size and location of the clip can be customized using a custom clipper.*/
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: 300,
                                              receipes[index].image),
                                        ),
                                        Positioned(
                                          right: 0,
                                          left: 0,
                                          bottom: 0,
                                          child: Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.black26,
                                              ),
                                              child: Text(
                                                receipes[index].label,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              )),
                                        ),
                                        Positioned(
                                          right: 0,
                                          height: 30,
                                          width: 80,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                      Icons
                                                          .local_fire_department,
                                                      size: 20),
                                                  Text(
                                                    receipes[index]
                                                        .calories
                                                        .toString()
                                                        .substring(0, 4),
                                                    style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            left: 0,
                                            top: 0,
                                            height: 30,
                                            width: 80,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                              ),
                                              child: Center(
                                                child: IconButton(
                                                  icon: Icon(Icons.star_border),
                                                  onPressed: () {},
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addtofav(String receipename) async {
    Map<String, dynamic> favs = {
      "receipe name": receipename,
    };

    FirebaseFirestore.instance
        .doc("${widget.userId}")
        .collection("recipe names")
        .add(favs);
    showSnackBar("Item added to Favorites", const Duration(seconds: 2));
  }

  removeformfav(String receipename) {
    FirebaseFirestore.instance
        .collection('user favorite recipes')
        .doc("${widget.userId}")
        .get()
        .then((value) {
      value.reference
          .collection("recipe names")
          .where("receipe name", isEqualTo: receipename)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          element.reference.delete();
        });
      });
    });
    showSnackBar("Item removed from Favorites", const Duration(seconds: 2));
  }

  showSnackBar(String message, Duration duration) {
    //Shows a SnackBar across all registered Scaffolds.A scaffold can show at most one snack bar at a time. If this function is called while another snack bar is already visible, the given snack bar will be added to a queue and displayed after the earlier snack bars have closed.
    final snackBar = SnackBar(content: Text(message), duration: duration);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
