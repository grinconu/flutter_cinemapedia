import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  

  Stream<String> getMessage() {
    final messages = [
    'Loading...',
    'Please wait...',
    'calling to my girlfriend...',
    'I am waiting for you...',
    'this is too much...',
  ];

    return Stream.periodic(const Duration(milliseconds: 1000), (i) {
      return messages[i];
    }).take(messages.length);
  }

  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('loading...'),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 10),
          StreamBuilder(stream: getMessage(), builder: (context, snapshot) {
            if(!snapshot.hasData) return const Text('Loading...');
            return Text(snapshot.data!);
          }),
        ],
      ),
    );
  }
}
