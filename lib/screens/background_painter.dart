import 'dart:math';
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';
import 'package:job_finder/config/Palette.dart';

class BackgroundPainter extends CustomPainter {
  BackgroundPainter({Animation<double> animation})
      : firstPaint = Paint()
          ..color = Palette.navyBlue
          ..style = PaintingStyle.fill,
        secPaint = Paint()
          ..color = Palette.darkCornflowerBlue
          ..style = PaintingStyle.fill,
        thirdPaint = Paint()
          ..color = Palette.starCommandBlue
          ..style = PaintingStyle.fill,
        forthPaint = Paint()
          ..color = Palette.blueGreen
          ..style = PaintingStyle.fill,
        fifthPaint = Paint()
          ..color = Palette.ceayola
          ..style = PaintingStyle.fill;

  final Paint firstPaint;
  final Paint secPaint;
  final Paint thirdPaint;
  final Paint forthPaint;
  final Paint fifthPaint;
  @override
  void paint(Canvas canvas, Size size) {
    paintFirst(canvas, size);
    paintSec(canvas, size);
    paintThird(canvas, size);
    paintForth(canvas, size);
    paintFifth(canvas, size);
  }

  void paintFirst(Canvas canvas, Size size) {
    final double x = size.width / 8;
    final double d = size.height / 3;
    final double y = size.height / 32;
    final path = Path();
    path.moveTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    _addPointsToPath(path, [
      Point(0, d),
      Point(0, d),
      Point(x, d + y),
      Point(2 * x, d - y),
      Point(3 * x, d + y),
      Point(4 * x, d - y),
      Point(5 * x, d + y),
      Point(6 * x, d - y),
      Point(7 * x, d + y),
      Point(8 * x, d - y),
      Point(size.width+x, d),
    ]);

    canvas.drawPath(path, firstPaint);
  }

  void paintSec(Canvas canvas, Size size) {
    final double x = size.width / 8;
    final double d = size.height / 3.5;
    final double y = size.height / 32;
    final path = Path();
    path.moveTo(size.width, d);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    _addPointsToPath(path, [
      Point(0, d),
      Point(0, d),
      Point(x, d + y),
      Point(2 * x, d - y),
      Point(3 * x, d + y),
      Point(4 * x, d - y),
      Point(5 * x, d + y),
      Point(6 * x, d - y),
      Point(7 * x, d + y),
      Point(8 * x, d - y),
      Point(size.width+x, d),
    ]);
    canvas.drawPath(path, secPaint);
  }

  void paintThird(Canvas canvas, Size size) {
    final double x = size.width / 8;
    final double d = size.height / 4.5;
    final double y = size.height / 32;
    final path = Path();
    path.moveTo(size.width, d);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    _addPointsToPath(path, [
      Point(0, d),
      Point(0, d),
      Point(x, d + y),
      Point(2 * x, d - y),
      Point(3 * x, d + y),
      Point(4 * x, d - y),
      Point(5 * x, d + y),
      Point(6 * x, d - y),
      Point(7 * x, d + y),
      Point(8 * x, d - y),
      Point(size.width+x, d),
    ]);
    canvas.drawPath(path, thirdPaint);
  }

  void paintForth(Canvas canvas, Size size) {
    final double x = size.width / 8;
    final double d = size.height / 6;
    final double y = size.height / 32;
    final path = Path();
    path.moveTo(size.width, d);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    _addPointsToPath(path, [
      Point(0, d),
      Point(0, d),
      Point(x, d + y),
      Point(2 * x, d - y),
      Point(3 * x, d + y),
      Point(4 * x, d - y),
      Point(5 * x, d + y),
      Point(6 * x, d - y),
      Point(7 * x, d + y),
      Point(8 * x, d - y),
      Point(size.width+x, d),
    ]);
    canvas.drawPath(path, forthPaint);
  }

  void paintFifth(Canvas canvas, Size size) {
    final double x = size.width / 8;
    final double d = size.height / 8;
    final double y = size.height / 32;
    final path = Path();
    path.moveTo(size.width, d);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    _addPointsToPath(path, [
      Point(0, d),
      Point(0, d),
      Point(x, d + y),
      Point(2 * x, d - y),
      Point(3 * x, d + y),
      Point(4 * x, d - y),
      Point(5 * x, d + y),
      Point(6 * x, d - y),
      Point(7 * x, d + y),
      Point(8 * x, d - y),
      Point(size.width+x, d),
    ]);
    canvas.drawPath(path, fifthPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  // This is the math responsible of creating a path from points by joining them
  // https://stackoverflow.com/questions/7054272/how-to-draw-smooth-curve-through-n-points-using-javascript-html5-canvas
  void _addPointsToPath(Path path, List<Point> points) {
    if (points.length < 3) {
      throw UnsupportedError('Need more than 3 points to create a path');
    }

    for (int i = 0; i < points.length - 2; i++) {
      final xc = (points[i].x + points[i + 1].x) / 2;
      final yc = (points[i].y + points[i + 1].y) / 2;
      path.quadraticBezierTo(points[i].x, points[i].y, xc, yc);
    }

    // we need to connect the last 2 points
    path.quadraticBezierTo(
        points[points.length - 2].x,
        points[points.length - 2].y,
        points[points.length - 1].x,
        points[points.length - 1].y);
  }
}

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);
}

// Custom Curve with spring Effect
class SpringCurve extends Curve {
  const SpringCurve({
    this.a = 0.15,
    this.w = 19.4,
  });
  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return (-(pow(e, -t / a) * cos(t * w)) + 1).toDouble();
  }
}
