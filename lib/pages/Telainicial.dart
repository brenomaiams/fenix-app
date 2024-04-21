import 'package:flutter/material.dart';
import 'package:telaoficina/cores/minhasCores.dart';

class Telainicial extends StatelessWidget {
  const Telainicial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MinhasCores.vermelhoescuro,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                end: Alignment.bottomCenter,
                colors: [
                  MinhasCores.vermelhoescuro,
                  MinhasCores.preto,
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedLogo(),
              const SizedBox(height: 5),
              const Text(
                'FenixApp',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                height: 30,
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.transparent,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/tela4');
                    },
                    child: Text(
                      'ENTRAR',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'O seu aplicativo ideal para realização de \nchecklists e ordens de serviço!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AnimatedLogo extends StatefulWidget {
  @override
  _AnimatedLogoState createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 20 * _controller.value - 10),
          child: child,
        );
      },
      child: Center(
        child: Image.asset("assets/logo.png", height: 190),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
