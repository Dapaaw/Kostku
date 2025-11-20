import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/services/api_service.dart';
import '../widgets/input_field.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_header.dart';
import '../widgets/terms_text.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fullNameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final ApiService apiService = ApiService();

    Future<void> registerUser(
      BuildContext context,
      String fullName,
      String email,
      String password,
    ) async {
      final messenger = ScaffoldMessenger.of(context);
      final navigator = Navigator.of(context);

      if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
        messenger.showSnackBar(
          const SnackBar(content: Text('Semua field harus diisi')),
        );
        return;
      }

      try {
        final response = await apiService.register(
          fullName: fullName,
          email: email,
          password: password,
        );
        final data = response.data;

        if (response.statusCode == 201) {
          final String token = data['data']['token'];

          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);

          messenger.showSnackBar(
            const SnackBar(
              content: Text('Akun berhasil dibuat! Anda otomatis login.'),
            ),
          );
          navigator.pushReplacementNamed('/');
        }
      } on DioException catch (e) {
        String errorMessage = 'Register gagal';
        if (e.response != null) {
          errorMessage = e.response?.data['message'] ?? 'Register gagal';
        } else {
          errorMessage = 'Terjadi kesalahan: ${e.message}';
        }
        messenger.showSnackBar(SnackBar(content: Text(errorMessage)));
      } catch (e) {
        messenger.showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan: $e')),
        );
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const AuthHeader(
                  title: 'Sign Up',
                  subtitle: 'Use paper information to continue',
                ),
                const SizedBox(height: 32),
                InputField(
                  hintText: 'Full name',
                  controller: fullNameController,
                ),
                const SizedBox(height: 16),
                InputField(hintText: 'Email', controller: emailController),
                const SizedBox(height: 16),
                InputField(
                  hintText: 'Password',
                  controller: passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                const TermsText(),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: AuthButton(
                    text: 'Create Account',
                    onPressed: () {
                      final fullName = fullNameController.text.trim();
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();
                      registerUser(context, fullName, email, password);
                    },
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
