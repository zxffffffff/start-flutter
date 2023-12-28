import 'package:flutter/material.dart';
import 'package:my_app/src/sample_feature/widgets/native_widget.dart';

/// Displays detailed information about a SampleItem.
class NativeView extends StatelessWidget {
  const NativeView({super.key});

  static const routeName = '/native_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NativeView'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "flutter Text",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Expanded(
                child: NativeWidget(
                    viewType: "<platform-view-type>", creationParams: {}))
          ],
        ),
      ),
    );
  }
}
