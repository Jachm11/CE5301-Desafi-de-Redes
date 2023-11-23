import 'package:flutter/material.dart';
import 'package:mobile_app/constants.dart';

class FailScreen extends StatefulWidget {
  static const routeName = failScreenRouteName;
  const FailScreen({super.key});

  @override
  State<FailScreen> createState() => _FailScreenState();
}

class _FailScreenState extends State<FailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leadingWidth: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 45,
              ),
              onPressed: () {
                // Manejar la acción del botón de retroceso aquí
                Navigator.pop(context);
              },
            ),
            SizedBox(width: 160),
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                const Text(
                  'NETCONF Friend',
                  style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'ERROR: Unable to connect',
                  style: TextStyle(fontSize: 35),
                ),
                SizedBox(width: 35),
                Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 65,
                )
              ],
            ),
            SizedBox(
                width: 300,
                height: 100,
                child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Reintentar',
                      style: TextStyle(fontSize: 25),
                    )))
          ],
        ),
      ),
    );
  }
}
