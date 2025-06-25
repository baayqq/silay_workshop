import 'package:flutter/material.dart';
import 'package:silay_workshop/api/api_file.dart';
import 'package:silay_workshop/auth/login.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController userController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final UserService userService = UserService();
    final formKey = GlobalKey<FormState>();
    void handleRegist() async {
      if (formKey.currentState!.validate()) {
        final res = await userService.registUser(
          userController.text,
          emailController.text,
          passwordController.text,
        );
        if (res['data'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('register berhasil'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        } else if (res['errors'] != null) {
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
      backgroundColor: Color(0xff0D47A1),
      body: Center(
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
                        'Buat akun',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: userController,
                        decoration: InputDecoration(
                          hintText: "Nama",
                          hintStyle: TextStyle(color: Color(0xff333333)),
                          prefixIcon: Icon(Icons.account_box),
                          filled: true,
                          fillColor: Color(0xffffffff),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama wajib di isi';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
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
                              handleRegist();
                            }
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
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
                              text: "Sudah mempunyai akun ?",
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
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Login",
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
    );
  }
}
