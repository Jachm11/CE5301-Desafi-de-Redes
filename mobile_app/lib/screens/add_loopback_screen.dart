import 'package:flutter/material.dart';
import 'package:mobile_app/constants.dart';

class AddLoopbackScreen extends StatefulWidget {
  static const routeName = addloopbackRouteName;
  const AddLoopbackScreen({super.key});

  @override
  State<AddLoopbackScreen> createState() => _AddLoopbackScreenState();
}

class _AddLoopbackScreenState extends State<AddLoopbackScreen> {
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
                  'ADD LOOPBACK',
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
            const Text(
              'ID',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              width: 500,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter number...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'IP',
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
            Text(
              'Description',
              style: TextStyle(fontSize: 25),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.0),
              child: TextField(
                maxLines:
                    23, // Establece maxLines en null para permitir múltiples líneas
                keyboardType: TextInputType
                    .multiline, // Habilita la entrada de múltiples líneas
                decoration: InputDecoration(
                  hintText: 'Enter text...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
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
