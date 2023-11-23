import 'package:flutter/material.dart';
import 'package:mobile_app/constants.dart';

class EditconfScreen extends StatefulWidget {
  static const routeName = editconfRouteName;
  const EditconfScreen({super.key});

  @override
  State<EditconfScreen> createState() => _EditconfScreenState();
}

class _EditconfScreenState extends State<EditconfScreen> {
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
            SizedBox(width: 210),
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                const Text(
                  'EDIT_CONF',
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
                  'Copy Config',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            const SizedBox(height: 100),
            SizedBox(
              width: 300,
              height: 100,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Custom',
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
