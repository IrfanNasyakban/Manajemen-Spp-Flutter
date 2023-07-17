import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manajemen_spp/loginpage.dart';

class LupaPassword extends StatefulWidget {
  const LupaPassword({super.key});

  @override
  State<LupaPassword> createState() => _LupaPasswordState();
}

class _LupaPasswordState extends State<LupaPassword> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
                'Link untuk ubah password sudah dikirim, silahkan cek Email!'),
          );
        },
      ).then((value) {
        Navigator.pop(context); // Kembali ke halaman sebelumnya
      });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      ).then((value) {
        Navigator.pop(context); // Kembali ke halaman sebelumnya
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA5A808),
        appBar: AppBar(
          title: Text('Reset Password'),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png'),
                SizedBox(
                  height: 45,
                ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Masukan Email kamu untuk kami berikan link ubah password',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'Email',
                    fillColor: Color(0xFfB9E45E),
                    filled: true,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: resetPassword,
              child: Text(
                'Reset Password',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Color.fromARGB(255, 85, 15, 207),
            ),
          ],
        ));
  }
}
