import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AayaButtonWidget extends StatelessWidget {
  const AayaButtonWidget({
    super.key,
    required this.size,
    required this.isValidated,
    required this.ontap,
    required this.isLoading,
    required this.buttonText,
  });

  final Size size;
  final bool isValidated;
  final Function ontap;
  final bool isLoading;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          if (isValidated) {
            ontap();
          }
        },
        child: Container(
            width: size.width * 0.8,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: !isValidated
                    ? Theme.of(context).unselectedWidgetColor
                    : Colors.black),
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: isLoading
                  ? Center(
                      child: LoadingAnimationWidget.inkDrop(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        size: 20,
                      ),
                    )
                  : Center(
                      child: Text(
                        buttonText,
                        style: TextStyle(
                          color: isValidated
                              ? Theme.of(context).unselectedWidgetColor
                              : Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
            )),
      ),
    );
  }
}
