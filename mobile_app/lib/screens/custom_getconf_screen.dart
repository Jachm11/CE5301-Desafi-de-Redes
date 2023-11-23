import 'package:flutter/material.dart';
import 'package:mobile_app/constants.dart';

class CustomGetconfScreen extends StatefulWidget {
  static const routeName = customGetconfRouteName;
  const CustomGetconfScreen({super.key});

  @override
  State<CustomGetconfScreen> createState() => _CustomGetconfScreenState();
}

class _CustomGetconfScreenState extends State<CustomGetconfScreen> {
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
                  'CUSTOM GET_CONF',
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
            Text(
              'FILTER',
              style: TextStyle(fontSize: 35),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.0),
              child: TextField(
                maxLines:
                    15, // Establece maxLines en null para permitir múltiples líneas
                keyboardType: TextInputType
                    .multiline, // Habilita la entrada de múltiples líneas
                decoration: InputDecoration(
                  hintText: 'Display text...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Text(
              'RESPONSE',
              style: TextStyle(fontSize: 35),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.0),
              child: TextField(
                maxLines:
                    15, // Establece maxLines en null para permitir múltiples líneas
                keyboardType: TextInputType
                    .multiline, // Habilita la entrada de múltiples líneas
                decoration: InputDecoration(
                  hintText: 'Display text...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
                width: 300,
                height: 100,
                child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'SEND',
                      style: TextStyle(fontSize: 25),
                    )))
          ],
        ),
      ),
    );
  }
}
