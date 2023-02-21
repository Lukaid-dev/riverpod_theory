import 'package:flutter/material.dart';

class DefaultElevatedButton extends StatelessWidget {
  final Function() onPressed;
  final Widget child;
  final double? height;

  const DefaultElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(
        onPressed: onPressed,
        child: child,
      ),
      const SizedBox(height: 8.0),
    ]);
  }
}
