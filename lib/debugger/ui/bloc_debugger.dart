import 'dart:async';

import '../be_logger.dart';

class BlocDebugger {
  final _loggerStreamer = StreamController<List<LogInfo>>();
  Stream<List<LogInfo>> get logger => _loggerStreamer.stream;

  void dispose() {
    _loggerStreamer.close();
  }

  int get counts => beLogger?.logs?.length ?? 0;
  LogInfo at(int index) => beLogger?.logs[index];

  void clean(){
    beLogger?.logs?.clear();
    _loggerStreamer.add(beLogger?.logs);
  }

  BlocDebugger() {
    _loggerStreamer.add(beLogger?.logs);
  }
}
