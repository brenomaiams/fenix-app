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
                labelText: 'Nome do Cliente',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Telefone',
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Modelo',
                prefixIcon: Icon(Icons.car_repair),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Ano',
                prefixIcon: Icon(Icons.calendar_today),
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Placa',
                prefixIcon: Icon(Icons.directions_car),
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
                  prefixIcon: Icon(Icons.warning),
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
