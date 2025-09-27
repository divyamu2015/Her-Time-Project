import 'package:animated_input_border/animated_input_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:her_time_project/authantication/login_screen/bloc/login_bloc.dart';
import 'package:her_time_project/authantication/registration_screen/registration_page_view.dart';
import 'package:her_time_project/screens/input_cycle/input_cycle_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  late AnimationController _animationController;
  bool isloading = false;
  final String _selectedUserType = 'user';
  int? userId;
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..forward();
  }

  Future<void> loginState() async {
    print(123);
    FocusScope.of(context).unfocus();
    setState(() {
      isloading = true;
    });
    String emplId = emailController.text.trim();
    String emplPass = passController.text.trim();

    print('after validation');

    if (emplId.isEmpty || emplPass.isEmpty) {
      showError("Please enter all details");
      setState(() => isloading = false);
      return;
    }
    context.read<LoginBloc>().add(
      LoginEvent.userLogin(
        role: _selectedUserType,
        email: emplId,
        password: emplPass,
      ),
    );
  }

  Future<void> storeUserId(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', userId);
    print('User ID stored: $userId');
  }

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('id');
    print("Retrieved User ID: $userId");
    return userId;
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  Widget _buildTextField(
    String label, {
    required TextEditingController controller,
    required String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    // String? label,
  }) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          border: AnimatedInputBorder(
            animationValue: _animationController.value,
          ),
          focusedBorder: AnimatedInputBorder(
            animationValue: _animationController.value,
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(width: 2.0, color: Color(0xFF163A57)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            state.when(
              initial: () {},
              loading: () {
                setState(() {
                  isloading = true;
                });
              },
              success: (response) async {
                await storeUserId(response.userId);
                userId = await getUserId();
                setState(() {
                  isloading = false;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("User login successful"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) {
                        return
                        // ChatScreen(userId: userId!);
                        PeriodInputScreen(userId: userId!);
                      },
                    ),
                  );
                });
              },
              error: (error) {
                setState(() {
                  isloading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Error: $error"),
                    backgroundColor: Colors.red,
                  ),
                );
              },
            );
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: SizedBox(
                height: h,
                width: w,
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //     opacity: 0.4,
                //     fit: BoxFit.fill,
                //     image: AssetImage('assets/images/loogo.jpeg'),
                //   ),
                // ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 55.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Colors.white, Colors.purple.shade50],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 20,
                                offset: Offset(0, 8),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.purple.shade300,
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.all(8),
                          child:
                              ClipOval(
                                child: Image.asset(
                                  "assets/images/logo.JPG",
                                  width: h * 0.25,
                                  height: h * 0.25,
                                  fit: BoxFit.cover,
                                ),
                              ).animate().scale(
                                duration: 3.5.seconds,
                                curve: Curves.easeOutBack,
                              ),
                        ),
                        const SizedBox(height: 20),
                        AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) => Form(
                            key: _fromKey,
                            child: Card(
                              child: Column(
                                children: [
                                  _buildTextField(
                                    "Email",
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter your Email";
                                      }

                                      return null;
                                    },
                                  ),
                                  _buildTextField(
                                    "Password",
                                    //  keyboardType: TextInputType.pas,
                                    controller: passController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter your Password";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ButtonStyle(
                            fixedSize: WidgetStatePropertyAll(
                              Size(w * 0.9, 50),
                            ),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.blueGrey,
                            ),
                          ),
                          onPressed: isloading ? null : loginState,
                          child: isloading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "LOGIN",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return RegistrationPage();
                                },
                              ),
                            );
                          },
                          child: const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: 'Don\'t have an account?'),
                                TextSpan(
                                  text: 'SignUp',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 34, 61, 35),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
