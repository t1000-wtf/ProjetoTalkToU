import 'package:flutter/material.dart';
import 'package:talktou_app/src/screens/register_screen.dart';
import 'package:talktou_app/src/screens/resetPassword_screen.dart';
import 'package:talktou_app/src/services/api_service.dart';
import 'package:talktou_app/src/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final api = ApiService();

  bool loading = false;

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> fazerLogin() async {
    if (_userController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    bool sucesso = await api.login(
      username: _userController.text.trim(),
      password: _passwordController.text.trim(),
    );

    setState(() {
      loading = false;
    });

    if (sucesso) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login realizado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      // NAVEGAR PARA HOME
      // Navigator.pushReplacement(...)
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuário ou senha inválidos.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),

      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),

        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),

                    child: const Icon(
                      Icons.all_inclusive,
                      color: Colors.blueAccent,
                      size: 60,
                    ),
                  ),

                  const SizedBox(height: 12),

                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 32, letterSpacing: -1),

                      children: [
                        TextSpan(
                          text: 'Talk',

                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),

                        TextSpan(
                          text: 'ToU',

                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Bem-vindo(a)!',

              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              'Entre para continuar sua jornada.',

              textAlign: TextAlign.center,

              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),

            const SizedBox(height: 30),

            CustomTextField(
              controller: _userController,
              label: "Usuário",
              hint: "Digite seu nome de usuário",
              icon: Icons.person_outlined,
            ),

            CustomTextField(
              controller: _passwordController,
              label: "Senha",
              hint: "Digite sua senha",
              icon: Icons.lock_outline,
              obscure: true,
            ),

            Align(
              alignment: Alignment.centerRight,

              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,

                    MaterialPageRoute(builder: (_) => ResetPasswordScreen()),
                  );
                },

                child: const Text(
                  'Esqueci minha senha',

                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 6),

            Container(
              width: double.infinity,
              height: 55,

              decoration: BoxDecoration(
                color: Colors.blueAccent,

                borderRadius: BorderRadius.circular(15),
              ),

              child: ElevatedButton(
                onPressed: loading ? null : fazerLogin,

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,

                  shadowColor: Colors.transparent,
                ),

                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Entrar",

                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                const Text(
                  "Ainda não tem uma conta? ",

                  style: TextStyle(color: Colors.grey),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },

                  child: const Text(
                    "Criar conta",

                    style: TextStyle(
                      fontWeight: FontWeight.bold,

                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
