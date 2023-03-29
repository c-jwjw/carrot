import 'package:flutter/material.dart';

class ManorTemperature extends StatelessWidget {
  double manorTemp;
  late int level;
  ManorTemperature({super.key, required this.manorTemp}) {
    _calcTempLevel();
  }

    void _calcTempLevel() {
    if (20 >= manorTemp) {
      level = 0;
    } else if (20 < manorTemp && 32 >= manorTemp) {
      level = 1;
    } else if (32 < manorTemp && 36.5 >= manorTemp) {
      level = 2;
    } else if (36.5 < manorTemp && 40 >= manorTemp) {
      level = 3;
    } else if (40 < manorTemp && 50 >= manorTemp) {
      level = 4;
    } else if (50 < manorTemp) {
      level = 5;
    }
  }

  final List<Color> temperColors = [
    const Color(0xff072038),
    const Color(0xff0d3a65),
    const Color(0xff186ec0),
    const Color(0xff37b24d),
    const Color(0xffffad13),
    const Color(0xfff76707),
  ];

  Widget _makeTempLabelAndBar() {
    return Container(
      width: 65,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${manorTemp}°C", 
            style: TextStyle(
              color: temperColors[level],
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 6, 
              color: Colors.black.withOpacity(0.2),
              child: Row(
                children: [
                  Container(
                    height: 6, 
                    width: 65 / 99 * manorTemp,   // 65에서 얼마나 차느냐 65면 100%인거임. 
                    color: temperColors[level],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _makeTempToCharactorIcon() {
    return Container(
      width: 30,
      height: 30,
      child: Image.asset("assets/images/level-${level}.jpg"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _makeTempLabelAndBar(),
              const SizedBox(width: 7),
              _makeTempToCharactorIcon(),
            ],
          ),
          const SizedBox(height: 5),
          const Text(
            "매너온도", 
            style: TextStyle(
              decoration: TextDecoration.underline,  
              fontSize : 12, 
              color : Colors.grey
            ),
          )
        ],
      ),
    );
  }
}