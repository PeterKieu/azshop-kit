
import './bloc_sensor.dart';
import './ui/debugger_listview.dart';
import 'be_logger.dart';

class App{
  BlocSensor _sensor;

  void showDebugger(){
    showDialog((context) => DebuggerListView());
  }

  void setDebugMode(bool enabled){
    if(enabled){
      createBelog();
      if(_sensor == null){
        _sensor = BlocSensor();
        _sensor?.shakeEvent?.listen((shaked) {
          showDebugger();
        });
      }
    }
    else{
      _sensor?.dispose();
      _sensor = null;
      destroyBelog();
    }
  }
}