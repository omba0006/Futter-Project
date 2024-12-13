
import 'package:flutter/material.dart';

class ShareCodeScreen extends StatefulWidget {
  const ShareCodeScreen({super.key});

  @override
  State<ShareCodeScreen> createState() => _ShareCodeScreenState();
}

class _ShareCodeScreenState extends State<ShareCodeScreen> {
  String code = '1234'; // Hardcoded code for testing purposes
  bool isLoading = false; // Since we have a hardcoded code, no need to load

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Code'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          'Your Code: $code',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
