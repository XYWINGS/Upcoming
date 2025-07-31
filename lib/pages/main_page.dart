import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold( 
      appBar: AppBar(
        title: const Text('Upcoming Movies'),
      ),
      body: Center(
        child: Text(
          'Welcome to the Upcoming Movies App!',
          style: TextStyle(fontSize: 24, color: Colors.deepPurple),
        ),
      ),
    );
  }
}
