import 'package:flutter/material.dart';

class FullScreenPhoto extends StatelessWidget {
  final String imagePath;
  final String tag;

  FullScreenPhoto({this.tag, this.imagePath})
      : assert(tag != null),
        assert(imagePath != null);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(imagePath), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
