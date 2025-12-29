import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/auth_viewmodel.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends ConsumerWidget {
  RegisterPage({super.key});

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final genderCtrl = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(authViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _field(nameCtrl, 'Name'),
            _field(emailCtrl, 'Email'),
            _field(passCtrl, 'Password', obscure: true),
            _field(addressCtrl, 'Address'),
            _field(ageCtrl, 'Age', type: TextInputType.number),
            _field(genderCtrl, 'Gender'),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading
                    ? null
                    : () async {
                  await ref
                      .read(authViewModelProvider.notifier)
                      .register({
                    "name": nameCtrl.text,
                    "email": emailCtrl.text,
                    "password": passCtrl.text,
                    "address": addressCtrl.text,
                    "age": int.parse(ageCtrl.text),
                    "gender": genderCtrl.text,
                  });
                  context.pop();
                },
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(TextEditingController c, String label,
      {bool obscure = false, TextInputType type = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: c,
        obscureText: obscure,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
