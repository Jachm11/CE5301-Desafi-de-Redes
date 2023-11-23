import 'package:flutter/material.dart';
import 'package:mobile_app/constants.dart';
import 'package:mobile_app/services/api_service.dart';

import '../utils/utils.dart';

class AddLoopbackScreen extends StatefulWidget {
  static const routeName = addloopbackRouteName;
  const AddLoopbackScreen({super.key});

  @override
  State<AddLoopbackScreen> createState() => _AddLoopbackScreenState();
}

class _AddLoopbackScreenState extends State<AddLoopbackScreen> {
  final TextEditingController _idController = TextEditingController(text: '11');
  final TextEditingController _ipController =
      TextEditingController(text: "0.0.0.0/32");
  final TextEditingController _descriptionController =
      TextEditingController(text: "Another way to use postman for Redes");

  bool isLoading = false;

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
        child: isLoading
            ? CircularProgressIndicator()
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Text(
                      'ID',
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 500,
                      child: TextField(
                        controller: _idController,
                        decoration: InputDecoration(
                          hintText: 'Enter number...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(height: 50),
                    const Text(
                      'IP',
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                        width: 500,
                        child: TextField(
                          controller: _ipController,
                          decoration: InputDecoration(
                            hintText: 'Enter text...',
                            border: OutlineInputBorder(),
                          ),
                        )),
                    SizedBox(height: 50),
                    Text(
                      'Description',
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 48.0),
                      child: TextField(
                        controller: _descriptionController,
                        maxLines:
                            10, // Establece maxLines en null para permitir múltiples líneas
                        keyboardType: TextInputType
                            .multiline, // Habilita la entrada de múltiples líneas
                        decoration: InputDecoration(
                          hintText: 'Enter text...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    SizedBox(
                      width: 300,
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          submit(context);
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

  void submit(BuildContext context) async {
    try {
      setIsLoadingTrue();
      var response = await putAddLoopback(
        int.parse(_idController.text),
        _ipController.text,
        _descriptionController.text,
      );
      setIsLoadingFalse();

      if (response.statusCode == 200) {
        if (context.mounted) {
          showAlertDialog(context, 'Success', response.body, 'Aceptar');
        }
      } else {
        if (context.mounted) {
          showAlertDialog(context, 'Error',
              'Ha ocurrido un error: ${response.body}', 'Aceptar');
        }
      }
    } catch (e) {
      showAlertDialog(
          context, 'Error', 'Ha ocurrido un error: ${e}', 'Aceptar');
    }
  }
}
