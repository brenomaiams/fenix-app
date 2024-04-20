import 'package:flutter/material.dart';
import 'package:telaoficina/pages/Telainicial.dart';
import 'package:telaoficina/pages/checklist.dart';
import 'package:telaoficina/pages/telaOs.dart';

class Rotas {
  Map<String, WidgetBuilder> get routes => {
    '/': (context) => Telainicial(),
    '/tela2': (context) => telaChecklist(),
    '/tela3': (context) => telaOS(),
  };
}
