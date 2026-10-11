import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/save_manager.dart';
import '../data/stages_data.dart';
import '../stages/stages_all.dart';

class P {
  static const bg = Color(0xFF050505);
  static const dim = Color(0xFF6A6A6A);
  static const mid = Color(0xFFAA3333);
  static const rare = Color(0xFFFF4444);
  static const white = Color(0xFFE0E0E0);
  static const gold = Color(0xFFFFCC44);
}

class StageScreen extends StatefulWidget {
  final int stageId;
  const StageScreen({super.key, required this.stageId});

  @override
  State<StageScreen> createState() => _StageScreenState();
}

class _StageScreenState extends State<StageScreen> {
  late Stage _stage;
  int _attemptsLeft = 3;
  int _usedAttempts = 0;
  bool _showWhisper = false;
  String _whisper = '';
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _stage = kStages.firstWhere((s) => s.id == widget.stageId);
    _attemptsLeft = _stage.maxAttempts;
  }

  Future<void> _onWin() async {
    if (_finished) return;
    _finished = true;

    // عدد النجوم على أساس عدد المحاولات المستخدمة
    int stars;
    if (_usedAttempts == 0) {
      stars = 3;
    } else if (_usedAttempts == 1) {
      stars = 2;
    } else {
      stars = 1;
    }

    // نحفظ
    await SaveManager.setStars(_stage.id, stars);

    // نفتح اللي بعدها
    if (_stage.id < kStages.length) {
      await SaveManager.unlock(_stage.id + 1);
      await SaveManager.setCurrentStage(_stage.id + 1);
    } else {
      await SaveManager.setCurrentStage(_stage.id);
    }

    // نعرض الهمسة الأول
    if (!mounted) return;
    setState(() {
      _whisper = _stage.whisper;
      _showWhisper = true;
    });

    await Future.delayed(const Duration(milliseconds: 1600));
    if (!mounted) return;

    setState(() => _showWhisper = false);
    _showResult(stars);
  }

  void _onFail() {
    if (_finished) return;
    HapticFeedback.heavyImpact();
    setState(() {
      _attemptsLeft--;
      _usedAttempts++;
    });
    if (_attemptsLeft <= 0) {
      _finished = true;
      _showGameOver();
    }
  }

  void _showResult(int stars) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _ResultDialog(
        stars: stars,
        onContinue: () {
          Navigator.of(context).pop(); // يقفل الديالوج
          Navigator.of(context).pop(); // يرجع للخريطة
        },
      ),
    );
  }

  void _showGameOver() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _GameOverDialog(
        onRetry: () {
          Navigator.of(context).pop();
          setState(() {
            _finished = false;
            _attemptsLeft = _stage.maxAttempts;
            _usedAttempts = 0;
          });
        },
        onBack: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_showWhisper) {
      return Scaffold(
        backgroundColor: P.bg,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Text(
                _whisper,
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  color: P.dim,
                  fontSize: 20,
                  height: 2.0,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: P.bg,
      body: SafeArea(
        child: Column(
          children: [
            // الشريط العلوي
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: P.dim,
                      size: 18,
                    ),
                  ),
                  Text(
                    'المرحلة ${_stage.id}/${kStages.length}',
                    style: const TextStyle(color: P.dim, fontSize: 12),
                  ),
                  Text(
                    'محاولات: $_attemptsLeft',
                    style: TextStyle(
                      color: _attemptsLeft <= 1 ? P.rare : P.dim,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xFF1A1A1A), height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
              child: Column(
                children: [
                  Text(
                    _stage.title,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      color: P.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _stage.brief,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      color: P.dim,
                      fontSize: 13,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: buildStage(
                stageId: _stage.id,
                onWin: _onWin,
                onFail: _onFail,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════ ديالوج النتيجة ═══════════════
class _ResultDialog extends StatelessWidget {
  final int stars;
  final VoidCallback onContinue;
  const _ResultDialog({required this.stars, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: P.bg,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: P.mid),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'خلصت المرحلة',
              textDirection: TextDirection.rtl,
              style: TextStyle(color: P.white, fontSize: 20),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) {
                final filled = i < stars;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    filled ? Icons.star : Icons.star_border,
                    color: filled ? P.gold : P.dim,
                    size: 40,
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: onContinue,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: P.mid),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'تمام',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: P.white, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════ ديالوج الخسارة ═══════════════
class _GameOverDialog extends StatelessWidget {
  final VoidCallback onRetry;
  final VoidCallback onBack;
  const _GameOverDialog({required this.onRetry, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: P.bg,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: P.rare),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'GAME OVER',
              style: TextStyle(
                color: P.rare,
                fontSize: 26,
                letterSpacing: 6,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: onRetry,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: P.mid),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'من جديد',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(color: P.white, fontSize: 14),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onBack,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: P.dim),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'للخريطة',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(color: P.dim, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}