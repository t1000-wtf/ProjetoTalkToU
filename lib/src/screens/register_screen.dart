import 'package:flutter/material.dart';
import 'package:talktou_app/src/widgets/custom_text_field.dart';
import 'package:talktou_app/src/services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6A11CB)),
        useMaterial3: true,
      ),
      home: const RegisterScreen(),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final api = ApiService();

  @override
  void dispose() {
    _userController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 10),

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
              'Criar conta',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Preencha os dados abaixo para\ncomeçar sua jornada.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),

            CustomTextField(
              controller: _userController,
              label: "Usuário",
              hint: "Digite seu nome de usuário",
              icon: Icons.person_outline,
            ),
            CustomTextField(
              controller: _emailController,
              label: "E-mail",
              hint: "seu@email.com",
              icon: Icons.email_outlined,
            ),
            CustomTextField(
              controller: _passwordController,
              label: "Senha",
              hint: "Crie uma senha",
              icon: Icons.lock_outline,
              obscure: true,
            ),
            CustomTextField(
              controller: _confirmController,
              label: "Confirmar senha",
              hint: "Confirme sua senha",
              icon: Icons.lock_outline,
              obscure: true,
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ElevatedButton(
                onPressed: () async {
                  if (_userController.text.trim().isEmpty ||
                      _emailController.text.trim().isEmpty ||
                      _passwordController.text.trim().isEmpty ||
                      _confirmController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Preencha todos os campos.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  if (_passwordController.text != _confirmController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('As senhas não coincidem.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  bool sucesso = await api.register(
                    username: _userController.text.trim(),
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                  );

                  if (sucesso) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Conta criada com sucesso!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Erro ao criar conta.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: const Text(
                  "Criar conta",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: const Text(
                "Já tem uma conta? Entrar",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
