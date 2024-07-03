import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_player_client/data/models/roll.dart';
import 'package:game_player_client/presentation/widgets/dice/dice_view.dart';

class RollWidget extends StatefulWidget {
  final Roll roll;
  final ValueChanged<RollResult> onRollChanged;

  const RollWidget({
    super.key,
    required this.roll,
    required this.onRollChanged,
  });

  @override
  State<RollWidget> createState() => _RollWidgetState();
}

class _RollWidgetState extends State<RollWidget> with TickerProviderStateMixin {
  late final List<DiceController> _diceControllers;
  late final AnimationController _animationController;
  late final Animation<double> _numberAnimation;
  late final Animation<double> _opacityAnimation;

  int diceSum = 0;

  @override
  void didUpdateWidget(covariant RollWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.roll.dices != widget.roll.dices) {
      _diceControllers = List.generate(widget.roll.dices.length, (dice) => DiceController(widget.roll.dices[dice]));
    }
  }

  @override
  void initState() {
    super.initState();
    _diceControllers = List.generate(widget.roll.dices.length, (dice) => DiceController(widget.roll.dices[dice]));

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 7));
    _numberAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 0.7, curve: Curves.linear),
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 0.05, curve: Curves.easeInOutCubic),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _roll() {
    final values = List.generate(_diceControllers.length, (index) => Random().nextInt(widget.roll.dices[index]) + 1);

    _animationController.forward(from: 0);

    for (int i = 0; i < _diceControllers.length; i++) {
      _diceControllers[i].rollTo(values[i]);
    }
    setState(() {
      diceSum = values.fold(0, (previousValue, element) => previousValue + element);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).colorScheme.surfaceContainer,
            border: Border.all(color: Theme.of(context).colorScheme.primary),
          ),
          height: double.infinity,
          child: Stack(
            children: [
              Opacity(
                opacity: _opacityAnimation.value,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: _diceControllers.length,
                        itemBuilder: (context, index) => DiceView(controller: _diceControllers[index]),
                        separatorBuilder: (context, index) => const Divider(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AnimatedBuilder(
                      animation: _numberAnimation,
                      builder: (context, child) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Opacity(
                            opacity: _numberAnimation.value,
                            child: Text(
                              diceSum.toString(),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _animationController.value >= 0.7
                            ? () => widget.onRollChanged(
                                  RollResult(
                                    values: List.generate(
                                        _diceControllers.length, (index) => _diceControllers[index].value),
                                  ),
                                )
                            : null,
                        child: const Text('Ok'),
                      ),
                    ),
                  ],
                ),
              ),
              if (_opacityAnimation.value < 1)
                Opacity(
                  opacity: 1 - _opacityAnimation.value,
                  child: InkWell(
                    onTap: _animationController.isDismissed ? _roll : null,
                    child: SizedBox.expand(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Roll',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
