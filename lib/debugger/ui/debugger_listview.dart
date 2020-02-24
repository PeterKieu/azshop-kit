


import '../be_logger.dart';
import './bloc_debugger.dart';
import './debugger_detailview.dart';
import 'package:flutter/material.dart';

class DebuggerListView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _DebuggerListSate();

}

class _DebuggerListSate extends State<DebuggerListView>{

  BlocDebugger _blocDebugger;

  @override
  void initState() {
    super.initState();
    _blocDebugger = BlocDebugger();
  }

  @override
  void dispose() {
    super.dispose();
    _blocDebugger.dispose();
  }

  void _handleClose() {
    Navigator.pop(context);
  }


  void _handleOpenDetail(LogInfo item){
    showDialog(
        context: context,
      builder: (context) => DebuggerDetailView(item)
    );
  }

  void _handleClean(){
    _blocDebugger.clean();
  }


  @override
  Widget build(BuildContext context) {

    final Widget actions = ButtonTheme.bar(
        child: ButtonBar(
            children: <Widget>[
              FlatButton(
                  child: Text("clean",style: TextStyle(color: Colors.redAccent),),
                  onPressed: _handleClean
              ),
              FlatButton(
                  child: Text("close",style: TextStyle(color: Colors.redAccent),),
                  onPressed: _handleClose
              ),
            ]
        )
    );
    final ThemeData theme = Theme.of(context);

    final listView = StreamBuilder<List<LogInfo>>(
      stream: _blocDebugger.logger,
      builder: (contex,snapshort){
        return ListView.builder(
            itemCount: _blocDebugger.counts,
            itemBuilder: (context, index){
              var item  = _blocDebugger.at(index);
              return GestureDetector(
                onTap: (){_handleOpenDetail(item);},
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(item.title ?? "null text", style: TextStyle(fontSize: 14, decoration: TextDecoration.none),),
                      Text(item.subTitle ?? "null text",style: TextStyle(fontSize: 12, decoration: TextDecoration.none)),
                      SizedBox(
                        height: 8.0,
                      )
                    ],
                  ),
                ),
              );
            });
      },
    );

    final Widget pickerAndActions = Container(
      color: theme.dialogBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(child: listView), // picker grows and shrinks with the available space
          actions,
        ],
      ),
    );



    return pickerAndActions;
  }

}