import 'package:flutter/material.dart';
import 'package:mobile_app/constants.dart';

class GetconfScreen extends StatefulWidget {
  static const routeName = getconfRouteName;
  const GetconfScreen({super.key});

  @override
  State<GetconfScreen> createState() => _GetconfScreenState();
}

class _GetconfScreenState extends State<GetconfScreen> {
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
            const SizedBox(width: 230),
            const Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  'GET_CONF',
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
                Column(
                  children: [
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'GET_CONF',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Get capabilities',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(customGetconfRouteName);
                        },
                        child: const Text(
                          'Custom',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Get schema',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Get serial',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          //Navigator.of(context)
                          //    .pushNamed(customGetconfRouteName);
                        },
                        child: const Text(
                          'Get loopbacks',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
            const Text(
              'RESPONSE',
              style: TextStyle(fontSize: 35),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.0),
              child: TextField(
                maxLines:
                    23, // Establece maxLines en null para permitir múltiples líneas
                keyboardType: TextInputType
                    .multiline, // Habilita la entrada de múltiples líneas
                decoration: InputDecoration(
                  hintText: 'Display text...',
                  border: OutlineInputBorder(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
