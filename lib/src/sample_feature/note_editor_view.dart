import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class NoteEditorView extends StatelessWidget {
  const NoteEditorView({super.key});

  static const routeName = '/NoteEditor_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NoteEditorView'),
      ),
      body: const Center(
        child: Text('NoteEditor_view'),
      ),
    );
  }
}
