import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/platform_channel.dart';
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
  final PlatformChannel channel = PlatformChannel();
  String _testPerf = '--';
  String _batteryLevel = '--';
  Timer? _testTimer;

  void startTimerPerf() {
    _testTimer =
        Timer.periodic(const Duration(milliseconds: 10), (timer) async {
      final Ret ret = await channel.getChannelPerf();
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
                final Ret ret = await channel.getBatteryLevel();
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
