
import 'dart:async';
import 'package:flutter/material.dart';

class LogInfo{
  String title;
  String  _subTitle;
  String get subTitle => _subTitle;
  DateTime startTime;
  List<String> _contentSegment = [];
  bool isError = false;

  String get contents => "$subTitle\n${_contentSegment.join()}";

  void add(String titles, String content){
    if(titles == null){
      _contentSegment.add("$content\n");
    }
    else{
      _contentSegment.add("$titles: ${content ?? "null"}\n");
    }

  }
  void addMap(String titles, dynamic content){
    if(titles == null){
      _contentSegment.add("$content\n");
    }
    else{
      _contentSegment.add("$titles: ${content ?? "null"}\n");
    }

  }

  void addContent({String titles, String content}){
    if(titles == null){
      _contentSegment.add("$content\n");
    }
    else{
      _contentSegment.add("$titles: ${content ?? "null"}\n");
    }

  }

  void addLine(){
    _contentSegment.add("----------------------------------------\n");
  }

  void addError({String titles, String content}){
    if(titles == null){
      _contentSegment.add("[ERR]: ${content ?? "null"}\n");
    }
    else{
      _contentSegment.add("$titles [ERR]: ${content ?? "null"}\n");
    }
    isError = true;
  }

  void commitLog(){
    var duration = DateTime.now().difference(startTime);
    _subTitle = "${startTime.toString()} ~${duration.inMilliseconds}(mls)";
    if(true){
      print("\n\n\n\n\--------------------------------------------------------------------------------");
      print("LOG Title: ${this.title}");
      print("LOG Subtile: ${this.subTitle}");
      print("LOG Content: ${this.contents}\n--------------------------------------------------------------------------------\n\n\n\n\n");
    }
    if(isError){
      BELogger._instance?._addErrorInfo(this);
    } 
  }

}

void createBelog(){
  if(BELogger._instance == null){
    BELogger._instance = BELogger._();
    // BELogger._instance.printConsoleLog = true;
  }
}

void destroyBelog(){
  BELogger._instance?.listenerLogger?.cancel();  
  BELogger._instance?.listenerLogger = null;
  BELogger._instance = null;
}

class BELogger{
  StreamSubscription<LogInfo> listenerLogger;
  BELogger._(){
    listenerLogger?.cancel();
    listenerLogger = null;
    streamLog = createLogInfo("socketLog");
    
  }

  LogInfo streamLog;

  static BELogger _instance;
//  static final BELogger _instance = BELogger._();

//  bool printConsoleLog = false;
  List<LogInfo> logs = [];
  List<LogInfo> logsError = [];
  int maxLogSize = 30;
  int maxLogError = 50;
  void _addLogInfo(LogInfo logInfo)
  {
    if (logs.length > maxLogSize){
      logs.removeAt(logs.length - 1);
    }
    logs.insert(0, logInfo);
  }

  void _addErrorInfo(LogInfo logInfo){
    if (logsError.length > maxLogError){
      logsError.removeAt(logsError.length - 1);
    }
    logsError.insert(0, logInfo);
  }

  void logObj(Object obj,{String message}){
//    var logInfo = createLogInfo("OBJ: ${obj.runtimeType.toString()}");
//    if(message != null){
//      logInfo?.add("message", message ?? "");
//    }
//    logInfo?.commitLog();
  }

  void simpleLog(String title, {String message}){
    var logInfo = createLogInfo(title);
    logInfo?.add("message", message ?? "");
    logInfo?.commitLog();
  }


  void errorLog(String title, {String message, dynamic content}){
    var logInfo = createLogInfo("!!!ERROR $title");
    logInfo.isError = true;
    logInfo?.addMap("content", content);
    logInfo?.add("message", message ?? "");
    logInfo?.commitLog();
  }

  void error(Error error){
    var logInfo = createLogInfo("!!!ERROR");
    logInfo.isError = true;
    logInfo?.add("message", error?.toString() ?? "error == NULL");
    logInfo?.commitLog();
  }

  LogInfo createLogInfo(String title,{bool addDevice = true})
  {
    var logInfo = new LogInfo();
    String loginUser = "do not login";
    if(title.length > 80){
      logInfo.title = title.substring(0,80);
    }
    else{
      logInfo.title = title;
    }

    logInfo.startTime = DateTime.now();
    
    logInfo.add("Time", logInfo.startTime.toIso8601String());
    logInfo.add("Login User", loginUser);
    logInfo.add("API", title);
    
    logInfo.addLine();

    _addLogInfo(logInfo);

    return logInfo;
  }
}

BELogger get beLogger => BELogger._instance;