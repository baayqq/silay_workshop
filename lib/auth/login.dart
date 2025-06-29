import 'package:flutter/material.dart';
import 'package:silay_workshop/api/api_file.dart';
import 'package:silay_workshop/auth/register.dart';
import 'package:silay_workshop/database/sharedprefence.dart';
import 'package:silay_workshop/pages/navhome.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController userController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final UserService userService = UserService();
    final formKey = GlobalKey<FormState>();
    void handleLogin() async {
      if (formKey.currentState!.validate()) {
        final res = await userService.loginUser(
          userController.text,
          emailController.text,
          passwordController.text,
        );
        print("Respon dari API: $res");
        if (res['data'] != null) {
          final token = res['data']['token'];
          await SharedPrefService.saveToken(token);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('login berhasil'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeBottom()),
            (route) => false,
          );
        } else if (res['message'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('maaf ${res['message']}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xff0D47A1),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 48),
              Image.asset('assets/images/logo.png', width: 240),

              SizedBox(height: 36),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xf2ffffff),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 12,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(
                          'Login untuk masuk',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(color: Color(0xff333333)),
                            prefixIcon: Icon(Icons.email),
                            filled: true,
                            fillColor: Color(0xffffffff),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email wajib di isi';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(color: Color(0xff333333)),
                            prefixIcon: Icon(Icons.lock),
                            filled: true,
                            fillColor: Color(0xffffffff),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password wajib di isi';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          // height: 20,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              backgroundColor: Colors.yellow[600],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                print('Berhasil');
                                handleLogin();
                              }
                            },
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: "Belum mempunyai akun ?",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff888888),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Daftar",
                                style: TextStyle(
                                  color: Color(0xff0D47A1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
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
            ],
          ),
        ),
      ),
    );
  }
}
