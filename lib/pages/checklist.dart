import 'package:flutter/material.dart';
import 'package:telaoficina/cores/minhasCores.dart';


class telaChecklist extends StatefulWidget {
  const telaChecklist({Key? key});

  @override
  _telaChecklistState createState() => _telaChecklistState();
}

class _telaChecklistState extends State<telaChecklist> {
  bool _avarias = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MinhasCores.vermelhoescuro,
        title: Center(
          child: Text(
            'CheckList',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pushNamed(context, '/tela4');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome do Cliente:',

              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Telefone:',

              ),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Modelo:',

              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Ano:',

              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Placa:',

              ),
              textCapitalization: TextCapitalization.characters,
            ),
            Row(
              children: [
                Text(
                  'Possui Avarias?',

                ),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: _avarias,
                    onChanged: (value) {
                      setState(() {
                        _avarias = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            if (_avarias)
              TextField(
                decoration: InputDecoration(
                  labelText: 'Digite aqui as avarias existentes',

                ),
              ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(
              thickness: 1,
              color: Colors.black,
              height: 20,
              indent: 20,
              endIndent: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Assinatura do Cliente',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
