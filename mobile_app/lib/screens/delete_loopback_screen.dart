import 'package:flutter/material.dart';
import 'package:mobile_app/constants.dart';

class DeleteLoopbackScreen extends StatefulWidget {
  static const routeName = deleteloopbackRouteName;
  const DeleteLoopbackScreen({super.key});

  @override
  State<DeleteLoopbackScreen> createState() => _DeleteLoopbackScreenState();
}

class _DeleteLoopbackScreenState extends State<DeleteLoopbackScreen> {
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
            const SizedBox(width: 130),
            const Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  'DELETE LOOPBACK',
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
            const Text(
              'Loopback ID',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 50),
            const SizedBox(
              width: 500,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter number...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 200),
            SizedBox(
              width: 300,
              height: 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(customGetconfRouteName);
                },
                child: const Text(
                  'SEND',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
