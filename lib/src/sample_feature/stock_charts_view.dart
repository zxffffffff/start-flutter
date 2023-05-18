import 'package:flutter/material.dart';
import 'package:stock_charts/demo_chart.dart';

/// Displays detailed information about a SampleItem.
class StockChartsView extends StatefulWidget {
  const StockChartsView({super.key});
  @override
  State<StockChartsView> createState() => _StockChartsViewState();

  static const routeName = '/stock_charts_view';
}

class _StockChartsViewState extends State<StockChartsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StockChartsView'),
      ),
      body: Center(
        child: DemoChart(),
      ),
    );
  }
}
