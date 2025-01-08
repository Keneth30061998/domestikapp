import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/my_textfield.dart';
import '../../utils/color.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  //Para poder usar los controladores de login
  LoginController con = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color_primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 140),
              _imageCover(),
              SizedBox(height: 30),
              _welcomeText(),
              const SizedBox(height: 25),

              //textfields

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    MyTextField(
                      myController: con.emailController,
                      myLabelText: 'Correo electrónico',
                      isObscureText: false,
                      wantEnabledBorder: true,
                      wantFocusedBorder: true,
                      iconText: Icon(
                        Icons.email,
                        color: Colors.white60,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      myController: con.passwordController,
                      myLabelText: 'Contraseña',
                      isObscureText: true,
                      wantEnabledBorder: true,
                      wantFocusedBorder: true,
                      iconText: Icon(
                        Icons.lock,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ),

              //Registrarse
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "¿No tienes una cuenta?",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.white60,
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.black87)),
                          child: Text(
                            "Registrate Aquí",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: color_text,
                            ),
                          ),
                          onPressed: () {
                            return con.goToRegisterPage();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 25),

              //Login Button
              FilledButton(
                onPressed: () {
                  return con.Login();
                },
                child: Text('Login'),
              ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  //Creacion de widgets
  Widget _imageCover() {
    return Container(
      child: Image.asset(
        'assets/img/home_house.png',
        width: 140,
        height: 140,
      ),
    );
  }

  Widget _welcomeText() {
    return Text(
      "Bienvenido! Ingresa tus credenciiales",
      style: TextStyle(color: color_text, fontSize: 18),
    );
  }
}
