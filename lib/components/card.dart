import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final double height;
  CustomCard({this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
    
      elevation: 2.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: height == null ? child : Container(height: height, child: child),
    );
  }
}
