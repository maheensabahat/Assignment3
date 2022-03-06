import 'main.dart';
import 'package:flutter/material.dart';

class cart extends StatefulWidget {
  final Function(List<dish>) listUpdated;
  final List<dish> dlist;

  cart({Key? key, required this.dlist, required this.listUpdated})
      : super(key: key);

  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<cart> {
  List<dish> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = widget.dlist;
  }

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
                  Icons.shopping_cart,
                  color: Color(0xffF2B138),
                  size: 32.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8, 36, 0, 0),
                child: Text(
                  "Cart",
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
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Container(
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
                      child: list[index].isAdded
                          ? ListTile(
                              title: Text(
                                list[index].name,
                                style: const TextStyle(
                                  color: Color(0xff003f63),
                                ),
                              ),
                              subtitle: Text(
                                list[index].price,
                                style: const TextStyle(
                                  color: Color(0xb5003f63),
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              trailing: GestureDetector(
                                onTap: () async {
                                  bool change = true;
                                  if (list[index].isAdded) {
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
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    },
                                                    child: Text('Yes')),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    child: Text('No')),
                                              ],
                                            ));
                                  }
                                  if (change) {
                                    list[index].isAdded = !list[index].isAdded;
                                  }
                                  ;
                                  setState(() {});
                                  widget.listUpdated(list);
                                },
                                child: Icon(
                                  list[index].isAdded
                                      ? Icons.remove_circle
                                      : Icons.add_circle,
                                  color: Color(0xff003f63),
                                ),
                              ),
                            )
                          : null);
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Icon(
          Icons.dining,
          color: Color(0xff003f63),
        ),
      ),
    );
    ;
  }
}
