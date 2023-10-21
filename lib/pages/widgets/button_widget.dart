import 'package:flutter/material.dart';

import '../../common/app_constant.dart';

class ButtonWidget extends StatelessWidget {
  final Widget content;
  final Function()? onTap;
  final Color bgColor;
  final bool isLoading;
  final double width;
  final double height;
  final bool disabled;
  final bool enableBorder;
  final BorderRadiusGeometry? borderRadius;
  const ButtonWidget(
      {super.key,
      required this.content,
      required this.onTap,
      this.bgColor = AppConstant.colorsPrimary,
      this.isLoading = false,
      required this.width,
      this.height = 56,
      this.enableBorder = true,
      this.borderRadius =
          const BorderRadius.all(Radius.circular(AppConstant.radiusSmall)),
      this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disabled ? () {} : onTap,
      child: Material(
        elevation: 0.0,
        borderRadius: borderRadius,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: disabled ? Colors.grey : bgColor,
              borderRadius: borderRadius,
              border: enableBorder
                  ? Border.all(
                      width: 1.5,
                      color: disabled
                          ? Colors.transparent
                          : AppConstant.colorsPrimary)
                  : Border.all(width: 0, color: Colors.transparent)),
          child: Center(child: content),
        ),
      ),
    );
  }
}
