import 'package:flutter/material.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _textController = TextEditingController();
  Color selectedColor = Colors.red;
  final List<Color> availableColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.teal,
    Colors.amber,
    Colors.cyan,
  ];

  final List<String> colorNames = [
    'Red',
    'Green',
    'Blue',
    'Yellow',
    'Purple',
    'Orange',
    'Pink',
    'Teal',
    'Amber',
    'Cyan',
  ];

  String selectedColorName = 'Red';

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LED Scroller'),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black87, Colors.blueGrey.shade900],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // First text field
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter Text to Scroll',
                      style: GoogleFonts.dotGothic16(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _textController,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Enter your text here (supports emojis! 😎)',
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        filled: true,
                        fillColor: Colors.grey.shade900,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Second field - color selector
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Color',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          dropdownColor: Colors.grey.shade900,
                          isExpanded: true,
                          value: selectedColorName,
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                          items: List.generate(colorNames.length, (index) {
                            return DropdownMenuItem<String>(
                              value: colorNames[index],
                              child: Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: availableColors[index],
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(colorNames[index]),
                                ],
                              ),
                            );
                          }),
                          onChanged: (String? value) {
                            if (value != null) {
                              setState(() {
                                selectedColorName = value;
                                int index = colorNames.indexOf(value);
                                selectedColor = availableColors[index];
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Preview area
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.grey.shade600),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    _textController.text.isEmpty ? 'Preview Text' : _textController.text,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: selectedColor,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          color: selectedColor.withOpacity(0.9),
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        ),
                        Shadow(
                          color: selectedColor.withOpacity(0.7),
                          blurRadius: 20,
                          offset: const Offset(0, 0),
                        ),
                        Shadow(
                          color: selectedColor.withOpacity(0.5),
                          blurRadius: 30,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              const Spacer(),
              
              // Button
              ElevatedButton(
                onPressed: () {
                  if (_textController.text.trim().isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScrollScreen(
                          text: _textController.text,
                          color: selectedColor,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter some text to scroll'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'START SCROLLING',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScrollScreen extends StatefulWidget {
  final String text;
  final Color color;

  const ScrollScreen({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  State<ScrollScreen> createState() => _ScrollScreenState();
}

class _ScrollScreenState extends State<ScrollScreen> with WidgetsBindingObserver {
  late ScrollController _scrollController;
  Timer? _timer;
  bool _isScrolling = true;
  double _scrollPosition = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addObserver(this);
    _startScrolling();
  }

  void _startScrolling() {
    _timer?.cancel();
    
    const duration = Duration(milliseconds: 30);
    const scrollStep = 2.0;
    
    _timer = Timer.periodic(duration, (timer) {
      if (!_isScrolling || !mounted) return;
      
      if (_scrollController.hasClients) {
        _scrollPosition += scrollStep;
        
        // If we've scrolled past the end, reset to start
        if (_scrollPosition >= _scrollController.position.maxScrollExtent) {
          _scrollPosition = 0;
          _scrollController.jumpTo(0);
        } else {
          _scrollController.jumpTo(_scrollPosition);
        }
      }
    });
  }

  void _toggleScrolling() {
    setState(() {
      _isScrolling = !_isScrolling;
      if (_isScrolling) {
        _startScrolling();
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _isScrolling) {
      _startScrolling();
    } else if (state == AppLifecycleState.paused) {
      _timer?.cancel();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('LED Scroller'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_isScrolling ? Icons.pause : Icons.play_arrow),
            onPressed: _toggleScrolling,
            tooltip: _isScrolling ? 'Pause Scrolling' : 'Resume Scrolling',
          ),
        ],
      ),
      body: Center(
        child: Container(
          height: 100, // Fixed height for the LED display
          color: Colors.black,
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: Row(
              children: [
                // Add empty space at the beginning to create the scrolling-in effect
                SizedBox(width: MediaQuery.of(context).size.width),
                
                // The scrolling text
                Text(
                  widget.text,
                  style: GoogleFonts.dotGothic16(
                    
                    color: widget.color,
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                        color: widget.color.withOpacity(0.9),
                        blurRadius: 10,
                        offset: const Offset(0, 0),
                      ),
                      Shadow(
                        color: widget.color.withOpacity(0.7),
                        blurRadius: 20,
                        offset: const Offset(0, 0),
                      ),
                      Shadow(
                        color: widget.color.withOpacity(0.5),
                        blurRadius: 30,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                ),
                
                // Add empty space at the end to create the scrolling-out effect
                SizedBox(width: MediaQuery.of(context).size.width),
              ],
            ),
          ),
        ),
      ),
    );
  }
}