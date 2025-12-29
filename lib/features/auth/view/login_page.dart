import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/auth_viewmodel.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerWidget {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(authViewModelProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome Back',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: passCtrl, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () async {
                await ref
                    .read(authViewModelProvider.notifier)
                    .login(emailCtrl.text, passCtrl.text);
                context.go('/');
              },
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text('Login'),
            ),

            TextButton(
              onPressed: () => context.push('/forgot'),
              child: const Text('Forgot Password?'),
            ),
            TextButton(
              onPressed: () => context.push('/register'),
              child: const Text('Create new account'),
            ),

          ],
        ),
      ),
    );
  }
}
