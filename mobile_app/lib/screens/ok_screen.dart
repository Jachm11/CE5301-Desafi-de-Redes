import 'package:flutter/material.dart';
import 'package:mobile_app/constants.dart';

class OkScreen extends StatefulWidget {
  static const routeName = okScreenRouteName;
  const OkScreen({super.key});

  @override
  State<OkScreen> createState() => _OkScreenState();
}

class _OkScreenState extends State<OkScreen> {
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
            const SizedBox(width: 160),
            const Column(
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
          ],
        ),
        elevation: 0, // Elimina la sombra
        backgroundColor: Colors.transparent, // Fondo transparente
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 300,
              height: 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(getconfRouteName);
                },
                child: const Text(
                  'GET_CONF',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            const SizedBox(height: 100),
            SizedBox(
              width: 300,
              height: 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(editconfRouteName);
                },
                child: const Text(
                  'EDIT_CONF',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
