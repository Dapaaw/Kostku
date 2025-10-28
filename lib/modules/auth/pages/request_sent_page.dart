import 'package:flutter/material.dart';
import '../widgets/auth_button.dart';

class RequestSentPage extends StatelessWidget {
  const RequestSentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                const Text(
                  'Request Sent !',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF173A67),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Thank you for your request.\n'
                  'A verification code is being sent, please check\n'
                  'your inbox (or spam/junk folder) to retrieve the code.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF2F2F2F),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: AuthButton(
                    text: 'Back to Login',
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
