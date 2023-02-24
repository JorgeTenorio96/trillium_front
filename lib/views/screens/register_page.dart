import 'package:flutter/material.dart';
import 'package:flutter_trillium/views/views.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 230, 230),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 155, 214, 100),
        title: Row(children: [
          Icon(size: 35, Icons.person),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text("Register"),
          )
        ]),
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(3),
        child: Form(
          child: Column(
            children: [
              SizedBox(
                height: 20,
                width: 20,
              ),
              CustomTextFormField(hint: "Full Name", obscureText: false),
              SizedBox(
                height: 20,
                width: 20,
              ),
              CustomTextFormField(
                hint: "Username",
                obscureText: false,
              ),
              SizedBox(
                height: 20,
                width: 20,
              ),
              CustomTextFormField(hint: "Password", obscureText: true),
              SizedBox(
                height: 20,
                width: 20,
              ),
              CustomTextFormField(
                hint: "Verified password",
                obscureText: true,
              ),
              SizedBox(
                height: 20,
                width: 20,
              ),
              CustomTextFormField(hint: "Email", obscureText: false),
              SizedBox(
                height: 20,
                width: 20,
              ),
              CustomTextFormField(hint: "Verified Email", obscureText: false),
              SizedBox(
                height: 20,
                width: 20,
              ),
              CustomButton(
                text: 'Register',
                color: Colors.blue,
                padding: 35,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
