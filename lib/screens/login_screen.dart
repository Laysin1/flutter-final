import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onRegisterTap;
  final VoidCallback onLogin;

  const LoginScreen({
    super.key,
    required this.onRegisterTap,
    required this.onLogin,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _googleLogin() async {
    try {
      setState(() => isLoading = true);
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Welcome ${googleUser.displayName}!')),
        );
        widget.onLogin();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Login Failed: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _facebookLogin() async {
    try {
      setState(() => isLoading = true);
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Welcome ${userData['name']}!')),
        );
        widget.onLogin();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Facebook Login Error: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _emailLogin() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }
    widget.onLogin();
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
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF22223B),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Login to your account',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 40),

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

                  // Email Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _emailLogin,
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
                              'Login with Email',
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

                  // Google Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: OutlinedButton.icon(
                      onPressed: isLoading ? null : _googleLogin,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: const Icon(Icons.login, color: Colors.red),
                      label: const Text(
                        'Login with Google',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Facebook Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: OutlinedButton.icon(
                      onPressed: isLoading ? null : _facebookLogin,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: const Icon(Icons.facebook, color: Colors.blue),
                      label: const Text(
                        'Login with Facebook',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Register Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      GestureDetector(
                        onTap: widget.onRegisterTap,
                        child: const Text(
                          'Register',
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}