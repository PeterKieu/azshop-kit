import 'package:flutter/material.dart';
import 'package:azshop/screens/notifications.dart';
import 'package:azshop/util/comments.dart';
import 'package:azshop/util/const.dart';
import 'package:azshop/util/foods.dart';
import 'package:azshop/widgets/badge.dart';
import 'package:azshop/widgets/smooth_star_rating.dart';
import 'package:azshop/widgets/selectable_circle/selectable_circle_item.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool _isSelected = false;
  bool _isSelected2 = false;
  bool _isSelected3 = false;
  bool _isSelected4 = false;
  bool _isSelected5 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("example circle"),
      ),
      body: Column(
        children: <Widget>[
          Center(
              child: Text(
                "default",
                style: TextStyle(fontSize: 20.0),
              )),
          Center(
            child: SelectableCircle(
              width: 80.0,
              isSelected: _isSelected,
              onTap: () {
                setState(() {
                  _isSelected = !_isSelected;
                });
              },
              child: Text("test"),
            ),
          ),
          Center(
            child: Text(
              "Custom Colors",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Center(
            child: SelectableCircle(
              width: 80.0,
              isSelected: _isSelected2,
              color: Colors.brown,
              selectedBorderColor: Colors.orange,
              selectedColor: Colors.tealAccent,
              selectMode: SelectMode.simple,
              onTap: () {
                setState(() {
                  _isSelected2 = !_isSelected2;
                });
              },
              child: Icon(Icons.star),
            ),
          ),
          Center(
              child: Text(
                "empty Circle custom colors",
                style: TextStyle(fontSize: 20.0),
              )),
          Center(
            child: SelectableCircle(
              isSelected: _isSelected3,
              borderColor: Colors.greenAccent,
              selectedColor: Colors.blue,
              selectedBorderColor: Colors.red[900],
              width: 80.0,
              onTap: () {
                setState(() {
                  _isSelected3 = !_isSelected3;
                });
              },
            ),
          ),
          Center(
              child: Text(
                "SelectMode.check with bottomDescription",
                style: TextStyle(fontSize: 20.0),
              )),
          Center(
            child: SelectableCircle(
              color: Colors.redAccent,
              borderColor: Colors.red,
              isSelected: _isSelected4,
              selectMode: SelectMode.check,
              bottomDescription: Text("Description"),
              width: 80.0,
              child: Icon(
                Icons.tag_faces,
                size: 40.0,
              ),
              onTap: () {
                setState(() {
                  _isSelected4 = !_isSelected4;
                });
              },
            ),
          ),
          Center(
              child: Text(
                "SelectMode.check with custom colors",
                style: TextStyle(fontSize: 20.0),
              )),
          Center(
            child: SelectableCircle(
              color: Colors.redAccent,
              borderColor: Colors.green,
              isSelected: _isSelected5,
              selectMode: SelectMode.check,
              selectedColor: Colors.white,
              selectedBorderColor: Colors.blue,
              width: 80.0,
              child: Icon(
                Icons.watch_later,
                size: 40.0,
              ),
              onTap: () {
                setState(() {
                  _isSelected5 = !_isSelected5;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
