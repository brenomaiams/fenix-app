import 'package:flutter/material.dart';
import 'package:telaoficina/cores/minhasCores.dart';

void main() {
  runApp(const Menu());
}

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            title: Text(
              'Menu de Opções',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: MinhasCores.vermelhoescuro,
            centerTitle: true,
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF333333), Color(0xFFFFFFFF)],
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Image.asset(
                        "assets/martelo.png",
                        height: 200,
                        width: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/tela5');
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Cadastro de Clientes',
                        style: TextStyle(
                          color: MinhasCores.colorTitle,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/tela2');
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'CheckList',
                        style: TextStyle(
                          color: MinhasCores.colorTitle,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/tela3');
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Ordem de Serviço',
                        style: TextStyle(
                          color: MinhasCores.colorTitle,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

              ),
            ),
          ),
        ),
      ),
    );
  }
}
