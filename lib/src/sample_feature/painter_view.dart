import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class PainterView extends StatelessWidget {
  const PainterView({super.key});

  static const routeName = '/painter_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PainterView'),
      ),
      body: const Center(
        child: Text('painter_view'),
      ),
    );
  }
}
