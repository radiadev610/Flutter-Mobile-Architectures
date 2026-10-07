import 'package:flutter/material.dart';

class AnimatedFavButton extends StatefulWidget {
  final Color activeColor;

  const AnimatedFavButton({super.key, this.activeColor = Colors.redAccent});

  @override
  State<AnimatedFavButton> createState() => _AnimatedFavButtonState();
}

class _AnimatedFavButtonState extends State<AnimatedFavButton>
    with SingleTickerProviderStateMixin {
  bool _isFav = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.45)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.45, end: 1.0)
            .chain(CurveTween(curve: Curves.elasticOut)),
        weight: 50,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _isFav = !_isFav);
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: IconButton(
        icon: Icon(
          _isFav ? Icons.favorite : Icons.favorite_border,
          color: _isFav ? widget.activeColor : Colors.grey,
          size: 28.0,
        ),
        onPressed: _toggle,
      ),
    );
  }
}