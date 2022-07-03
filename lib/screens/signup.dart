import 'package:firebaseauth/firebaseMethods/FirebaseStoreMethods.dart';
import 'package:firebaseauth/screens/homepage.dart';
import 'package:firebaseauth/screens/login.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController econtroller = TextEditingController();
  TextEditingController pcontroller = TextEditingController();
  String error = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: econtroller,
                    decoration: const InputDecoration(label: Text("email")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: pcontroller,
                    decoration: const InputDecoration(label: Text("password")),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    error,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: isLoading == true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            final resonse = await FirebaseStoreMethods()
                                .signUp(econtroller.text, pcontroller.text);

                            resonse.fold((left) {
                              setState(() {
                                error = left.message;
                              });
                            }, (right) => print(right.user!.email));
                            setState(() {
                              isLoading = false;
                            });

                            if (error.isEmpty) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyHomePage(),
                                  ));
                            }
                          },
                          child: const Text("SignUp")),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "already SignUp ",
                      style: TextStyle(fontSize: 18),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LogIn(),
                              ));
                        },
                        child: const Text("Login"))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
