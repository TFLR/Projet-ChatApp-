import 'package:flutter/material.dart';
import 'package:projetchatapp/services/authentication.dart';

class AuthenticateScreen extends StatefulWidget {
  const AuthenticateScreen({Key? key}) : super(key: key);

  @override
  _AuthenticateScreenState createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  final AuthenticationService _auth = AuthenticationService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  final emailController = TextEditingController();
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final passwordController = TextEditingController();
  bool showSignIn = true;

  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void toggleView() {
    setState(() {
      _formKey.currentState?.reset();
      error = '';
      emailController.text = '';
      nomController.text = '';
      prenomController.text = '';
      passwordController.text = '';
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text(showSignIn ? 'ChatApp' : 'ChatApp'),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    !showSignIn
                        ? TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                            controller: prenomController,
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                              hintText: "Prenom",

                            ),
                            validator: (value) =>
                                value == null || value.isEmpty ? "Entrez vôtre nom" : null,
                          )
                        : Container(),
                    const SizedBox(height: 10.0),

                    !showSignIn
                        ? TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      controller: nomController,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        hintText: "Nom",

                      ),
                      validator: (value) =>
                      value == null || value.isEmpty ? "Entrez vôtre nom" : null,
                    )
                        : Container(),


                    !showSignIn ? const SizedBox(height: 10.0) : Container(),
                    TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        hintText: "Email",

                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? "Entrez vôtre email" : null,
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      controller: passwordController,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        hintText: "Mot de passe",

                      ),
                      obscureText: true,
                      validator: (value) => value != null && value.length < 6
                          ? "Entrez un mot de passe d'au moins 6 caractères"
                          : null,
                    ),
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                      child: Text(
                        showSignIn ? "Connexion" : "Inscription",
                        style: const TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState?.validate() == true) {
                          setState(() => loading = true);
                          var password = passwordController.value.text;
                          var email = emailController.value.text;
                          var nom = nomController.value.text;
                          var prenom = prenomController.value.text;

                          dynamic result = showSignIn
                              ? await _auth.signInWithEmailAndPassword(email, password)
                              : await _auth.registerWithEmailAndPassword(nom,prenom , email, password);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = 'Entrez une email valide';
                            });
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 15.0),
                    ),
                    ElevatedButton(
                      child: Text(showSignIn ? "S'inscrire" : 'Se connecter',
                          style: const TextStyle(color: Colors.white)),
                      onPressed: () => toggleView()),
                  ],
                ),

              ),
            ),
          );
  }
}
