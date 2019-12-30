import 'package:flutter/material.dart';

import 'compass.dart';

void main() => runApp(Compass());

class Compass extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "Compass",
        theme: ThemeData(brightness: Brightness.dark),
        darkTheme: ThemeData.dark(),
        home: Scaffold(
            appBar: AppBar(
              title: Text("Compass"),
            ),
            backgroundColor: Colors.black,
            body: CompassWidget()),
      );
}
