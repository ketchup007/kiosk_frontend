import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SVG;

class FirstScreenRobot extends StatefulWidget{
  const FirstScreenRobot({super.key});

  @override
  State<StatefulWidget> createState() => _FirstScreenRobotState();
}

class _FirstScreenRobotState extends State<FirstScreenRobot> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var robotHeight = MediaQuery.of(context).size.height * 0.21;

    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: robotHeight,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {},
                child: Ink.image(
                  alignment: Alignment.center,
                  image: const SVG.Svg('assets/images/robotAnimation/robot_frame_1.svg'),
                  height: robotHeight,
                  fit: BoxFit.fitHeight))))),
        Align(
            alignment: Alignment.center,
            child: Container(
                height: robotHeight,
                child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                        onTap: () {},
                        child: Ink.image(
                            alignment: Alignment.center,
                            image: const SVG.Svg('assets/images/robotAnimation/robot_frame_2.svg'),
                            height: robotHeight,
                            fit: BoxFit.fitHeight))))),
        Align(
            alignment: Alignment.center,
            child: Container(
                height: robotHeight,
                child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                        onTap: () {},
                        child: Ink.image(
                            alignment: Alignment.center,
                            image: const SVG.Svg('assets/images/robotAnimation/robot_frame_3.svg'),
                            height: robotHeight,
                            fit: BoxFit.fitHeight))))),
        Align(
            alignment: Alignment.center,
            child: Container(
                height: robotHeight,
                child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                        onTap: () {},
                        child: Ink.image(
                            alignment: Alignment.center,
                            image: const SVG.Svg('assets/images/robotAnimation/robot_frame_4.svg'),
                            height: robotHeight,
                            fit: BoxFit.fitHeight))))),
        Align(
            alignment: Alignment.center,
            child: Container(
                height: robotHeight,
                child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                        onTap: () {},
                        child: Ink.image(
                            alignment: Alignment.center,
                            image: const SVG.Svg('assets/images/robotAnimation/robot_frame_6.svg'),
                            height: robotHeight,
                            fit: BoxFit.fitHeight))))),
        Align(
            alignment: Alignment.center,
            child: Container(
                height: robotHeight,
                child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                        onTap: () {},
                        child: Ink.image(
                            alignment: Alignment.center,
                            image: const SVG.Svg('assets/images/robotAnimation/robot_frame_7.svg'),
                            height: robotHeight,
                            fit: BoxFit.fitHeight))))),
        Align(
            alignment: Alignment.center,
            child: Container(
                height: robotHeight,
                child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                        onTap: () {},
                        child: Ink.image(
                            alignment: Alignment.center,
                            image: const SVG.Svg('assets/images/robotAnimation/robot_frame_8.svg'),
                            height: robotHeight,
                            fit: BoxFit.fitHeight))))),
        Align(
            alignment: Alignment.center,
            child: Container(
                height: robotHeight,
                child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                        onTap: () {},
                        child: Ink.image(
                            alignment: Alignment.center,
                            image: const SVG.Svg('assets/images/robotAnimation/robot_frame_1.svg'),
                            height: robotHeight,
                            fit: BoxFit.fitHeight))))),
      ],
    );
  }


}