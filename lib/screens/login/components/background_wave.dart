import 'package:flutter/material.dart';

class BackgroundWaveWidget extends StatelessWidget {
  final double radius;
  final double topSpace;
  final Size size;

  const BackgroundWaveWidget({Key? key, required this.radius, required this.topSpace, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BackgroundWavePainter(radius, topSpace, size, context),
    );
  }
}

class BackgroundWavePainter extends CustomPainter {
  final double radius;
  final double topSpace;
  final Size mSize;
  final BuildContext context;

  BackgroundWavePainter(this.radius, this.topSpace, this.mSize, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Theme.of(context).splashColor;

    Path path = Path();

    path.moveTo(0, topSpace);
    path.quadraticBezierTo(radius * 0.1, topSpace + radius * 0.9, radius, topSpace + radius);
    path.lineTo(mSize.width - radius, topSpace + radius);
    path.quadraticBezierTo(mSize.width - (radius * 0.1), topSpace + radius + (radius * 0.1), mSize.width, topSpace + radius * 2);
    path.lineTo(mSize.width, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
