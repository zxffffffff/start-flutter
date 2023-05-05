import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const routeName = '/login_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginView'),
      ),
      body: const Center(
        child: Text('login_view'),
      ),
    );
  }
}
