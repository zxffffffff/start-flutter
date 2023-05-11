import 'package:flutter/material.dart';

class PainterView extends StatefulWidget {
  const PainterView({super.key});
  @override
  State<PainterView> createState() => _PainterViewState();

  static const routeName = '/painter_view';
}

class _PainterViewState extends State<PainterView> {
  PointerEvent? _event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PainterView'),
      ),
      body: Center(
        child: Listener(
          child: CustomPaint(
            size: const Size(300, 300),
            painter: MyPainter(_event != null
                ? _event!.localPosition
                : const Offset(150, 150)),
          ),
          onPointerDown: (PointerDownEvent event) =>
              setState(() => _event = event),
          onPointerMove: (PointerMoveEvent event) =>
              setState(() => _event = event),
          onPointerUp: (PointerUpEvent event) => setState(() => _event = event),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  MyPainter(this.cursor);
  Offset cursor;

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    var paint = Paint()
      ..isAntiAlias = true
      ..color = const Color(0xffff0000);
    canvas.drawRect(rect, paint);
    canvas.drawLine(cursor, rect.topLeft, paint);
    canvas.drawLine(cursor, rect.topRight, paint);
    canvas.drawLine(cursor, rect.bottomLeft, paint);
    canvas.drawLine(cursor, rect.bottomRight, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
