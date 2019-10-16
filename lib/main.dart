import 'package:app_prova_1_11/mostraSalario.dart';
import 'package:flutter/material.dart';
//import 'mostraConta.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
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

  var focusNome = new FocusNode();
  var focusDependentes = new FocusNode();
  var focusSalario = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prova 1 - LP3"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Form(
          key: formkey,
          child: Column(
            children: <Widget>[
              Text("Cálculo IMC"),
              Image.asset("images/download.png"),
              TextFormField(
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
              ), //nome
              TextFormField(
                focusNode: focusDependentes,
                autofocus: true,
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
              ), // numero dependenets
              TextFormField(
                focusNode: focusSalario,
                autofocus: true,
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
              ),
              SizedBox(height: 25,),
              RaisedButton(
                child: Text("Calcular"),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  if (formkey.currentState.validate()){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>
                        MostraSalario(
                          nomeFuncionario.text,
                          int.parse(dependentesFuncionario.text),
                          double.parse(salarioBrutoFuncionario.text),
                        ),
                    ));
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

}



//pubspec.yml

//assets:      images/   kakaka.jpg