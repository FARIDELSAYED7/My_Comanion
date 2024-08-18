import 'dart:async';

import 'package:flutter/material.dart';

class BreathScreen extends StatefulWidget {
  @override
  _BreathScreenState createState() => _BreathScreenState();
}

class _BreathScreenState extends State<BreathScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  Timer? _timer;
  Timer? _resetTimer;
  int _seconds = 0;
  String _selectedBreathingType = 'Breath';
  bool _isRunning = false;
  bool _wasRunning = false;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  void _initAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // Adjust duration as needed
    );
    _animation = Tween<double>(begin: 0.2, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });
  }

  void startBreathing() {
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
      if (_seconds == 48) {
        _animationController.stop();
        _timer?.cancel();
        _resetTimer?.cancel();
        _showDialog();
      }
    });
    _animationController.forward();
  }

  void stopBreathing() {
    setState(() {
      _isRunning = false;
    });
    _animationController.stop();
    _timer?.cancel();
    _resetTimer?.cancel();
  }

  void reset() {
    setState(() {
      _seconds = 0;
      _isRunning = false;
      if (_wasRunning) {
        _animationController.forward();
      }
    });
    _animationController.reset();
    _timer?.cancel();
    _resetTimer?.cancel();
    _animationController.duration = const Duration(seconds: 6);
    _wasRunning = _isRunning;
    _animationController.stop();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Done'),
          content: const Text('You have completed 48 seconds'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                reset();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _wasRunning = _isRunning;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 120,
        title: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  const SizedBox(height: 20),
                  Image.asset('assets/images/mangeBreath.png'),
                  Text(
                    'Mange Your Breath',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (_isRunning) {
            reset();
            return false;
          }
          return true;
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          height: 500,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    child: Center(
                      child: AnimatedContainer(
                        duration: _seconds < 54
                            ? const Duration(milliseconds: 500)
                            : const Duration(milliseconds: 10000),
                        height: _animation.value * 200,
                        width: _animation.value * 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '${_seconds} seconds',
                    style: const TextStyle(fontSize: 24),
                  ),
                  Text(
                    _selectedBreathingType,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(8),
                            shadowColor: Colors.blue,
                            textStyle: const TextStyle(fontSize: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: const BorderSide(color: Colors.blue),
                            ),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blue,
                            minimumSize: const Size(100, 50),
                            maximumSize: const Size(120, 50),
                            side: const BorderSide(
                              color: Colors.blue,
                              width: 2,
                            )),
                        onPressed: _isRunning ? null : startBreathing,
                        child: const Text('Start'),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(8),
                            shadowColor: Colors.blue,
                            textStyle: const TextStyle(fontSize: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: const BorderSide(color: Colors.blue),
                            ),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blue,
                            minimumSize: const Size(100, 50),
                            maximumSize: const Size(120, 50),
                            side: const BorderSide(
                              color: Colors.blue,
                              width: 2,
                            )),
                        onPressed: _isRunning ? stopBreathing : null,
                        child: const Text('Stop'),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(8),
                        shadowColor: Colors.blue,
                        textStyle: const TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: const BorderSide(color: Colors.blue),
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue,
                        minimumSize: const Size(100, 50),
                        maximumSize: const Size(120, 50),
                        side: const BorderSide(
                          color: Colors.blue,
                          width: 2,
                        )),
                    onPressed: () {
                      reset();
                      _animationController.stop();
                    },
                    child: const Text('Reset'),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _resetTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }
}
