import 'package:app_prova_1_11/mostraSalario.dart';
import 'package:flutter/material.dart';
//import 'mostraConta.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blueAccent,
    )
  ));
}

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController nomeFuncionario = TextEditingController();
  TextEditingController dependentesFuncionario = TextEditingController();
  TextEditingController salarioBrutoFuncionario = TextEditingController();
  TextEditingController horas50 = TextEditingController();
  TextEditingController horas100 = TextEditingController();

  var focusNome = new FocusNode();
  var focusDependentes = new FocusNode();
  var focusSalario = new FocusNode();
  var focusHoras50 = new FocusNode();
  var focusHoras100 = new FocusNode();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Folha de Pagamento"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              fieldNome(context), //nome
              fieldDependentes(context), // numero dependenets
              fieldSalarioBruto(context),
              fieldHoras50(context),
              fieldHoras100(context),
              SizedBox(height: 25,),
              buttonCalculaSalario(context),
              RaisedButton(
                child: Text("Limpar Campos"),
                textColor: Colors.white,
                color: Colors.lightBlue,
                onPressed: (){
                  setState(() {
                    nomeFuncionario.clear();
                    dependentesFuncionario.clear();
                    salarioBrutoFuncionario.clear();
                    horas50.clear();
                    horas100.clear();
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  TextFormField fieldNome(BuildContext context) {
    return TextFormField(
      //key: formkey,
      focusNode: focusNome,
      autofocus: true,
      textInputAction: TextInputAction.next,
      validator: (valor){
        if (valor.isEmpty) {
          FocusScope.of(context).requestFocus(focusNome);
          return "Informe o nome!";
        } else {
          return null;
        }
      },
      controller: nomeFuncionario,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.person),
        labelText: "Nome",
      ),
    );
  }

  TextFormField fieldDependentes(BuildContext context) {
    return TextFormField(
      focusNode: focusDependentes,
      //autofocus: true,
      validator: (valor){
        if (valor.isEmpty) {
          FocusScope.of(context).requestFocus(focusDependentes);
          return "Informe o número de dependentes!";
        } else {
          return null;
        }
      },
      controller: dependentesFuncionario,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: "Dependentes",
          suffixIcon: Icon(Icons.people)
      ),
    );
  }

  TextFormField fieldSalarioBruto(BuildContext context) {
    return TextFormField(
      focusNode: focusSalario,
      //   autofocus: true,
      validator: (valor){
        if (valor.isEmpty) {
          FocusScope.of(context).requestFocus(focusSalario);
          return "Informe o Salário Bruto!";
        } else {
          return null;
        }
      },
      controller: salarioBrutoFuncionario,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: "Salário Bruto",
          suffixIcon: Icon(Icons.attach_money)
      ),
    );
  }

  TextFormField fieldHoras50(BuildContext context) {
    return TextFormField(/////////////////////////////////////////////////////////////////////////////////////////
              focusNode: focusHoras50,
            //  autofocus: true,
              controller: horas50,
              validator: (valor){
                if (valor.isEmpty) {
                  FocusScope.of(context).requestFocus(focusNome);
                  return "Informe a quantidade de Horas!";
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "horas 50%",
                  suffixIcon: Icon(Icons.access_time)
              ),
            );
  }

  TextFormField fieldHoras100(BuildContext context) {
    return TextFormField(/////////////////////////////////////////////////////////////////////////////////////////
      focusNode: focusHoras100,
      //autofocus: true,
      controller: horas100,
      validator: (valor){
        if (valor.isEmpty) {
          FocusScope.of(context).requestFocus(focusNome);
          return "Informe a quantidade de Horas!";
        } else {
          return null;
        }
      },

      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: "horas 100%",
          suffixIcon: Icon(Icons.access_time)
      ),
    );
  }

  RaisedButton buttonCalculaSalario(BuildContext context) {
    return RaisedButton(
        child: Text("Calcular"),
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: () {
          if (formkey.currentState.validate()){
            Navigator.push(context, MaterialPageRoute(
              builder: (context)=>
                  MostraSalario(
                    nomeFuncionario.text,
                    double.parse(dependentesFuncionario.text),
                    double.parse(salarioBrutoFuncionario.text),
                    double.parse(horas50.text),
                    double.parse(horas100.text),
                  ),
            ));
          }
        }
    );
  }





}