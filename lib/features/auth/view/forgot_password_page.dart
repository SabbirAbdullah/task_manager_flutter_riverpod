import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/auth_viewmodel.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends ConsumerWidget {
  ForgotPasswordPage({super.key});

  final emailCtrl = TextEditingController();
  final currentPassCtrl = TextEditingController();
  final newPassCtrl = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(authViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _field(emailCtrl, 'Email'),
            _field(currentPassCtrl, 'Current Password', obscure: true),
            _field(newPassCtrl, 'New Password', obscure: true),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading
                    ? null
                    : () async {
                  await ref
                      .read(authViewModelProvider.notifier)
                      .forgetPassword(
                    emailCtrl.text,
                    currentPassCtrl.text,
                    newPassCtrl.text,
                  );
                  context.pop();
                },
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text('Update Password'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(TextEditingController c, String label,
      {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: c,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
