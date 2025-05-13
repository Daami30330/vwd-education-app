import 'dart:math';
import 'package:flutter/material.dart';


void main() => runApp(const VWDApp());

class VWDApp extends StatelessWidget {
  const VWDApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn VWD',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: const Text('Welcome to Learn VWD'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_florist, size: 150, color: Colors.pink),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.pink[400],
                foregroundColor: Colors.white,
              ),
              child: const Text('Start Learning', style: TextStyle(fontSize: 18)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PetalRevealScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PetalRevealScreen extends StatefulWidget {
  const PetalRevealScreen({Key? key}) : super(key: key);

  @override
  _PetalRevealScreenState createState() => _PetalRevealScreenState();
}

class _PetalRevealScreenState extends State<PetalRevealScreen> {
  final List<bool> _revealed = List.filled(6, false);
  final List<String> _facts = [
    "VWD is a bleeding disorder",
    "It affects blood clotting",
    "It's often inherited",
    "Bruising happens easily",
    "Treatments can help",
    "It's different from hemophilia"
  ];

  bool get allRevealed => _revealed.every((revealed) => revealed);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      body: Stack(
        children: [
          // Sky gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFB3E5FC), Color(0xFFE3F2FD)],
              )),
          ),

          // Sun with rays
          const Positioned(
            top: 40,
            right: 40,
            child: SunWithRays(),
          ),

          // Stem (positioned behind petals)
          Positioned(
            bottom: 100,
            left: MediaQuery.of(context).size.width / 2 - 3,
            child: Container(
              width: 6,
              height: 180,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.green[600]!, Colors.green[800]!],
                ),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),

          // Flower (positioned above stem)
          Center(
            child: SizedBox(
              width: 320,
              height: 320,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ...List.generate(6, (index) {
                    final angle = index * 60.0;
                    final radians = angle * pi / 180;
                    return Positioned(
                      left: 110 + 110 * sin(radians),
                      top: 110 + 110 * cos(radians),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setState(() {
                            _revealed[index] = true;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOutBack,
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: _revealed[index]
                                ? _getPetalColor(index)
                                : Colors.grey[200],
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3))
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _revealed[index] ? _facts[index] : '?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: _revealed[index]
                                    ? Colors.white
                                    : Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const RadialGradient(
                        colors: [Colors.yellow, Colors.orange],
                        radius: 0.8,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.5),
                          blurRadius: 15,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Text('🌼', style: TextStyle(fontSize: 30)),
                  ),
                ],
              ),
            ),
          ),

          // Ground with grass
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF5D4037),
                border: Border(
                  top: BorderSide(
                    color: Colors.green[800]!,
                    width: 20,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
          ),

          // Continue button
          if (allRevealed)
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.pink[400],
                    foregroundColor: Colors.white,
                    elevation: 8,
                    shadowColor: Colors.pink.withOpacity(0.5),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QuizScreen()),
                    );
                  },
                  child: const Text("Continue to Quiz",
                      style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _getPetalColor(int index) {
    final colors = [
      Colors.pink[400]!,
      Colors.purple[400]!,
      Colors.deepPurple[400]!,
      Colors.blue[400]!,
      Colors.lightBlue[400]!,
      Colors.cyan[400]!,
    ];
    return colors[index % colors.length];
  }
}

class SunWithRays extends StatelessWidget {
  const SunWithRays({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [Colors.orange[100]!, Colors.orange[400]!],
              stops: [0.1, 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 5,
              )
            ],
          ),
        ),
        ...List.generate(8, (index) {
          final angle = index * (2 * pi / 8);
          return Transform.rotate(
            angle: angle,
            child: Container(
              width: 100,
              height: 4,
              color: Colors.orange[200],
            ),
          );
        }),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [Colors.orange[300]!, Colors.deepOrange[400]!],
            ),
          ),
        ),
      ],
    );
  }
}


class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<String> correctFacts = [
    "VWD is a bleeding disorder",
    "It affects blood clotting",
    "It's often inherited",
    "Bruising happens easily",
    "Treatments can help",
    "It's different from hemophilia"
  ];

  final List<String> incorrectFacts = [
    "It gives you superpowers",
    "It's caused by weather",
    "It helps blood clot faster",
    "VWD is a new video game",
  ];

  final Map<int, String> placedAnswers = {}; // index of petal -> fact
  late final List<String> allFacts;

  @override
  void initState() {
    super.initState();
    allFacts = [...correctFacts, ...incorrectFacts]..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final remainingFacts = allFacts
        .where((fact) => !placedAnswers.containsValue(fact))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('VWD Quiz'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              'Drag the correct facts onto the flower petals!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 20,
              runSpacing: 20,
              children: List.generate(6, (index) {
                return DragTarget<String>(
                  builder: (context, candidateData, rejectedData) {
                    final isFilled = placedAnswers.containsKey(index);
                    final fact = placedAnswers[index];

                    return Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isFilled ? Colors.green[300] : Colors.grey[200],
                        border: Border.all(color: Colors.pink, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        isFilled ? fact! : 'Drop Here',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  },
                  onWillAccept: (data) {
                    return correctFacts.contains(data!) &&
                        !placedAnswers.containsValue(data);
                  },
                  onAccept: (data) {
                    setState(() {
                      placedAnswers[index] = data;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 40),
            const Text('Fact Choices:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: remainingFacts.map((fact) {
                return Draggable<String>(
                  data: fact,
                  feedback: Material(
                    color: Colors.transparent,
                    child: Chip(
                      label: Text(fact),
                      backgroundColor: Colors.amber,
                      elevation: 4,
                    ),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.4,
                    child: Chip(
                      label: Text(fact),
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                  child: Chip(
                    label: Text(fact),
                    backgroundColor: Colors.cyan[100],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            if (placedAnswers.length == 6)
              ElevatedButton(
                onPressed: () {
                  final allCorrect = placedAnswers.values
                      .every((fact) => correctFacts.contains(fact));

                  if (allCorrect) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EmergencyGameScreen(),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Oops!"),
                        content: const Text("Some answers are incorrect. Try again!"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Okay"),
                          ),
                        ],
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Submit Quiz"),
              ),
          ],
        ),
      ),
    );
  }
}





class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({Key? key}) : super(key: key);

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final List<Map<String, String>> messages = [
    {'sender': 'bot', 'text': "Hi there! I'm Clotty, your health buddy! 🩸"},
    {'sender': 'bot', 'text': "Great job finishing your quiz today! 🎉"},
    {'sender': 'bot', 'text': "How are you feeling right now?"}
  ];

  final List<String> feelings = ["😊 Good", "😐 Okay", "😢 Not great"];
  bool showFeelings = true;
  bool showChecklist = false;

  final Map<String, bool> checklistItems = {
    "💧 Drink water": false,
    "💊 Take your medicine": false,
    "📋 Log symptoms": false,
    "🧘‍♀️ Take a deep breath": false,
  };

  final Map<String, bool> symptomLog = {
    "😴 Feeling tired": false,
    "🤕 Headache": false,
    "🤒 Fever": false,
    "👃 Nosebleed": false,
    "🦵 Joint pain": false,
    "🤧 Sneezing or cold": false,
  };

  void respondToFeeling(String feeling) {
    String response;

    switch (feeling) {
      case "😊 Good":
        response = "That's awesome! Let's keep your body strong today 💪";
        break;
      case "😐 Okay":
        response = "That's okay. A little rest might help you feel better. 🍎";
        break;
      case "😢 Not great":
        response = "I'm sorry to hear that. Be sure to tell an adult ❤️";
        break;
      default:
        response = "Thanks for sharing!";
    }

    setState(() {
      showFeelings = false;
      showChecklist = true;
      messages.add({'sender': 'user', 'text': feeling});
      messages.add({'sender': 'bot', 'text': response});
      messages.add({'sender': 'bot', 'text': "Here’s your healthy checklist for today:"});
    });
  }

  void toggleChecklistItem(String task) {
    if (task == "📋 Log symptoms") {
      showSymptomPopup();
      return;
    }

    setState(() {
      checklistItems[task] = !(checklistItems[task]!);
    });

    if (checklistItems.values.every((done) => done)) {
      messages.add({
        'sender': 'bot',
        'text': "✅ You completed your checklist today! I'm proud of you! 🎉"
      });
    }
  }

  void showSymptomPopup() async {
    final selected = await showDialog<List<String>>(
      context: context,
      builder: (_) {
        final Map<String, bool> temp = {...symptomLog};

        return AlertDialog(
          title: const Text("Log your symptoms"),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: temp.keys.map((symptom) {
                  return CheckboxListTile(
                    title: Text(symptom),
                    value: temp[symptom],
                    onChanged: (val) => setState(() => temp[symptom] = val!),
                  );
                }).toList(),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, temp.entries
                    .where((entry) => entry.value)
                    .map((e) => e.key)
                    .toList());
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );

    if (selected != null && selected.isNotEmpty) {
      setState(() {
        for (var s in selected) {
          symptomLog[s] = true;
        }
        checklistItems["📋 Log symptoms"] = true;

        messages.add({'sender': 'user', 'text': "Logged symptoms ✅"});
        messages.add({
          'sender': 'bot',
          'text': "Thanks for logging your symptoms. Here's what I noticed:"
        });
        messages.add({
          'sender': 'bot',
          'text': selected.join(", ")
        });

        if (selected.contains("🤕 Headache") || selected.contains("👃 Nosebleed")) {
          messages.add({
            'sender': 'bot',
            'text': "Make sure to rest and let a parent or doctor know. 🩺"
          });
        } else {
          messages.add({
            'sender': 'bot',
            'text': "Thanks for checking in. Keep taking care of yourself! 💖"
          });
        }
      });
    }
  }

  void restartChat() {
    setState(() {
      messages.clear();
      checklistItems.updateAll((key, value) => false);
      symptomLog.updateAll((key, value) => false);
      messages.addAll([
        {'sender': 'bot', 'text': "Hi again! It's Clotty 🩸"},
        {'sender': 'bot', 'text': "Just checking in — how are you feeling now?"}
      ]);
      showFeelings = true;
      showChecklist = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat with Clotty"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Restart Chat',
            onPressed: restartChat,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isBot = msg['sender'] == 'bot';

                return Align(
                  alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    constraints: const BoxConstraints(maxWidth: 280),
                    decoration: BoxDecoration(
                      color: isBot ? Colors.pink[100] : Colors.lightBlue[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      msg['text']!,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),

          if (showFeelings)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Wrap(
                spacing: 12,
                children: feelings.map((feeling) {
                  return ElevatedButton(
                    onPressed: () => respondToFeeling(feeling),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[300],
                      foregroundColor: Colors.white,
                    ),
                    child: Text(feeling),
                  );
                }).toList(),
              ),
            ),

          if (showChecklist)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: checklistItems.keys.map((task) {
                  final done = checklistItems[task]!;
                  return CheckboxListTile(
                    title: Text(task,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          decoration: done ? TextDecoration.lineThrough : null,
                        )),
                    value: done,
                    activeColor: Colors.pink,
                    onChanged: (_) => toggleChecklistItem(task),
                  );
                }).toList(),
              ),
            ),

          if (showChecklist)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton.icon(
                onPressed: restartChat,
                icon: const Icon(Icons.replay),
                label: const Text("Check In Again"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class EmergencyGameScreen extends StatefulWidget {
  const EmergencyGameScreen({Key? key}) : super(key: key);

  @override
  State<EmergencyGameScreen> createState() => _EmergencyGameScreenState();
}

class _EmergencyGameScreenState extends State<EmergencyGameScreen> {
  final List<Map<String, dynamic>> _questions = [
    {
      'question': "🩸 You’re bleeding from your elbow. What should you do?",
      'options': ["Run and panic", "Apply pressure and tell an adult", "Ignore it"],
      'answer': "Apply pressure and tell an adult"
    },
    {
      'question': "👃 You have a nosebleed. What’s the best action?",
      'options': ["Lean forward and pinch your nose", "Lie flat", "Blow your nose hard"],
      'answer': "Lean forward and pinch your nose"
    },
    {
      'question': "💊 You forgot your medicine. What do you do?",
      'options': ["Skip it", "Tell your parent or caregiver", "Take double tomorrow"],
      'answer': "Tell your parent or caregiver"
    },
  ];

  int _currentQuestion = 0;
  String? _selected;
  bool _answeredCorrectly = false;

  void _checkAnswer(String choice) {
    final correct = choice == _questions[_currentQuestion]['answer'];
    setState(() {
      _selected = choice;
      _answeredCorrectly = correct;
    });

    if (!correct) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Oops! Try again!"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _nextQuestion() {
    if (_currentQuestion + 1 < _questions.length) {
      setState(() {
        _currentQuestion++;
        _selected = null;
        _answeredCorrectly = false;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ChatBotScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_currentQuestion];
    final total = _questions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency Game"),
        backgroundColor: Colors.redAccent,
      ),
      body: Stack(
        children: [
          // Background scene
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFB3E5FC), Color(0xFFE3F2FD)],
              ),
            ),
          ),

          // Sun in top-right
          const Positioned(
            top: 20,
            right: 20,
            child: Icon(Icons.wb_sunny, size: 50, color: Colors.orange),
          ),

          // Grass at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              color: const Color(0xFF4CAF50),
            ),
          ),

          // Quiz content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: (_currentQuestion + 1) / total,
                  backgroundColor: Colors.white,
                  color: Colors.redAccent,
                  minHeight: 8,
                ),
                const SizedBox(height: 20),
                Text(
                  "Question ${_currentQuestion + 1} of $total",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 6,
                  color: Colors.white.withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      q['question'],
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ...q['options'].map<Widget>((option) {
                  final isSelected = _selected == option;
                  final isCorrect = option == q['answer'];

                  Color tileColor;
                  if (!isSelected) {
                    tileColor = Colors.white;
                  } else if (_answeredCorrectly) {
                    tileColor = Colors.green[200]!;
                  } else {
                    tileColor = Colors.red[200]!;
                  }

                  return GestureDetector(
                    onTap: () {
                      if (!_answeredCorrectly) _checkAnswer(option);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: tileColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.pink, width: 2),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Text(
                        option,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                }).toList(),
                const SizedBox(height: 30),
                if (_answeredCorrectly)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text("Next Question"),
                    onPressed: _nextQuestion,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                      backgroundColor: Colors.green[600],
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





