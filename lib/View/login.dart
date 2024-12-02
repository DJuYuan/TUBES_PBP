import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guidedlayout2_1748/View/home.dart';
import 'package:guidedlayout2_1748/View/register.dart';
import 'package:guidedlayout2_1748/component/form_component.dart';

class LoginView extends StatefulWidget {
  final Map? data;
  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  // Controllers untuk field username dan password
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Map<dynamic, dynamic>? dataForm;

  @override
  void initState() {
    super.initState();
    dataForm = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang utama berwarna putih
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Greeting text
                const Text(
                  'Hey there,',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                  ),
                ),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),

                // Container with gradient background
                Container(
                  width: 350,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFB0C4DE), Color(0xFF87CEFA)], // Gradasi warna
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Username input
                        inputForm(
                          (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return "Username tidak boleh kosong";
                            }
                            return null;
                          },
                          controller: usernameController,
                          hintTxt: "User",
                          helperTxt: "",
                          iconData: Icons.person,
                        ),
                        const SizedBox(height: 12),

                        // Email input
                        inputForm(
                          (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return "Email tidak boleh kosong";
                            }
                            return null;
                          },
                          controller: TextEditingController(),
                          hintTxt: "Email",
                          helperTxt: "",
                          iconData: Icons.email,
                        ),
                        const SizedBox(height: 12),

                        // Password input
                        inputForm(
                          (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return "Password tidak boleh kosong";
                            }
                            return null;
                          },
                          controller: passwordController,
                          hintTxt: "Password",
                          helperTxt: "",
                          iconData: Icons.lock,
                          password: true,
                        ),
                        const SizedBox(height: 12),

                        // Forgot password link
                        Center(
                          child: TextButton(
                            onPressed: () {
                              // Tindakan untuk lupa password
                            },
                            child: const Text(
                              'Forgot your password?',
                              style: TextStyle(
                                color: Colors.pinkAccent,
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Login button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF87CEFA),
                    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {
                    // Validasi form
                    if (_formKey.currentState!.validate()) {
                      if (dataForm != null &&
                          dataForm?['username'] == usernameController.text &&
                          dataForm?['password'] == passwordController.text) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HomeView(),
                          ),
                        );
                      } else {
                        // Menampilkan dialog jika login gagal
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Login Gagal'),
                            content: const Text('Username atau password salah.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Divider with "Or"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: Divider(color: Colors.grey)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Or", style: TextStyle(color: Colors.grey)),
                    ),
                    const Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 10),

                // Social login buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red),
                      onPressed: () {
                        // Fungsionalitas login Google
                      },
                    ),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                      onPressed: () {
                        // Fungsionalitas login Facebook
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Register link
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterView()),
                    );
                  },
                  child: const Text(
                    "Don't have an account yet? Register",
                    style: TextStyle(
                      color: Color(0xFF8A2BE2),
                      fontWeight: FontWeight.bold,
                    ),
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
