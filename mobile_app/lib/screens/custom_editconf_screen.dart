import 'package:flutter/material.dart';
import 'package:mobile_app/constants.dart';
import 'package:mobile_app/services/api_service.dart';
import 'package:mobile_app/utils/utils.dart';

class CustomEditconfScreen extends StatefulWidget {
  static const routeName = customEditconfRouteName;
  const CustomEditconfScreen({super.key});

  @override
  State<CustomEditconfScreen> createState() => _CustomEditconfScreenState();
}

class _CustomEditconfScreenState extends State<CustomEditconfScreen> {
  final TextEditingController _dataController = TextEditingController(
      text:
          '<config> <System xmlns="http://cisco.com/ns/yang/cisco-nx-os-device\"> <intf-items> <lb-items> <LbRtdIf-list> <id>lo11</id> <adminSt>up</adminSt> <descr>Added with postman for Redes</descr> </LbRtdIf-list> </lb-items> </intf-items> <ipv4-items> <inst-items> <dom-items> <Dom-list> <name>default</name> <if-items> <If-list> <id>lo11</id> <addr-items> <Addr-list> <addr>0.0.0.0/32</addr> </Addr-list> </addr-items> </If-list> </if-items> </Dom-list> </dom-items> </inst-items> </ipv4-items> </System> </config>');

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
                  'CUSTOM EDIT_CONF',
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
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Config data',
                    style: TextStyle(fontSize: 25),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48.0),
                    child: TextField(
                      controller: _dataController,
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
      var response = await putEditConfig(_dataController.text);
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
