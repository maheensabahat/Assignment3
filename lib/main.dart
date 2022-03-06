import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Color(0xffD9D9D9),
      ),
      home: const MyHomePage(title: 'Assignment 2'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static List<dish> Dlist = [
    dish(name: "Neapolitan pizza", price: "Rs. 800", isAdded: false),
    dish(name: "Ravioli", price: "Rs. 900", isAdded: false),
    dish(name: "Lasagna", price: "Rs. 1200", isAdded: false),
    dish(name: "Caprese salad", price: "Rs. 500", isAdded: false),
    dish(name: "Tiramisu", price: "Rs. 700", isAdded: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Contact List title
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(24, 36, 0, 0),
                child: Icon(
                  Icons.dining,
                  color: Color(0xffF2B138),
                  size: 32.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8, 36, 0, 0),
                child: Text(
                  "Menu",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff003f63),
                  ),
                ),
              ),
            ],
          ),

          //List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(24.0),
              itemCount: Dlist.length,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(
                    left: 0, right: 0, top: 0, bottom: 16),
                decoration: BoxDecoration(
                    color: Color(0xffA1A5A6),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: Offset(4, 4),
                      )
                    ]),
                child: ListTile(
                  title: Text(
                    Dlist[index].name,
                    style: const TextStyle(
                      color: Color(0xff003f63),
                    ),
                  ),
                  subtitle: Text(
                    Dlist[index].price,
                    style: const TextStyle(
                      color: Color(0xb5003f63),
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () async {
                      bool change = true;
                      if (Dlist[index].isAdded) {
                        change = await showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('Are you sure?'),
                                  content: const Text(
                                      'This will remove this item from cart.'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                        child: Text('Yes')),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                        child: Text('No')),
                                  ],
                                ));
                      }
                      if (change) {
                        Dlist[index].isAdded = !Dlist[index].isAdded;
                      }
                      ;
                      setState(() {});
                    },
                    child: Icon(
                      Dlist[index].isAdded
                          ? Icons.remove_circle
                          : Icons.add_circle,
                      color: Color(0xff003f63),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // List<dish> cartt = makeCart();
          // print(cartt);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => cart(
              dlist: Dlist,
              listUpdated: (value) {
                Dlist = value;
                setState(() {});
              },
            ),
          ));
        },
        child: const Icon(
          Icons.shopping_cart,
          color: Color(0xff003f63),
        ),
      ),
    );
  }
}

class dish {
  final String name;
  final String price;
  bool isAdded;

  dish({required this.name, required this.price, required this.isAdded});

  @override
  String toString() {
    // TODO: implement toString
    return name + " " + isAdded.toString();
  }
}
