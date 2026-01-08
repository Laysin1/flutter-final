import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onLoginTap;

  const RegisterScreen({super.key, required this.onLoginTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _googleRegister() async {
    try {
      setState(() => isLoading = true);
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account created with ${googleUser.displayName}!')),
        );
        Future.delayed(const Duration(seconds: 1), widget.onLoginTap);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Registration Failed: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _facebookRegister() async {
    try {
      setState(() => isLoading = true);
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account created with ${userData['name']}!')),
        );
        Future.delayed(const Duration(seconds: 1), widget.onLoginTap);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Facebook Registration Error: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _emailRegister() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Account created successfully!')),
    );
    Future.delayed(const Duration(seconds: 1), widget.onLoginTap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xFFF5F5F5), const Color(0xFFE0E7FF)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // Logo
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF7C3AED),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF7C3AED).withValues(alpha: 0.3),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.wallet,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Title
                  const Text(
                    'Create an Account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF22223B),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Join us and start tracking expenses',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Name Field
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      prefixIcon: const Icon(Icons.person, color: Color(0xFF7C3AED)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFFE0E7FF)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFF7C3AED),
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Email Field
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email, color: Color(0xFF7C3AED)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFFE0E7FF)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFF7C3AED),
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Password Field
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock, color: Color(0xFF7C3AED)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFFE0E7FF)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFF7C3AED),
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Email Register Button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _emailRegister,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7C3AED),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        disabledBackgroundColor: Colors.grey.shade300,
                      ),
                      child: isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              ),
                            )
                          : const Text(
                              'Sign Up with Email',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Divider
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: Colors.grey.shade300),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'Or',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ),
                      Expanded(
                        child: Divider(color: Colors.grey.shade300),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Google Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: OutlinedButton.icon(
                      onPressed: isLoading ? null : _googleRegister,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: const Icon(Icons.login, color: Colors.red),
                      label: const Text(
                        'Sign Up with Google',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Facebook Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: OutlinedButton.icon(
                      onPressed: isLoading ? null : _facebookRegister,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: const Icon(Icons.facebook, color: Colors.blue),
                      label: const Text(
                        'Sign Up with Facebook',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      GestureDetector(
                        onTap: widget.onLoginTap,
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Color(0xFF7C3AED),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}