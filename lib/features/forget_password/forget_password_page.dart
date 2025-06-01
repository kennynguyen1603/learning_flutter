import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/core/providers/shared_prefs_service.dart';
import 'package:test_app/core/widgets/hero_widget.dart';
import 'package:pinput/pinput.dart';

class ForgetpasswordPage extends StatefulWidget {
  const ForgetpasswordPage({super.key});

  @override
  State<ForgetpasswordPage> createState() => _ForgetpasswordPageState();
}

class _ForgetpasswordPageState extends State<ForgetpasswordPage> {
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void handleForgetPassword() {
    final String email = emailController.text;

    if (email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter your email')));
      return;
    }

    // Here you would implement your forget password logic
    // For example, sending a verification code to the email
    SharedPrefsService.setEmail(email);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const VerifyCode()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forget Password')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HeroWidget(title: 'Hero Animation'),
                const SizedBox(height: 16.0),

                Text(
                  'Forget Password?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),

                const SizedBox(height: 16.0),

                Text(
                  'Enter your Email, we will send you a verification code.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),

                const SizedBox(height: 16.0),

                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    hintText: 'Enter your email',
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                ),

                const SizedBox(height: 16.0),

                ElevatedButton(
                  onPressed: () {
                    handleForgetPassword();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 60),
                    backgroundColor:
                        Colors.blue, // Change to your desired color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  child: Text(
                    'Next Step',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary,
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

class VerifyCode extends StatefulWidget {
  const VerifyCode({super.key});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Code')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HeroWidget(title: 'Hero Animation'),

                const SizedBox(height: 16.0),

                Text(
                  'Verification Code',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16.0),

                Text(
                  'Enter the verification code. We just sent it to your email.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),

                const SizedBox(height: 16.0),

                PinputExample(),

                const SizedBox(height: 16.0),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateNewPassword(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 60),
                    backgroundColor:
                        Colors.blue, // Change to your desired color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  child: Text(
                    'Next Step',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary,
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

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});
  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void handleCreateNewPassword() async {
    final String newPassword = newPasswordController.text;
    final String confirmPassword = confirmPasswordController.text;

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in both password fields')),
      );
      return;
    }

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    try {
      SharedPrefsService.setNewPassword(newPassword);

      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Confirm()),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error saving password: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create New Password')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HeroWidget(title: 'Hero Animation'),

                const SizedBox(height: 16.0),

                Text(
                  'Create New Password',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),

                const SizedBox(height: 16.0),

                Text(
                  'Enter your new password. Make sure it is strong and secure.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),

                const SizedBox(height: 16.0),

                TextField(
                  controller: newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    hintText: 'Enter your new password',
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                ),

                const SizedBox(height: 16.0),

                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    hintText: 'Confirm your new password',
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                ),

                const SizedBox(height: 16.0),

                ElevatedButton(
                  onPressed: () {
                    handleCreateNewPassword();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 60),
                    backgroundColor:
                        Colors.blue, // Change to your desired color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  child: Text(
                    'Create Password',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary,
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

class Confirm extends StatefulWidget {
  const Confirm({super.key});

  @override
  State<Confirm> createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  String? email;
  String? verificationCode;
  String? newPassword;

  @override
  void initState() {
    super.initState();
    // Get all stored information
    email = SharedPrefsService.email;
    verificationCode = SharedPrefsService.verificationCode;
    newPassword = SharedPrefsService.newPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HeroWidget(title: 'Hero Animation'),

                const SizedBox(height: 16.0),

                Text(
                  'Information Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),

                Text(
                  'We are here to help you',
                  style: TextStyle(
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 24.0),

                // Email information
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.email_outlined, color: Colors.blue),
                          const SizedBox(width: 8),
                          Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        email ?? 'Not available',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16.0),

                // Verification code information
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.security_outlined,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Verification Code',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        verificationCode ?? 'Not available',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16.0),

                // New password information
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.lock_outline, color: Colors.orange),
                          const SizedBox(width: 8),
                          Text(
                            'New Password',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        newPassword ?? 'Not available',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24.0),

                ElevatedButton(
                  onPressed: () {
                    // Clear all stored data before navigating back
                    SharedPrefsService.clear();
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 60),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary,
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

class PinputExample extends StatefulWidget {
  const PinputExample({super.key});

  @override
  State<PinputExample> createState() => _PinputExampleState();
}

class _PinputExampleState extends State<PinputExample> {
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;
  bool isLoading = false;
  int timeLeft = 60; // Timer for resend code
  bool canResendCode = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      BrowserContextMenu.disableContextMenu();
    }
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();
    startTimer();
  }

  void startTimer() {
    setState(() {
      timeLeft = 60;
      canResendCode = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        setState(() {
          canResendCode = true;
        });
        timer.cancel();
      }
    });
  }

  Future<void> resendCode() async {
    if (!canResendCode) return;

    setState(() {
      isLoading = true;
    });

    try {
      // Generate a new verification code (for demo using a simple 6-digit code)
      String newCode =
          (100000 + DateTime.now().microsecond % 900000).toString();

      // Store the new verification code
      await SharedPrefsService.setVerificationCode(newCode);

      // In a real app, you would send this code to the user's email
      // For demo purposes, we'll show it in a snackbar
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('New verification code: $newCode'),
          backgroundColor: Colors.green,
        ),
      );

      startTimer();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to resend code: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> verifyCode() async {
    if (formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      try {
        // Store the verification code
        await SharedPrefsService.setVerificationCode(pinController.text);
        String? storedCode = SharedPrefsService.verificationCode;

        // Verify if the code matches
        if (storedCode == pinController.text) {
          if (!mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateNewPassword()),
          );
        } else {
          throw Exception('Invalid verification code');
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Verification failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    if (kIsWeb) {
      BrowserContextMenu.enableContextMenu();
    }
    _timer?.cancel();
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Pinput(
              controller: pinController,
              focusNode: focusNode,
              length: 6, // Standard verification code length
              defaultPinTheme: defaultPinTheme,
              separatorBuilder: (index) => const SizedBox(width: 8),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the verification code';
                }
                if (value.length != 6) {
                  return 'Code must be 6 digits';
                }
                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                  return 'Code must contain only numbers';
                }
                return null;
              },
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onCompleted: (pin) {
                debugPrint('onCompleted: $pin');
                verifyCode();
              },
              onChanged: (value) {
                debugPrint('onChanged: $value');
              },
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 22,
                    height: 1,
                    color: focusedBorderColor,
                  ),
                ],
              ),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(19),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent),
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (isLoading)
            const CircularProgressIndicator()
          else
            Column(
              children: [
                // ElevatedButton(
                //   onPressed: verifyCode,
                //   style: ElevatedButton.styleFrom(
                //     minimumSize: const Size(200, 45),
                //     backgroundColor: Colors.blue,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(50.0),
                //     ),
                //   ),
                //   child: const Text(
                //     'Verify',
                //     style: TextStyle(fontSize: 16, color: Colors.white),
                //   ),
                // ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: canResendCode ? resendCode : null,
                  child: Text(
                    canResendCode
                        ? 'Resend Code'
                        : 'Resend Code in ${timeLeft}s',
                    style: TextStyle(
                      fontSize: 14,
                      color: canResendCode ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
