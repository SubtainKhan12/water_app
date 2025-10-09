import 'package:flutter/material.dart';
import '../../res/colors.dart';
import '../../res/validator.dart';
import '../../res/widgets/auto_capitalized_textfield.dart';
import '../../res/widgets/round_button.dart';
import '../admin_dashboard_view/dashboard_view.dart';
import '../splash_views/wavy_painter.dart';
import 'forgot_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _waveAnimation;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureCode = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _waveAnimation = Tween<double>(
      begin: -0.1,
      end: 0.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Add your login logic here
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
      print('Login attempted with:');
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      print('Code: ${_codeController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Animated wave background
          AnimatedBuilder(
            animation: _waveAnimation,
            builder: (context, child) {
              return CustomPaint(
                size: Size(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height,
                ),
                painter: WavePainter(_waveAnimation.value),
              );
            },
          ),

          // Content
          SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 80),

                  // App Logo/Icon
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [AppColors.lightSkyBlue, AppColors.primaryBlue],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.shade100,
                          blurRadius: 15,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.waves,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Welcome Text
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryBlue,
                      fontFamily: 'Poppins',
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Sign in to continue your hydration journey',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.skyBlue,
                      fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 40),

                  // Login Form
                  Column(
                    children: [
                      // Email Field
                      _buildTextField(
                        controller: _emailController,
                        label: 'Email Address',
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.validateEmail,
                      ),

                      const SizedBox(height: 20),

                      // Password Field
                      _buildTextField(
                        controller: _passwordController,
                        label: 'Password',
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                        obscureText: _obscurePassword,
                        onToggleObscure: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        validator: Validators.validatePassword,
                      ),

                      const SizedBox(height: 20),

                      // Code Field with auto-capitalization
                      AutoCapitalizeTextField(
                        controller: _codeController,
                        label: 'Security Code',
                        prefixIcon: Icons.security_outlined,
                        isPassword: true,
                        obscureText: _obscureCode,
                        onToggleObscure: () {
                          setState(() {
                            _obscureCode = !_obscureCode;
                          });
                        },
                        validator: Validators.validateSecurityCode,
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: AppColors.skyBlue,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Login Button
                      RoundedButton(text: 'Sign In', onPressed: _login),
                    ],
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData prefixIcon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleObscure,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: AppColors.DarkBlue, fontFamily: 'Poppins'),
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: AppColors.skyBlue,
          fontFamily: 'Poppins',
        ),
        prefixIcon: Icon(prefixIcon, color: AppColors.primaryBlue),
        suffixIcon: isPassword
            ? IconButton(
                onPressed: onToggleObscure,
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.primaryBlue,
                ),
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.lightSkyBlue, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.errorRed, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.errorRed, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        errorStyle: const TextStyle(
          color: AppColors.errorRed,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
