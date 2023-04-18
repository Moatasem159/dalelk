import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key, required this.onTap, required this.title,
  });
  final VoidCallback onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
            fixedSize:MaterialStateProperty.all(const Size(200, 50)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            )),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            textStyle: MaterialStateProperty.all(const TextStyle(
              fontSize: 20,
            )),

            backgroundColor: MaterialStateProperty.all(Colors.orange)
        ),
        child:  Text(title),
      ),
    );
  }
}