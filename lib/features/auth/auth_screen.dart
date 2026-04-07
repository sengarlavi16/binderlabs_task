import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:binder_os_app/core/theme/app_theme.dart';
import '../../widgets/background.dart';
import '../../widgets/input.dart';
import '../dashboard/dashboard_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /// 🔥 REGISTER
  Future<void> register() async {
    if (passwordController.text != confirmPasswordController.text) {
      _showMsg("Passwords do not match");
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("name", nameController.text);
    await prefs.setString("email", emailController.text);
    await prefs.setString("password", passwordController.text);

    _showMsg("Registered Successfully");

    setState(() {
      isLogin = true;
    });
  }

  /// 🔥 LOGIN
  Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();

    final savedEmail = prefs.getString("email");
    final savedPassword = prefs.getString("password");
    final name = prefs.getString("name") ?? "User";

    if (emailController.text == savedEmail &&
        passwordController.text == savedPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => DashboardScreen(name: name),
        ),
      );
    } else {
      _showMsg("Invalid Credentials");
    }
  }

  void _showMsg(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 380,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  /// TABS
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border:
                          Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Row(
                      children: [
                        _tabButton("Login", true),
                        _tabButton("Register", false),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child:
                        isLogin ? _buildLogin() : _buildRegister(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabButton(String text, bool tabLogin) {
    final isActive = isLogin == tabLogin;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => isLogin = tabLogin),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primary
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color:
                    isActive ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// LOGIN UI
  Widget _buildLogin() {
    return Column(
      key: const ValueKey("login"),
      children: [
        const Text("Welcome Back",
            style:
                TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
        const SizedBox(height: 20),

        TextField(controller: emailController, decoration: inputDecoration("Email")),
        const SizedBox(height: 14),

        TextField(
          controller: passwordController,
          decoration: inputDecoration("Password"),
          obscureText: true,
        ),

        const SizedBox(height: 20),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: login,
          child: const Text("SIGN IN",
              style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  /// REGISTER UI
  Widget _buildRegister() {
    return Column(
      key: const ValueKey("register"),
      children: [
        const Text("Create Account",
            style:
                TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
        const SizedBox(height: 20),

        TextField(controller: nameController, decoration: inputDecoration("Name")),
        const SizedBox(height: 14),

        TextField(controller: emailController, decoration: inputDecoration("Email")),
        const SizedBox(height: 14),

        TextField(
          controller: passwordController,
          decoration: inputDecoration("Password"),
          obscureText: true,
        ),
        const SizedBox(height: 14),

        TextField(
          controller: confirmPasswordController,
          decoration: inputDecoration("Confirm Password"),
          obscureText: true,
        ),

        const SizedBox(height: 20),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: register,
          child: const Text("SIGN UP",
              style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}