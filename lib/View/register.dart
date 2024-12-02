import 'package:flutter/material.dart';
import 'package:guidedlayout2_1748/View/login.dart';
import 'package:guidedlayout2_1748/component/form_component.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String _gender = "Male"; // Default gender

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Header Text
                const Text(
                  'Hey there,',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
                const Text(
                  'Create an Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),

                // Form container with gradient background
                Container(
                  width: 350,
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFB0E0E6), Color(0xFFE0BBE4)], // Soft pastel gradient
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Username
                        inputForm(
                          (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'Username tidak boleh kosong';
                            }
                            return null;
                          },
                          controller: usernameController,
                          hintTxt: "User",
                          helperTxt: "",
                          iconData: Icons.person,
                        ),
                        const SizedBox(height: 15),

                        // Email
                        inputForm(
                          (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            return null;
                          },
                          controller: emailController,
                          hintTxt: "Email",
                          helperTxt: "",
                          iconData: Icons.email,
                        ),
                        const SizedBox(height: 15),

                        // Password
                        inputForm(
                          (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            return null;
                          },
                          controller: passwordController,
                          hintTxt: "Password",
                          helperTxt: "",
                          iconData: Icons.lock,
                          password: true,
                        ),
                        const SizedBox(height: 15),

                        // Weight with KG button
                        Row(
                          children: [
                            Expanded(
                              child: inputForm(
                                (p0) {
                                  if (p0 == null || p0.isEmpty) {
                                    return 'Weight tidak boleh kosong';
                                  }
                                  return null;
                                },
                                controller: weightController,
                                hintTxt: "Your Weight",
                                helperTxt: "",
                                iconData: Icons.monitor_weight,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                              decoration: BoxDecoration(
                                color: Color(0xFFF06292),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                "KG",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // Height with CM button
                        Row(
                          children: [
                            Expanded(
                              child: inputForm(
                                (p0) {
                                  if (p0 == null || p0.isEmpty) {
                                    return 'Height tidak boleh kosong';
                                  }
                                  return null;
                                },
                                controller: heightController,
                                hintTxt: "Your Height",
                                helperTxt: "",
                                iconData: Icons.height,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                              decoration: BoxDecoration(
                                color: Color(0xFFBA68C8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                "CM",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),

                        // Gender Selection
                        inputForm(
                          (p0) => null,
                          controller: TextEditingController(),
                          hintTxt: "Choose Gender",
                          helperTxt: "",
                          iconData: Icons.transgender,
                        ),
                        const SizedBox(height: 12),

                        // Gender Radio Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio<String>(
                              value: 'Male',
                              groupValue: _gender,
                              onChanged: (String? value) {
                                setState(() {
                                  _gender = value!;
                                });
                              },
                            ),
                            const Text('Male'),
                            Radio<String>(
                              value: 'Female',
                              groupValue: _gender,
                              onChanged: (String? value) {
                                setState(() {
                                  _gender = value!;
                                });
                              },
                            ),
                            const Text('Female'),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Register Button
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Map<String, dynamic> formData = {
                                'username': usernameController.text,
                                'email': emailController.text,
                                'password': passwordController.text,
                                'weight': weightController.text,
                                'height': heightController.text,
                                'gender': _gender,
                              };
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LoginView(data: formData),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Color(0xFF6A5ACD),
                            elevation: 8,
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // Divider and Login link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Or", style: TextStyle(color: Colors.grey)),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginView()),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Color(0xFF8A2BE2)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
