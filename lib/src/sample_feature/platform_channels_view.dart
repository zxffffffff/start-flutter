import 'package:flutter/material.dart';

// 参考：https://flutter.cn/docs/development/platform-integration/platform-channels

/// Displays detailed information about a SampleItem.
class PlatformChannelsView extends StatelessWidget {
  const PlatformChannelsView({super.key});

  static const routeName = '/platform_channels_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlatformChannelsView'),
      ),
      body: const Center(
        child: Text('platform_channels_view'),
      ),
    );
  }
}
