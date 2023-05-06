import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/ret.dart';

// 参考：https://flutter.cn/docs/development/platform-integration/platform-channels

/// Displays detailed information about a SampleItem.
class PlatformChannelsView extends StatefulWidget {
  const PlatformChannelsView({super.key});
  @override
  State<PlatformChannelsView> createState() => _PlatformChannelsViewState();

  static const routeName = '/platform_channels_view';
}

class _PlatformChannelsViewState extends State<PlatformChannelsView> {
  // [1] domain前缀 + channel名称
  static const testChannel = MethodChannel('test');
  static const batteryChannel = MethodChannel('samples.flutter.dev/battery');

  String _testPerf = '--';
  String _batteryLevel = '--';

  // [2] channel方法
  double ms12Avg = 0, ms34Avg = 0;
  int msCnt = 0;
  double ms12Max = 0, ms34Max = 0;
  Future<Ret<String>> _getChannelPerf() async {
    String ret = '';
    String err = '';
    try {
      final Future f1 = testChannel.invokeMethod('getSystemClock');
      final Future f2 = testChannel.invokeMethod('getSystemClock');
      final List<int> t1 = await f1;
      final List<int> t2 = await f2;
      final double ms12 =
          (t2[0] - t1[0]) * 1000.0 + (t2[1] - t1[1]) / 1000000.0;

      final List<int> t3 = await testChannel.invokeMethod('getSystemClock');
      final List<int> t4 = await testChannel.invokeMethod('getSystemClock');
      final double ms34 =
          (t4[0] - t3[0]) * 1000.0 + (t4[1] - t3[1]) / 1000000.0;

      ms12Avg = ms12Avg / (msCnt + 1) * msCnt + ms12 / (msCnt + 1);
      ms34Avg = ms34Avg / (msCnt + 1) * msCnt + ms34 / (msCnt + 1);
      ++msCnt;
      ms12Max = max(ms12Max, ms12);
      ms34Max = max(ms34Max, ms34);

      ret = "count: $msCnt\n"
          "async: ${ms12.toStringAsFixed(3)}  avg: ${ms12Avg.toStringAsFixed(3)}  max: ${ms12Max.toStringAsFixed(3)} (ms)\n"
          "await: ${ms34.toStringAsFixed(3)}  avg: ${ms34Avg.toStringAsFixed(3)}  max: ${ms34Max.toStringAsFixed(3)} (ms)";
    } on PlatformException catch (e) {
      err = "Method Failed: '${e.message}'.";
    } on MissingPluginException catch (e) {
      err = "Missing Error: '${e.message}'.";
    }
    return Ret(err.isEmpty, err, ret);
  }

  Future<Ret<int>> _getBatteryLevel() async {
    int ret = 0;
    String err = '';
    try {
      ret = await batteryChannel.invokeMethod('getBatteryLevel');
    } on PlatformException catch (e) {
      err = "Method Failed: '${e.message}'.";
    } on MissingPluginException catch (e) {
      err = "Missing Error: '${e.message}'.";
    }
    return Ret(err.isEmpty, err, ret);
  }

  Timer? _testTimer;

  void startTimerPerf() {
    _testTimer =
        Timer.periodic(const Duration(milliseconds: 10), (timer) async {
      final Ret ret = await _getChannelPerf();
      // 异步需要考虑对象生命周期
      if (_testTimer == null || !_testTimer!.isActive) return;
      if (!ret.ok) {
        stopTimerPerf();
      }
      setState(() {
        _testPerf = ret.ok ? ret.data : ret.err;
      });
    });
  }

  void stopTimerPerf() {
    _testTimer?.cancel();
    _testTimer = null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    stopTimerPerf();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlatformChannelsView'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                if (_testTimer == null || !_testTimer!.isActive) {
                  startTimerPerf();
                } else {
                  stopTimerPerf();
                }
                setState(() {}); // update Text
              },
              child: Text(_testTimer == null || !_testTimer!.isActive
                  ? 'Start Channel Perf'
                  : 'Stop Channel Perf'),
            ),
            Text(_testPerf),
            ElevatedButton(
              onPressed: () async {
                final Ret ret = await _getBatteryLevel();
                setState(() {
                  _batteryLevel = ret.ok ? '${ret.data}%' : ret.err;
                });
              },
              child: const Text('Get Battery Level'),
            ),
            Text(_batteryLevel),
          ],
        ),
      ),
    );
  }
}
