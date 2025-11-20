import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/data/models/auth_controller.dart';
import '/data/models/favorite_controller.dart';
import '/data/services/api_service.dart';
import '../widgets/input_field.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_footer.dart';
import '../pages/signup_page.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    
    final ApiService apiService = ApiService();

    Future<void> loginUser(
      BuildContext context,
      String email,
      String password,
    ) async {
      final messenger = ScaffoldMessenger.of(context);

      if (email.isEmpty || password.isEmpty) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text('Email dan password tidak boleh kosong'),
          ),
        );
        return;
      }

      try {
        final response = await apiService.login(email, password);
        final data = response.data;

        if (response.statusCode == 200) {
          final String token = data['data']['token'];
          final String userName = data['data']['user']['full_name'];
          final String userEmail = data['data']['user']['email'];

          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          await prefs.setString('userName', userName);
          await prefs.setString('userEmail', userEmail);
          
          Get.find<AuthController>().loadInitialData();
          Get.find<FavoriteController>().fetchFavorites();
          
          messenger.showSnackBar(
            SnackBar(content: Text('Login berhasil: $userName')),
          );
          Get.offAllNamed('/home');
        }
      } on DioException catch (e) {
        String errorMessage = 'Login gagal';
        if (e.response != null) {
          errorMessage = e.response?.data['message'] ?? 'Login gagal';
        } else {
          errorMessage = 'Terjadi kesalahan:${e.message}';
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AuthHeader(
                  title: 'Sign In',
                  subtitle: 'Enter valid email & password to continue',
                ),
                const SizedBox(height: 32),
                InputField(hintText: 'Email', controller: emailController),
                const SizedBox(height: 16),
                InputField(
                  hintText: 'Password',
                  controller: passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: AuthButton(
                    text: 'Login',
                    onPressed: () {
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();
                      loginUser(context, email, password);
                    },
                  ),
                ),
                const SizedBox(height: 24),
                AuthFooter(
                  question: "Haven't any account? ",
                  actionText: 'Sign up',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignUpScreen()),
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