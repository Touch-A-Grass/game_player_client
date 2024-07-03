import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_player_client/presentation/widgets/dice/dice_painter.dart';

class DiceController extends ValueNotifier<int> {
  int maxValue;
  bool scroll = false;

  DiceController(this.maxValue) : super(0);

  void rollTo(int value) {
    this.value = -1;
    scroll = true;
    this.value = value;
    scroll = false;
  }
}

class DiceView extends StatefulWidget {
  final DiceController controller;

  const DiceView({
    super.key,
    required this.controller,
  });

  @override
  State<DiceView> createState() => _DiceViewState();
}

class _DiceViewState extends State<DiceView> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scrollAnimation;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _fadeInAnimation;

  final values = <String>[];

  void roll() {
    if (widget.controller.scroll) {
      values.clear();
      for (int i = 0; i < DicePainter.shellCount; i++) {
        final text = i == 25 ? widget.controller.value : Random().nextInt(widget.controller.maxValue);
        values.add(text.toString());
      }
      _controller.value = 0;
      _controller.forward(from: 0);
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: const Duration(seconds: 5), vsync: this);
    _scrollAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.8, curve: Curves.easeInOutCubic),
      ),
    );
    _fadeAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.8, 1, curve: Curves.linear),
      ),
    );
    _fadeInAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.2, curve: Curves.linear),
      ),
    );
    widget.controller.addListener(roll);
  }

  @override
  void dispose() {
    widget.controller.removeListener(roll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => CustomPaint(
          painter: DicePainter(
            value: widget.controller.value,
            maxValue: widget.controller.maxValue,
            scrollProgress: _scrollAnimation.value,
            fadeProgress: _fadeAnimation.value,
            fadeInProgress: _fadeInAnimation.value,
            color: Theme.of(context).colorScheme.onSurface,
            values: values,
          ),
          child: const SizedBox(width: double.infinity, height: 80),
        ),
      ),
    );
  }
}
