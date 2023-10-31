import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final GestureTapCallback onTap;
  const RoundedButton({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const CircleBorder()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
