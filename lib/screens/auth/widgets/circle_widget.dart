import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircleWidget extends StatelessWidget {
  const CircleWidget({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        SizedBox(
          height: size.height * 0.5,
          width: size.width * 2, // Increase the container size
          child: Center(
            child: Transform.scale(
              scale: 1.5, // Increase the scale factor to zoom
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    transform: Matrix4.translationValues(
                        -size.width * 0.15, -size.height * 0, 0)
                      ..rotateZ(-27 * (3.1415927 / 180)),
                    width: size.width * 2,
                    height: size.width * 2,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xFF003B6D),
                          Color.fromRGBO(20, 68, 110, 0.337861),
                          Color.fromRGBO(102, 154, 204, 0),
                          Color.fromRGBO(104, 110, 116, 0.0989583),
                        ],
                        stops: [0.1174, 0.627, 0.9787, 0.9787],
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.28,
                        ),
                        Center(
                          child: CircleAvatar(
                            radius: size.width * 0.15,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: SvgPicture.asset(
                              "assets/svg/aaya_logo.svg",
                              height: size.width * 0.16,
                              width: size.width * 0.16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
