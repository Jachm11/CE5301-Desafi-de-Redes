import 'package:flutter/material.dart';
import 'package:mobile_app/constants.dart';

class CopyconfScreen extends StatefulWidget {
  static const routeName = copyconfRouteName;
  const CopyconfScreen({super.key});

  @override
  State<CopyconfScreen> createState() => _CopyconfScreenState();
}

class _CopyconfScreenState extends State<CopyconfScreen> {
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
                  'COPY CONF',
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
              'SOURCE',
              style: TextStyle(fontSize: 35),
            ),
            RadioList(),
            Text(
              'other:',
              style: TextStyle(fontSize: 35),
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
              'TARGET',
              style: TextStyle(fontSize: 35),
            ),
            RadioList(),
            Text(
              'other:',
              style: TextStyle(fontSize: 35),
            ),
            const SizedBox(
              width: 500,
              child: TextField(
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
                onPressed: () {},
                child: const Text(
                  'SEND',
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

class RadioList extends StatefulWidget {
  @override
  _RadioListState createState() => _RadioListState();
}

class _RadioListState extends State<RadioList> {
  int selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 158.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RadioListTile(
            title: Text('Candidate'),
            value: 1,
            groupValue: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value!;
              });
            },
          ),
          RadioListTile(
            title: Text('Running'),
            value: 2,
            groupValue: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value!;
              });
            },
          ),
          RadioListTile(
            title: Text('Startup'),
            value: 3,
            groupValue: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}
