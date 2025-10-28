import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../pages/login_page.dart';
import '../widgets/input_field.dart';
import '../widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  Future<void> registerUser(
    BuildContext context,
    String fullName,
    String email,
    String password,
  ) async {
    if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Semua field harus diisi')));
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'full_name': fullName,
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Akun berhasil dibuat'),
          ),
        );
      Navigator.pushReplacementNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Gagal membuat akun')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final FullNameController = TextEditingController();
    final EmailController = TextEditingController();
    final PasswordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Use paper information to continue',
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
                const SizedBox(height: 32),
                InputField(
                  hintText: 'Full name',
                  controller: FullNameController,
                ),
                const SizedBox(height: 16),
                InputField(hintText: 'Email', controller: EmailController),
                const SizedBox(height: 16),
                InputField(
                  hintText: 'Password',
                  controller: PasswordController,
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                const Text.rich(
                  TextSpan(
                    text: 'By signing up, you agree to our ',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                    children: [
                      TextSpan(
                        text: 'Terms & Conditions',
                        style: TextStyle(
                          color: Color(0xFF1D3557),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          color: Color(0xFF1D3557),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: AuthButton(
                    text: 'Create Account',
                    onPressed: () {
                      final fullName = FullNameController.text.trim();
                      final email = EmailController.text.trim();
                      final password = PasswordController.text.trim();
                      registerUser(context, fullName, email, password);
                    }
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
