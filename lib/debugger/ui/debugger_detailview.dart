



import 'package:flutter/services.dart';

import '../be_logger.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class DebuggerDetailView extends StatelessWidget{

  final LogInfo _logInfo;
  DebuggerDetailView(this._logInfo);
  void _handleClose(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final Widget actions = ButtonTheme.bar(
        child: ButtonBar(
            children: <Widget>[
              FlatButton(
                  child: Text("share"),
                  onPressed: (){
                    Share.share(_logInfo.contents);
                  }
              ),
              FlatButton(
                  child: Text("close"),
                  onPressed: (){
                    _handleClose(context);
                  }
              ),
            ]
        )
    );
    final ThemeData theme = Theme.of(context);

    final Widget pickerAndActions = Container(
      width: double.infinity,
      color: theme.dialogBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child:
              SingleChildScrollView(
                  child: GestureDetector(
                    child: Text(_logInfo.contents, style: TextStyle(fontSize: 12, decoration: TextDecoration.none, color: Colors.black)),
                    onLongPress: (){
                      Clipboard.setData(ClipboardData(text: _logInfo.contents));
                    },
                  ),
                ),
              ),
          actions,
        ],
      ),
    );

    return pickerAndActions ;
  }

}