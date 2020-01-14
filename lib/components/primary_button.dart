import 'package:analyse_donnees_app/utils/config_size.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function onTap;
  final double width;
  final double borderRadius;
  final IconData icon;
  final String title;
  final Color buttonColor;
  final Color textColor;
  final Color iconColor;
  final EdgeInsets padding;
  PrimaryButton(

      {this.borderRadius = 10,
      this.buttonColor = Colors.black,
      this.padding=const EdgeInsets.all(13),
      this.icon = Icons.drag_handle,
      this.iconColor = Colors.white,
      this.onTap,
      this.textColor = Colors.black,
      this.title = "Click me!",
      this.width = 100.0});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: RaisedButton(
        padding: EdgeInsets.all(13),
        onPressed: onTap,
        color: buttonColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: iconColor,
            ),
            SizedBox(
              width: 10,
            ),
            Text(title, style: TextStyle(color: textColor))
          ],
        ),
      ),
    );
  }
}
