import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CircledButton extends StatelessWidget {
  const CircledButton({super.key, required this.onPressed, required this.icon});
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 1),
              )
            ]),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: 
          IconButton(
            icon: Icon(icon, color: Colors.black),
            onPressed: onPressed
          ),
        ));
  }
}
