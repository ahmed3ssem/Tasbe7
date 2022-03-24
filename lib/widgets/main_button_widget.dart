import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';

class MainButtonWidget extends StatelessWidget {

  final String btTitle;
  final VoidCallback onTap;
  final firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);

  MainButtonWidget(this.btTitle, this.onTap);

  @override
  Widget build(BuildContext context) {
    return NiceButton(
        radius: 40,
        padding: const EdgeInsets.all(15),
        text: btTitle,
        gradientColors: [secondColor, firstColor],
        onPressed: onTap,
        background: null,
    );
  }
}
