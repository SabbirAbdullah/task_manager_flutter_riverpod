import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/auth_viewmodel.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/viewmodel/auth_viewmodel.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends ConsumerStatefulWidget {
  RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  String gender = 'Male'; // default gender

  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(authViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.all(24),
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Register',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 24),
                  _field(nameCtrl, 'Name', prefix: Icons.person),
                  _field(emailCtrl, 'Email', prefix: Icons.email),
                  _field(passCtrl, 'Password', obscure: true, prefix: Icons.lock),
                  _field(addressCtrl, 'Address', prefix: Icons.home),
                  _field(ageCtrl, 'Age',
                      type: TextInputType.number, prefix: Icons.calendar_today),
                  // ✅ Gender Dropdown
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        prefixIcon: const Icon(Icons.person_outline),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: gender,
                          isExpanded: true,
                          items: genderOptions
                              .map((g) => DropdownMenuItem(
                            value: g,
                            child: Text(g),
                          ))
                              .toList(),
                          onChanged: loading
                              ? null
                              : (val) {
                            setState(() {
                              gender = val!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
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
                          "age": int.tryParse(ageCtrl.text) ?? 0,
                          "gender": gender,
                        });
                        context.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: loading
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : const Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(TextEditingController c, String label,
      {bool obscure = false,
        TextInputType type = TextInputType.text,
        IconData? prefix}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: c,
        obscureText: obscure,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefix != null ? Icon(prefix) : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
