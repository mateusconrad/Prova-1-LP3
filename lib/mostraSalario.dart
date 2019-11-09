import 'package:flutter/material.dart';

class MostraSalario extends StatefulWidget {
  String nomeFuncionario;
  double dependentes;
  double salarioBruto;
  double horas50;
  double horas100;

  MostraSalario(this.nomeFuncionario, this.dependentes, this.salarioBruto,
      this.horas50, this.horas100);

  @override
  _MostraSalarioState createState() => _MostraSalarioState();
}

class _MostraSalarioState extends State<MostraSalario> {
  double salarioLiquido = 0;
  double inss = 0; //porcentagem inss
  double ir = 0; //porcentagem imposto de renda
  double faixaInss = 0;
  double faixaIr = 0;
  double deducaoIr = 0;
  double descontos = 0;
  double valorDependente = 189.59;
  double valorHoras50 = 0;
  double valorHoras100 = 0;
  double valorHora = 0;
  double salarioFamilia = 0;

  @override
  void initState() {
    super.initState();
    calcIr();
    calcTotalDescontos();
    calcSalarioLiquido();
    calcHoras();
    calcSalarioFamilia();
  }

//. to sting as fixer
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculo Salario"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "NOME: " + widget.nomeFuncionario,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Nº Dependentes: " + widget.dependentes.toStringAsFixed(2),
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Salário Bruto: " + widget.salarioBruto.toStringAsFixed(2),
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "INSS: " +
                  inss.toStringAsFixed(2) +
                  "\nFaixa inss: " +
                  faixaInss.toStringAsFixed(2),
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "IR: " +
                  ir.toStringAsFixed(2) +
                  "\n Faixa ir: " +
                  faixaIr.toStringAsFixed(2),
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Horas 50%: " + valorHoras50.toStringAsFixed(2),
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Horas 100%: " + valorHoras100.toStringAsFixed(2),
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Total Descontos: " + descontos.toStringAsFixed(2),
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Salário Líquido: " + salarioLiquido.toStringAsFixed(2),
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  void calcSalarioLiquido() {
    calcIr();
    calcTotalDescontos();
    salarioLiquido = (widget.salarioBruto - descontos);
  }

  void calcTotalDescontos() {
    descontos = ir + inss;
  }

  void calcInss() {
    if (widget.salarioBruto <= 1757.81) {
      faixaInss = 8.00;
      inss = widget.salarioBruto * (faixaInss / 100);
    } else if ((widget.salarioBruto > 1757.81) &&
        (widget.salarioBruto <= 2919.72)) {
      faixaInss = 9.00;
      inss = widget.salarioBruto * (faixaInss / 100);
    } else if ((widget.salarioBruto > 2919.72) &&
        (widget.salarioBruto <= 5839.45)) {
      faixaInss = 11.00;
      inss = widget.salarioBruto * (faixaInss / 100);
    } else {
      faixaInss = 11.00;
      inss = 5839.45 * 0.11;
    }
  }

  void percentualDeducaoIr() {
    //
    if ((widget.salarioBruto - inss) <= 1903.98) {
      faixaIr = 1;
      deducaoIr = 0;
    } else if (((widget.salarioBruto - inss) > 1903.98) &&
        ((widget.salarioBruto - inss) <= 2826.65)) {
      faixaIr = 7.5;
      deducaoIr = 142.80;
    } else if (((widget.salarioBruto - inss) > 2826.65) &&
        ((widget.salarioBruto - inss) <= 3751.05)) {
      faixaIr = 15.00;
      deducaoIr = 354.80;
    } else if (((widget.salarioBruto - inss) > 3751.05) &&
        ((widget.salarioBruto - inss) <= 4664.68)) {
      faixaIr = 22.50;
      deducaoIr = 636.13;
    } else {
      faixaIr = 27.50;
      deducaoIr = 869.36;
    }
  }

  void calcIr() {
    calcInss();
    percentualDeducaoIr();
    if ((widget.dependentes == 0) && (faixaIr == 1)) {
    } else if ((widget.dependentes > 0) && (faixaIr == 1)) {
    } else if (widget.dependentes > 0 && (faixaIr > 1)) {
      ir =
          (widget.salarioBruto - inss) - (valorDependente * widget.dependentes);
      ir = ir * (faixaIr / 100); //
      ir = ir - deducaoIr;
    } else {
      ir = (widget.salarioBruto - inss);
      ir = ir * (faixaIr / 100); //
      ir = ir - deducaoIr;
    }
  }

  void calcHoras() {
    valorHora = widget.salarioBruto / 220; // horasmensais
    valorHoras50 = valorHora * widget.horas50 * 1.5; //calculo das horas com 50%
    valorHoras100 =
        valorHora * widget.horas100 * 2; //calculo das horas com 100%
  }

  void calcSalarioFamilia() {
    if (widget.salarioBruto + valorHoras50 + valorHoras100 <= 907.77) {
      salarioFamilia = 46.54;
    } else if ((widget.salarioBruto + valorHoras50 + valorHoras100 > 907.77) &&
        (widget.salarioBruto + valorHoras50 + valorHoras100 <= 1364.43)) {
      salarioFamilia = 32.80;
    } else {
      salarioFamilia = 0;
    }
  }
}

/*
Remuneração mensal Valor unitário da quota

Até R$ 907,77
  R$ 46,54
De R$ 907,77 até  R$ 1.364,43
  R$ 32,80
Acima de R$ 1.364,43
  Não tem direito à quota*/
