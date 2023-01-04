import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_cars_/Screens/Register.dart';

import '../Service/service.dart';
import 'Home.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  String? _email;

  String? _password;

  final _formKey = GlobalKey<FormState>();

  bool _obscureText = false;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      "Super Cars",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.red,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(width: 1, color: Colors.black),
                            ),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.email),
                                  contentPadding: EdgeInsets.all(8)),
                              onSaved: (val) => _email = val,
                              onChanged: (val) => _email = val,
                              validator: (val) {
                                return val!.contains("@") ? null : "Invalid";
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                border:
                                    Border.all(width: 1, color: Colors.black)),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.red,
                                    ),
                                    onPressed: _toggle,
                                  ),
                                  contentPadding: const EdgeInsets.all(8)),
                              onSaved: (val) => _password = val,
                              obscureText: !_obscureText,
                              onChanged: (val) => _password = val,
                              validator: (val) {
                                return val!.length >= 8 ? null : "Invalid";
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () => submit(context),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      colors: [Colors.amber, Colors.green]),
                                  borderRadius: BorderRadius.circular(40)),
                              child: const Text(
                                "Login",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Register()));
                              },
                              child: const Text("Create Account",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: const Text("forgot password",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w400)),
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
          isLoading
              ? Opacity(
                  opacity: 0.5,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.grey.shade300,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              : const SizedBox(),
        ]),
      ),
    );
  }

  Future<void> submit(BuildContext context) async {
    Service _service = Service();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      final res = await _service.login(_email, _password, context);
      if (res) {
        setState(() {
          isLoading = false;
        });
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("email", _email!);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Home()));
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
