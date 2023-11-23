import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/constants.dart';
import 'package:mobile_app/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = homeScreenRouteName;
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _usernameController =
      TextEditingController(text: 'admin');
  final TextEditingController _passwordController =
      TextEditingController(text: 'Admin_1234!');
  final TextEditingController _hostController =
      TextEditingController(text: "sbx-nxos-mgmt.cisco.com");
  final TextEditingController _portController =
      TextEditingController(text: '830');

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leadingWidth: 0,
        title: const Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'NETCONF Friend',
              style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
        elevation: 0, // Elimina la sombra
        backgroundColor: Colors.transparent, // Fondo transparente
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Text(
                    'HOST',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                      width: 500,
                      child: TextField(
                        controller: _hostController,
                        decoration: InputDecoration(
                          hintText: 'Enter text...',
                          border: OutlineInputBorder(),
                        ),
                      )),
                  const Text(
                    'PORT',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                      width: 500,
                      child: TextField(
                        controller: _portController,
                        decoration: InputDecoration(
                          hintText: 'Enter text...',
                          border: OutlineInputBorder(),
                        ),
                      )),
                  const Text(
                    'USERNAME',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                      width: 500,
                      child: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: 'Enter text...',
                          border: OutlineInputBorder(),
                        ),
                      )),
                  const Text(
                    'PASSWORD',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                      width: 500,
                      child: TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'Enter text...',
                          border: OutlineInputBorder(),
                        ),
                      )),
                  SizedBox(
                      width: 300,
                      height: 100,
                      child: ElevatedButton(
                          onPressed: () {
                            submitLogin(
                                context,
                                _usernameController.text,
                                _passwordController.text,
                                _hostController.text,
                                int.parse(_portController.text));
                          },
                          child: const Text(
                            'CONNECT',
                            style: TextStyle(fontSize: 25),
                          )))
                ],
              ),
      ),
    );
  }

  void setIsLoadingTrue() {
    setState(() {
      isLoading = true;
    });
  }

  void setIsLoadingFalse() {
    setState(() {
      isLoading = false;
    });
  }

  void submitLogin(BuildContext context, String username, String password,
      String host, int port) async {
    try {
      setIsLoadingTrue();
      var response = await postLogin(username, password, host, port);
      setIsLoadingFalse();

      if (response.statusCode == 200) {
        if (context.mounted) {
          Navigator.of(context).pushNamed(okScreenRouteName);
        }
      } else {
        if (context.mounted) {
          Navigator.of(context).pushNamed(failScreenRouteName);
        }
      }
    } catch (e) {
      print("error: $e");
    }
  }
}
