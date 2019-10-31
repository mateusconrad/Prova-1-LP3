import 'package:flutter/material.dart';

class MostraSalario extends StatefulWidget {
  String nomeFuncionario;
  int dependentes;
  double salarioBruto;
  double horas80;
  double horas100;
  MostraSalario(this.nomeFuncionario, this.dependentes, this.salarioBruto,
      this.horas80, this.horas100);

  @override
  _MostraSalarioState createState() => _MostraSalarioState();
}

class _MostraSalarioState extends State<MostraSalario> {
  double salarioLiquido = 0;
  double inss = 0; //porcentagem inss
  double ir = 0; //porcentagem imposto de renda
  double faixaInss=0;
  double faixaIr=0;
  double deducaoIr=0;
  double descontos=0;
  double valorDependente = 189.59;
  double horas80;
  double horas100;

  @override
  void initState(){
    super.initState();
    calcIr();
    calcTotalDescontos();
    calcSalarioLiquido();
    calcHoras();

  }
//. to sting as fixer
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculo Salario"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("NOME: " + widget.nomeFuncionario),
            Text("Nº Dependentes: " + widget.dependentes.toStringAsFixed(2)),
            Text("Salário Bruto: " + widget.salarioBruto.toStringAsFixed(2)),
            Text("INSS: "+ inss.toString() + "\n Faixa inss: " + faixaInss.toStringAsFixed(2)),
            Text("IR: "+ ir.toString() + "\n Faixa ir: " + faixaIr.toStringAsFixed(2)),
            Text("Horas 80%: " + horas80.toStringAsFixed(2)),
            Text("Horas 100%: "+ horas100.toStringAsFixed(2)),
            Text("Total Descontos: " + descontos.toStringAsFixed(2)),
            Text("Salário Líquido: " + salarioLiquido.toStringAsFixed(2)),

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
    if (widget.salarioBruto <= 1757.81){
      faixaInss = 8.00;
      inss = widget.salarioBruto * (faixaInss/100);
    }else if ((widget.salarioBruto > 1757.81) && (widget.salarioBruto <= 2919.72)){
      faixaInss = 9.00;
      inss = widget.salarioBruto * (faixaInss/100);
    }else if ((widget.salarioBruto > 2919.72) && (widget.salarioBruto <= 5839.45)){
      faixaInss = 11.00;
      inss = widget.salarioBruto * (faixaInss/100);
    }else{
      faixaInss = 11.00;
      inss = 5839.45 * 0.11;
    }
  }
  void percentualDeducaoIr(){

    if (((widget.salarioBruto-inss) > 1903.98) && ((widget.salarioBruto-inss) <= 2826.65)){
      faixaIr = 7.5;
      deducaoIr =142.80;
    }else if (((widget.salarioBruto-inss) > 2826.65) && ((widget.salarioBruto-inss) <= 3751.05)){
      faixaIr = 15.00;
      deducaoIr = 354.80;
    }else if (((widget.salarioBruto-inss) > 3751.05) && ((widget.salarioBruto-inss) <= 4664.68)){
      faixaIr = 22.50;
      deducaoIr = 636.13;
    }else{
      faixaIr = 27.50;
      deducaoIr = 869.36;
    }

  }
  void calcIr() {
    calcInss();
    percentualDeducaoIr();
    if (widget.dependentes>0) {
      //ir = ((widget.salarioBruto - inss) - (valorDependente * widget.dependentes) * (faixaIr/100)-deducaoIr);
       ir = (widget.salarioBruto - inss) - (valorDependente * widget.dependentes);
       ir = ir * (faixaIr/100);  //
       ir = ir -deducaoIr;
    } else {
      ir = (widget.salarioBruto - inss);
      ir = ir * (faixaIr/100);  //
      ir = ir - deducaoIr;

   }
  }

  void calcHoras(){
    double valorHora = widget.salarioBruto / 220; // horasmensais
    horas80 = valorHora * widget.horas80 * 1.5;
    horas100 = valorHora * widget.horas100* 2;

  }
}
