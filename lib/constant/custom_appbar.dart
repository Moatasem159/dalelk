import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final VoidCallback? onTap;
  const CustomAppBar({
    super.key, required this.title, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:  Text(title),
      centerTitle: true,
      backgroundColor: Colors.purple,
      elevation: 5,
      leading:onTap!=null? IconButton(onPressed: onTap ?? (){
        Navigator.pop(context);
      }, icon: const Icon(Icons.arrow_back_outlined)):null,
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity,50);
}