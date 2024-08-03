import 'package:flutter/material.dart';
import 'package:qubah_app/app/common/app_colors.dart';

class RotateIcons extends StatefulWidget {
  final IconData iconData;
  final double size;
  final Function function;
  final Color? colorIcon;
  final Widget? content;
  const RotateIcons({
    super.key,
    required this.iconData,
    required this.size,
    required this.function,
    this.colorIcon,
    this.content,
  });

  @override
  // ignore: library_private_types_in_public_api
  _RotateIconsState createState() => _RotateIconsState();
}

class _RotateIconsState extends State<RotateIcons>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isRotated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleRotation() {
    setState(() {
      _isRotated = !_isRotated;
      if (_isRotated) {
        _controller.forward();
        widget.function();
      } else {
        _controller.reverse();
        widget.function();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          minimumSize: const MaterialStatePropertyAll(Size.zero),
          surfaceTintColor:
              MaterialStatePropertyAll(widget.colorIcon ?? AppColors.main),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 8, vertical: 4))),
      onPressed: _toggleRotation,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.content ?? const SizedBox.shrink(),
          RotationTransition(
            turns: Tween(begin: 0.0, end: 0.50).animate(_controller),
            child: Icon(
              widget.iconData,
              size: widget.size,
              color: widget.colorIcon ?? AppColors.main,
            ),
          ),
        ],
      ),
    );
  }
}
