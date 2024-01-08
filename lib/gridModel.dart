import 'package:flutter/material.dart';
import 'package:quiz/constants.dart';

class GridModel extends StatelessWidget {
  final String image;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const GridModel({
    Key? key,
    required this.image,
    required this.title,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(20),
        ),
        //width: 100.0,
        //height: 100.0,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(image, width: 130, height: 130,),
              Text(title,
              style: TextStyle(
                fontFamily: police,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: color
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
