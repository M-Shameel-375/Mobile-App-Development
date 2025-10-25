import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isPrimary,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: widget.isPrimary
              ? (_isPressed
              ? const Color(0xFF1AA34A)
              : const Color(0xFF1DB954))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: widget.isPrimary
              ? null
              : Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: widget.isPrimary ? Colors.white : Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}