import 'package:flutter/cupertino.dart';

class InverseCurvedEdge extends CustomClipper<Path> {
  final double scale = 24;
  final double round = 36;

  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height);

    final firstCurve = Offset(0, size.height - scale);
    final lastCurve = Offset(round, size.height - scale);
    path.quadraticBezierTo(firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy);

    final secondFirstCurve = Offset(0, size.height - scale);
    final secondLastCurve = Offset(size.width - round, size.height - scale);
    path.quadraticBezierTo(secondFirstCurve.dx, secondFirstCurve.dy, secondLastCurve.dx, secondLastCurve.dy);

    final thirdFirstCurve = Offset(size.width, size.height - scale);
    final thirdLastCurve = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdFirstCurve.dx, thirdFirstCurve.dy, thirdLastCurve.dx, thirdLastCurve.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}