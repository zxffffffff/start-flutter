import 'package:flutter/material.dart';
import '../settings/settings_view.dart';
import 'stock_charts_view.dart';
import 'login_view.dart';
import 'platform_channels_view.dart';
import 'painter_view.dart';
import 'sample_item.dart';
import 'sample_item_details_view.dart';
import 'native_view.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatelessWidget {
  const SampleItemListView({
    super.key,
    this.items = const [
      SampleItem(SampleItemDetailsView.routeName, 'Sample Item Details'),
      SampleItem(LoginView.routeName, '[TODO] Login'),
      SampleItem(PlatformChannelsView.routeName, '[WIP] Platform Channels'),
      SampleItem(PainterView.routeName, '[TODO] Painter'),
      SampleItem(StockChartsView.routeName, '[WIP] Stock Charts'),
      SampleItem(NativeView.routeName, 'Native View'),
    ],
  });

  static const routeName = '/';

  final List<SampleItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: ListView.builder(
        // Providing a restorationId allows the ListView to restore the
        // scroll position when a user leaves and returns to the app after it
        // has been killed while running in the background.
        restorationId: 'sampleItemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return ListTile(
              title: Text(item.text),
              leading: const CircleAvatar(
                // Display the Flutter Logo image asset.
                foregroundImage: AssetImage('assets/images/flutter_logo.png'),
              ),
              onTap: () {
                // Navigate to the details page. If the user leaves and returns to
                // the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.restorablePushNamed(
                  context,
                  item.routeName,
                );
              });
        },
      ),
    );
  }
}
