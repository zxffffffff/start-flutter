import 'package:flutter/material.dart';
import 'package:note_editor/note_editor.dart';
import 'package:note_editor/note_toolbar.dart';

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
      body: Column(
        children: [
          NoteEditor(),
          NoteToolbar(),
        ],
      ),
    );
  }
}
