// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_input_border/animated_input_border.dart';
import 'package:her_time_project/authantication/login_screen/login_view_page.dart';
import 'package:her_time_project/authantication/registration_screen/bloc/register_bloc_bloc.dart';
// Import the phone number field package

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController ageController =
      TextEditingController(); // New controller for Age
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController =
      TextEditingController(); // New controller for Place

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isloading = false;

  get loadFromJson => null;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    ageController.dispose(); // Dispose new controller
    addressController.dispose();
    phoneController.dispose(); // No longer needed for direct use
    super.dispose();
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  Future<void> saveForm() async {
    print(123);
    FocusScope.of(context).unfocus();
    setState(() {
      isloading = true;
    });
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }
    setState(() {
      isloading = true;
    });
    print('after validation');

    print('Validation successful. Dispatching RegisterBlocEvent.');
    context.read<RegisterBlocBloc>().add(
      RegisterBlocEvent.userRegister(
        name: nameController.text,
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        age: ageController.text, // Pass age
        address: addressController.text,
        phone: phoneController.text,
      ),
    );
  }

  Widget _buildTextField(
    String label, {
    required TextEditingController controller,
    required String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    int? maxLines,
    bool obscureText = false, // Added for password
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        maxLines: maxLines ?? 1, // Use maxLines if provided, otherwise 1
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: obscureText,
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
        backgroundColor: const Color.fromARGB(255, 161, 199, 236),
        appBar: AppBar(
          title: const Text(
            'Create an Account',
            style: TextStyle(
              color: Color.fromARGB(221, 65, 64, 64),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<RegisterBlocBloc, RegisterBlocState>(
          listener: (context, state) {
            state.when(
              initial: () {},
              loading: () {
                setState(() => isloading = true);
              },
              success: (response) {
                setState(() => isloading = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Registration Successful"),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen();
                    },
                  ),
                );
              },
              error: (error) {
                setState(() => isloading = false);
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
            return Center(
              child: Container(
                height:
                    h * 0.8, // Adjust height as needed, or use specific value
                width: w * 0.9, // Adjust width as needed
                decoration: BoxDecoration(
                  // image: const DecorationImage(
                  //   image: AssetImage('assets/images/download.jpeg'),
                  //   fit: BoxFit.cover,
                  //   opacity:
                  //       0.3, // Apply opacity here if you want the image to be subtle
                  // ),
                  borderRadius: BorderRadius.circular(
                    16,
                  ), // Match Card's border radius
                  color: Colors
                      .white, // Background color for when the image is transparent or not fully covering
                ),
                child: Card(
                  elevation: 6,
                  // semanticContainer: true,
                  borderOnForeground: true,
                  shadowColor: Colors.black,
                  margin: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                      bottom: 35,
                    ),
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) => Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: [
                                _buildTextField(
                                  "Name",
                                  controller: nameController,
                                  validator: (value) => value!.isEmpty
                                      ? "Please enter name"
                                      : null,
                                ),
                                const SizedBox(height: 10), // Reduced spacing
                                _buildTextField(
                                  "Email",
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter email";
                                    }
                                    final emailRegex = RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                    );
                                    if (!emailRegex.hasMatch(value)) {
                                      return "Invalid email";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10), // Reduced spacing
                                _buildTextField(
                                  "Password",
                                  controller: passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true, // Make password obscure
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter password";
                                    }
                                    if (value.length < 6) {
                                      return "Min 6 characters";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10), // Reduced spacing
                                _buildTextField(
                                  "Age",
                                  controller: ageController,
                                  keyboardType: TextInputType
                                      .number, // Age should be a number
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter your age";
                                    }
                                    if (int.tryParse(value) == null ||
                                        int.parse(value) <= 0) {
                                      return "Please enter a valid age";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                _buildTextField(
                                  "Phone Number",
                                  controller: phoneController,
                                  keyboardType: TextInputType
                                      .phone, // Age should be a number
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter your Phone Number";
                                    }
                                    if (int.tryParse(value) == null ||
                                        int.parse(value) <= 0) {
                                      return "Please enter a valid age";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10), // Reduced spacing
                                _buildTextField(
                                  "Address",
                                  maxLines: 3,
                                  controller: addressController,
                                  keyboardType: TextInputType.streetAddress,
                                  validator: (value) => value!.isEmpty
                                      ? "Please enter address"
                                      : null,
                                ),

                                const SizedBox(height: 20),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    fixedSize: WidgetStatePropertyAll(
                                      Size(w * 0.9, 50),
                                    ),
                                    shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                      ),
                                    ),
                                    backgroundColor:
                                        const WidgetStatePropertyAll(
                                          Colors.blueGrey,
                                        ),
                                  ),
                                  onPressed: saveForm,
                                  child: isloading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text(
                                          "REGISTER",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                                SizedBox(height: h * 0.02),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Already have an account?",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (ctx) =>
                                                const LoginScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "Login",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
            // );
          },
        ),
      ),
    );
  }
}
