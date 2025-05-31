import 'dart:convert';

import 'package:feel_better_fixed/dao/confetti_widget.dart';
import 'package:feel_better_fixed/dao/message.dart';
import 'package:feel_better_fixed/dao/questions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

const BASE_URL =
    'https://ridiculous-velma-vampior-d41cea67.koyeb.app/api/v1/chat';

class ChatTab extends StatefulWidget {
  const ChatTab({super.key});

  @override
  State<ChatTab> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatTab> {
  bool _isLoading = false;
  bool _hasStarted = false;
  Question? _currentQuestion;
  String? _error;

  bool _isFinished = false;
  String _finalMsg = '';
  String _status = '';

  final TextEditingController _answerController = TextEditingController();

  Future<void> _startChat() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await http.post(
        Uri.parse('$BASE_URL/first'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': FirebaseAuth.instance.currentUser?.email}),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        print('==========Response data===================: $jsonData');
        setState(() {
          _currentQuestion = Question.fromJson(jsonData);
          _hasStarted = true;
          _isLoading = false;
        });
      } else {
        setState(() {
          _error =
              'Failed to load question. Status code: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error connecting to server: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _getNextQuestion({required dynamic answer}) async {
    if (_currentQuestion == null) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await http.post(
        Uri.parse('$BASE_URL/respond'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': FirebaseAuth.instance.currentUser?.email,
          'q_no': _currentQuestion!.qID,
          'answer': answer,
        }),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (_currentQuestion!.qID == 13) {
          setState(() {
            _isFinished = true;
            _finalMsg = 'Thank you for chatting!';
            _status = jsonData['status'] ?? '';
            _isLoading = false;
          });
        } else {
          setState(() {
            _currentQuestion = Question.fromJson(jsonData);
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _error =
              'Failed to load next question. Status code: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error connecting to server: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return Center(
        child: const CircularProgressIndicator(color: Colors.green),
      );
    }

    if (_isFinished) {
      return Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _finalMsg,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  'Status: $_status',
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            ConfettiDesignWidget(),
          ],
        ),
      );
    }

    if (_error != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Error: $_error',
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _startChat,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Try Again',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      );
    }

    if (!_hasStarted) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Start a new chat',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'With ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 5),
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.smart_toy,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 5),
                const Text(
                  'Mindy',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CD964),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startChat,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Start Chat',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }

    // Show question and answer buttons
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Text(
              _currentQuestion?.text ?? 'No question available',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        const SizedBox(height: 30),
        ..._buildAnswerButtons(),
      ],
    );
  }

  List<Widget> _buildAnswerButtons() {
    if (_currentQuestion == null) {
      return [
        const Text(
          'No answers available',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ];
    }

    if (_currentQuestion != null && _currentQuestion!.answers.isEmpty) {
      return [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _answerController,

                decoration: InputDecoration(
                  hintText: 'Enter an answer...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
                onSubmitted: (value) {
                  int ans = 0;
                  try {
                    ans = int.parse(value.trim());
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a valid number'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  if (ans != 0) {
                    _getNextQuestion(answer: double.parse(ans.toString()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a valid number'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                int ans = 0;
                try {
                  ans = int.parse(_answerController.text.trim());
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid number'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                if (ans != 0) {
                  _getNextQuestion(answer: double.parse(ans.toString()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid number'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ],
        ),
      ];
    }

    // if (_currentQuestion == null || _currentQuestion!.answers.isEmpty) {
    //   return [
    //     const Text(
    //       'No answers available',
    //       style: TextStyle(fontSize: 16),
    //       textAlign: TextAlign.center,
    //     ),
    //   ];
    // }

    return _currentQuestion!.answers.map((answer) {
      // Get the first key from the map as the answer text
      String answerText = answer.keys.first;
      int answerValue = answer[answerText] ?? 0;

      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: ElevatedButton(
          onPressed: () {
            if (answerText.isNotEmpty) {
              _getNextQuestion(answer: answerText);
            }
            // Here you would handle the answer selection
            // For example, send the selected answer to the server

            print('Selected answer: $answerText with value: $answerValue');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.grey[300]!),
            ),
            elevation: 2,
          ),
          child: Text(answerText, style: const TextStyle(fontSize: 16)),
        ),
      );
    }).toList();
  }
}

// class ChatTab extends StatefulWidget {
//   const ChatTab({super.key});

//   @override
//   State<ChatTab> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatTab> {
//   final TextEditingController _controller = TextEditingController();
//   final List<Message> _messages = [];
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();

//     _messages.addAll([
//       Message(
//         text: 'Hi Mindy 👋',
//         isMe: true,
//         timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
//       ),

//       Message(
//         text: "I'm down! Any questions??",
//         isMe: false,
//         timestamp: DateTime.now(),
//         sender: 'Mindy',
//         senderRole: '',
//         isBot: true,
//       ),
//       // Message(
//       //   text: 'Let me know about you',
//       //   isMe: false,
//       //   timestamp: DateTime.now(),
//       //   sender: 'Jav',
//       //   senderRole: 'Engineering',
//       //   isBot: true,
//       // ),
//       // Message(text: 'okay', isMe: true, timestamp: DateTime.now()),
//       // Message(text: '', isMe: true, timestamp: DateTime.now()),
//       // Message(
//       //   text: 'Where you living?',
//       //   isMe: false,
//       //   timestamp: DateTime.now(),
//       //   sender: 'Jav',
//       //   senderRole: 'Engineering',
//       //   isBot: true,
//       // ),
//       // Message(text: 'Kurunegala', isMe: true, timestamp: DateTime.now()),
//     ]);
//   }

//   void _sendMessage() {
//     if (_controller.text.trim().isNotEmpty) {
//       setState(() {
//         _messages.add(
//           Message(
//             text: _controller.text,
//             isMe: true,
//             timestamp: DateTime.now(),
//           ),
//         );
//         _controller.clear();
//       });

//       // Scroll to bottom after sending message
//       Future.delayed(const Duration(milliseconds: 100), () {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Column(
//         children: [
//           // Chat header
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//             alignment: Alignment.centerLeft,
            // child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     const Text(
            //       'Start a new chat',
            //       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            //     ),
            //     Row(
            //       children: [
            //         const Text(
            //           'With ',
            //           style: TextStyle(
            //             fontSize: 24,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //         const SizedBox(width: 5),
            //         Container(
            //           width: 24,
            //           height: 24,
            //           decoration: const BoxDecoration(
            //             color: Colors.black,
            //             shape: BoxShape.circle,
            //           ),
            //           child: const Icon(
            //             Icons.smart_toy,
            //             color: Colors.white,
            //             size: 16,
            //           ),
            //         ),
            //         const SizedBox(width: 5),
            //         const Text(
            //           'Mindy',
            //           style: TextStyle(
            //             fontSize: 24,
            //             fontWeight: FontWeight.bold,
            //             color: Color(0xFF4CD964),
            //           ),
            //         ),
            //       ],
            //     ),
//               ],
//             ),
//           ),

//           // Chat messages
//           Expanded(
//             child: ListView.builder(
//               controller: _scrollController,
//               padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 final message = _messages[index];
//                 final showSender =
//                     message.sender != null &&
//                     (index == 0 ||
//                         _messages[index - 1].sender != message.sender);

//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 8),
//                   child: Column(
//                     crossAxisAlignment: message.isMe
//                         ? CrossAxisAlignment.end
//                         : CrossAxisAlignment.start,
//                     children: [
//                       if (showSender && !message.isMe)
//                         Padding(
//                           padding: const EdgeInsets.only(left: 8, bottom: 4),
//                           child: Row(
//                             children: [
//                               Text(
//                                 message.sender!,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                               const SizedBox(width: 5),
//                               Text(
//                                 message.senderRole!,
//                                 style: const TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       Row(
//                         mainAxisAlignment: message.isMe
//                             ? MainAxisAlignment.end
//                             : MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           if (!message.isMe && message.isBot)
//                             Container(
//                               margin: const EdgeInsets.only(
//                                 right: 8,
//                                 bottom: 4,
//                               ),
//                               width: 20,
//                               height: 20,
//                               decoration: const BoxDecoration(
//                                 color: Colors.black,
//                                 shape: BoxShape.circle,
//                               ),
//                               child: const Icon(
//                                 Icons.smart_toy,
//                                 color: Colors.white,
//                                 size: 14,
//                               ),
//                             ),
//                           Flexible(
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 16,
//                                 vertical: 10,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: message.isMe
//                                     ? const Color(0xFF007AFF)
//                                     : const Color(0xFFEFEFF4),
//                                 borderRadius: BorderRadius.circular(18),
//                               ),
//                               child: Text(
//                                 message.text,
//                                 style: TextStyle(
//                                   color: message.isMe
//                                       ? Colors.white
//                                       : Colors.black,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           Text(
//                             DateFormat('h:mm a').format(message.timestamp),
//                             style: const TextStyle(
//                               color: Colors.grey,
//                               fontSize: 12,
//                             ),
//                           ),
//                           if (message.isMe)
//                             const Icon(
//                               Icons.check,
//                               size: 14,
//                               color: Colors.blue,
//                             ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),

//           // Message input
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.1),
//                   spreadRadius: 1,
//                   blurRadius: 3,
//                   offset: const Offset(0, -1),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(
//                       hintText: 'Type a message...',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(24),
//                         borderSide: BorderSide.none,
//                       ),
//                       filled: true,
//                       fillColor: Colors.grey[200],
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 10,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 CircleAvatar(
//                   backgroundColor: _controller.text.isEmpty
//                       ? Colors.grey[300]
//                       : Colors.blue,
//                   child: IconButton(
//                     icon: const Icon(Icons.send),
//                     color: Colors.white,
//                     onPressed: _sendMessage,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
