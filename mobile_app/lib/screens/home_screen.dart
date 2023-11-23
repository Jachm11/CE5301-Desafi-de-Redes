import 'package:flutter/material.dart';
import 'package:mobile_app/constants.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = homeScreenRouteName;
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool connectState = true;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Text(
              'HOST',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
                width: 500,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter text...',
                    border: OutlineInputBorder(),
                  ),
                )),
            const Text(
              'PORT',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
                width: 500,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter text...',
                    border: OutlineInputBorder(),
                  ),
                )),
            const Text(
              'USERNAME',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
                width: 500,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter text...',
                    border: OutlineInputBorder(),
                  ),
                )),
            const Text(
              'PASSWORD',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
                width: 500,
                child: TextField(
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
                      if (connectState) {
                        Navigator.of(context).pushNamed(okScreenRouteName);
                      } else {
                        Navigator.of(context).pushNamed(failScreenRouteName);
                      }
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
}
