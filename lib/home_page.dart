import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbRef = FirebaseDatabase.instance.ref();
  int smokeValue = 0;

  @override
  void initState() {
    super.initState();
    dbRef.child("smokeValue").onValue.listen((event) {
      setState(() {
        smokeValue = event.snapshot.value as int;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSafe = smokeValue < 400;

    return Scaffold(
      appBar: AppBar(title: Text(" Smoke Monitor")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSafe ? Icons.cloud_done : Icons.warning_amber_rounded,
              size: 100,
              color: isSafe ? Colors.green : Colors.red,
            ),
            SizedBox(height: 20),
            Text(
              "Smoke Value: $smokeValue",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              isSafe ? " Air is Safe!" : " Smoke Detected!",
              style: TextStyle(fontSize: 24, color: isSafe ? Colors.green : Colors.red),
            ),
            SizedBox(height: 50),
            LinearProgressIndicator(
              value: (smokeValue / 1023).clamp(0.0, 1.0),
              minHeight: 20,
              backgroundColor: Colors.grey[300],
              color: isSafe ? Colors.green : Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
