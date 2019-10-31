import 'package:app_prova_1_11/mostraSalario.dart';-
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
  TextEditingController horas80 = TextEditingController();
  TextEditingController horas100 = TextEditingController();

  var focusNome = new FocusNode();
  var focusDependentes = new FocusNode();
  var focusSalario = new FocusNode();
  var focusHoras80 = new FocusNode();
  var focusHoras100 = new FocusNode();

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
              ), // numero dependenets
              TextFormField(
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
              ),
              TextFormField(/////////////////////////////////////////////////////////////////////////////////////////
                focusNode: focusHoras80,
              //  autofocus: true,
                controller: horas80,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "horas 50%",
                    suffixIcon: Icon(Icons.access_time)
                ),
              ),
              TextFormField(/////////////////////////////////////////////////////////////////////////////////////////
                focusNode: focusHoras100,
                //autofocus: true,
                //controller: horas100,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "horas 100%",
                    suffixIcon: Icon(Icons.access_time)
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
                          double.parse(horas80.text),
                          double.parse(horas100.text),
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