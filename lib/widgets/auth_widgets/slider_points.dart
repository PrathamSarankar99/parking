import 'package:flutter/material.dart';

class SliderPoints extends StatelessWidget {
  const SliderPoints({Key key, this.totalPoints, this.index}) : super(key: key);
  final int totalPoints;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Center(
        child: SizedBox(
          width: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List<Widget>.generate(
              totalPoints,
              (index) => Container(
                height: index == this.index ? 12 : 10,
                width: index == this.index ? 12 : 10,
                decoration: BoxDecoration(
                  color: index == this.index ? Colors.blue : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
