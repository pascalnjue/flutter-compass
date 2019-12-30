import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

class CompassWidget extends StatefulWidget {
  CompassWidget({Key key}) : super(key: key);

  @override
  _CompassState createState() => _CompassState();
}

class _CompassState extends State<CompassWidget> {
  double _heading = 0;

  String get _readout => _heading.toStringAsFixed(0) + "deg";

  @override
  void initState() {
    super.initState();
    FlutterCompass.events.listen(_onData);
  }

  void _onData(double x) =>
      setState(() {
        _heading = x;
      });

  final TextStyle _style = TextStyle(
    color: Colors.red[50].withOpacity(0.9),
    fontSize: 32,
    fontWeight: FontWeight.w200,
  );

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: CompassPainter(angle: _heading),
      child: Center(child: Text(_readout, style: _style)),
    );
  }
}


class CompassPainter extends CustomPainter {
  CompassPainter({@required this.angle}) : super();

  final double angle;
  double get rotation => -2 * pi * (angle/360);

  Paint get _brush => new Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

  @override
  void paint(Canvas canvas, Size size) {

    Paint circle = _brush
        ..color = Colors.indigo[400].withOpacity(0.6);

    Paint needle = _brush
        ..color = Colors.red[400];

    double radius = min(size.width / 2.2, size.height / 2.2);
    Offset center = Offset(size.width / 2, size.height / 2);
    Offset start = Offset.lerp(Offset(center.dx, radius), center, .4);
    Offset end = Offset.lerp(Offset(center.dx, radius), center, .1);

    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawLine(start, end, needle);
    canvas.drawCircle(center, radius, circle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
