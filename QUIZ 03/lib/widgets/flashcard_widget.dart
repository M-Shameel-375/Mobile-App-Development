// lib/widgets/flashcard_widget.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/flashcard.dart';

class FlashcardWidget extends StatefulWidget {
  final Flashcard flashcard;
  final VoidCallback onSwipeLeft;
  final VoidCallback onRemove;

  const FlashcardWidget({
    Key? key,
    required this.flashcard,
    required this.onSwipeLeft,
    required this.onRemove,
  }) : super(key: key);

  @override
  State<FlashcardWidget> createState() => _FlashcardWidgetState();
}

class _FlashcardWidgetState extends State<FlashcardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  bool _isFlipped = false;
  double _dragDistance = 0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _handleFlip() {
    if (_isFlipped) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  void _handleSwipeComplete() {
    widget.onSwipeLeft();
    Future.delayed(const Duration(milliseconds: 100), () {
      widget.onRemove();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final swipeThreshold = size.width * 0.4;

    return GestureDetector(
      onTap: _handleFlip,
      onHorizontalDragUpdate: (details) {
        setState(() {
          _dragDistance += details.delta.dx;
          _isDragging = true;
        });
      },
      onHorizontalDragEnd: (details) {
        if (_dragDistance < -swipeThreshold) {
          // Swipe left - mark as learned
          setState(() {
            _dragDistance = -size.width;
          });
          Future.delayed(const Duration(milliseconds: 300), () {
            _handleSwipeComplete();
          });
        } else {
          setState(() {
            _dragDistance = 0;
            _isDragging = false;
          });
        }
      },
      child: AnimatedContainer(
        duration: _isDragging
            ? Duration.zero
            : const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(_dragDistance, 0, 0),
        child: Opacity(
          opacity: _dragDistance < -swipeThreshold
              ? 0.0
              : (1 - (_dragDistance.abs() / swipeThreshold)).clamp(0.3, 1.0),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            height: 220,
            child: AnimatedBuilder(
              animation: _flipAnimation,
              builder: (context, child) {
                final angle = _flipAnimation.value * math.pi;
                final isBack = angle > math.pi / 2;

                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(angle),
                  child: isBack
                      ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(math.pi),
                    child: _buildBackCard(),
                  )
                      : _buildFrontCard(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFrontCard() {
    final isSwipingLeft = _dragDistance < -50;

    return Container(
      decoration: BoxDecoration(
        gradient: isSwipingLeft
            ? const LinearGradient(
          colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
            : const LinearGradient(
          colors: [Colors.white, Color(0xFFF8F9FA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'QUESTION',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isSwipingLeft ? Colors.white70 : Colors.grey[600],
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Center(
              child: Text(
                widget.flashcard.question,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isSwipingLeft ? Colors.white : const Color(0xFF2C3E50),
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Tap to reveal answer',
            style: TextStyle(
              fontSize: 13,
              color: isSwipingLeft ? Colors.white70 : Colors.grey[500],
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFF6F00).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              '← Swipe left if learned',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFFFF6F00),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00897B), Color(0xFF00ACC1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00897B).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'ANSWER',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Center(
              child: Text(
                widget.flashcard.answer,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Tap to see question',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white70,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}