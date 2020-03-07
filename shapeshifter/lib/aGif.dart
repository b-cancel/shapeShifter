import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';

class AGif extends StatelessWidget{
  AGif({
    @required this.name,
    @required this.controller,
  });

  final String name;
  final GifController controller;

  @override
  Widget build(BuildContext context) {
    return GifImage(
      controller: controller,
      image: AssetImage(
        "assets/clear/" + name + ".gif",
      ),
     );
  }
}