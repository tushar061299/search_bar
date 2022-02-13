import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ApiCard extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  ApiCard({
    required this.name,
    required this.gender,
    // required this.city,
    required this.location,
    // required this.state,
    // required this.number,
  });

  dynamic gender;
  String name;
  String location;
  // num number;
  // String city;
  // String state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            // ignore: prefer_const_constructors
            BoxShadow(
              color: Colors.grey.shade500,
              // ignore: prefer_const_constructors
              offset: Offset(4, 4),
              blurRadius: 10,
              spreadRadius: 1,
            ),
            // ignore: prefer_const_constructors
            BoxShadow(
              color: Colors.white38,
              // ignore: prefer_const_constructors
              offset: Offset(-4, -4),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      // ignore: prefer_const_constructors
                      offset: Offset(4, 4),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                    // ignore: prefer_const_constructors
                    BoxShadow(
                      color: Colors.white38,
                      // ignore: prefer_const_constructors
                      offset: Offset(-4, -4),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                height: 60,
                width: 60,
                // child: Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: Image.network(imageUrl),
                // ),
              ),
            ),
            Expanded(
              // ignore: avoid_unnecessary_containers
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        gender,
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Text(
                    //   gender,
                    //   style: TextStyle(
                    //     color: Colors.grey[900],
                    //     fontSize: 20,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    location,
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    location,
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
