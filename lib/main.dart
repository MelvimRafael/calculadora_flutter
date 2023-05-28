
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  //const Calculadora({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  Widget botao(String textobtn, Color corbtn, Color cortexto) {
    return Container(
      child: MaterialButton(
        color: corbtn,
        onPressed: () {
          calculation(textobtn);
        },
        child: Text(
          textobtn,
          style: TextStyle(
            fontSize: 35,
            color: cortexto,
          ),
        ),
        padding: EdgeInsets.all(20),
        shape: CircleBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        title: Text('Calculadora'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //tela resutado
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    texto,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 100),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                botao('AC', Colors.grey, Colors.black),
                botao('+/-', Colors.grey, Colors.black),
                botao('%', Colors.grey, Colors.black),
                botao('/', Colors.amber[700]!, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                botao('7', Colors.grey[850]!, Colors.white),
                botao('8', Colors.grey[850]!, Colors.white),
                botao('9', Colors.grey[850]!, Colors.white),
                botao('x', Colors.amber[700]!, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                botao('4', Colors.grey[850]!, Colors.white),
                botao('5', Colors.grey[850]!, Colors.white),
                botao('6', Colors.grey[850]!, Colors.white),
                botao('-', Colors.amber[700]!, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                botao('1', Colors.grey[850]!, Colors.white),
                botao('2', Colors.grey[850]!, Colors.white),
                botao('3', Colors.grey[850]!, Colors.white),
                botao('+', Colors.amber[700]!, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                  onPressed: () {
                    calculation('0');
                  },
                  shape: StadiumBorder(),
                  child: Text(
                    "0",
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                  color: Colors.grey[850],
                ),
                botao('.', Colors.grey[850]!, Colors.white),
                botao('=', Colors.amber[700]!, Colors.white),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

//Logica
  dynamic texto = '0';
  double numUm = 0;
  double numDois = 0;

  dynamic resultado = '';
  dynamic resultadoFinal = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {
    if (btnText == 'AC') {
      texto = '0';
      numUm = 0;
      numDois = 0;
      resultado = '';
      resultadoFinal = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        resultadoFinal = add();
      } else if (preOpr == '-') {
        resultadoFinal = sub();
      } else if (preOpr == 'x') {
        resultadoFinal = mul();
      } else if (preOpr == '/') {
        resultadoFinal = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numUm == 0) {
        numUm = double.parse(resultado);
      } else {
        numDois = double.parse(resultado);
      }

      if (opr == '+') {
        resultadoFinal = add();
      } else if (opr == '-') {
        resultadoFinal = sub();
      } else if (opr == 'x') {
        resultadoFinal = mul();
      } else if (opr == '/') {
        resultadoFinal = div();
      }
      preOpr = opr;
      opr = btnText;
      resultado = '';
    } else if (btnText == '%') {
      resultado = numUm / 100;
      resultadoFinal = doesContainDecimal(resultado);
    } else if (btnText == '.') {
      if (!resultado.toString().contains('.')) {
        resultado = resultado.toString() + '.';
      }
      resultadoFinal = resultado;
    } else if (btnText == '+/-') {
      resultado.toString().startsWith('-')
          ? resultado = resultado.toString().substring(1)
          : resultado = '-' + resultado.toString();
      resultadoFinal = resultado;
    } else {
      resultado = resultado + btnText;
      resultadoFinal = resultado;
    }

    setState(() {
      texto = resultadoFinal;
    });
  }

  String add() {
    resultado = (numUm + numDois).toString();
    numUm = double.parse(resultado);
    return doesContainDecimal(resultado);
  }

  String sub() {
    resultado = (numUm - numDois).toString();
    numUm = double.parse(resultado);
    return doesContainDecimal(resultado);
  }

  String mul() {
    resultado = (numUm * numDois).toString();
    numUm = double.parse(resultado);
    return doesContainDecimal(resultado);
  }

  String div() {
    resultado = (numUm / numDois).toString();
    numUm = double.parse(resultado);
    return doesContainDecimal(resultado);
  }

  String doesContainDecimal(dynamic resultado) {
    if (resultado.toString().contains('.')) {
      List<String> splitDecimal = resultado.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return resultado = splitDecimal[0].toString();
    }
    return resultado;
  }
}
