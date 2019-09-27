import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
	@override
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType{
	login,
	cadastrar,
	esqueci
}

class _LoginPageState extends State<LoginPage> {

	final formKey = new GlobalKey<FormState>();

	FormType _formType = FormType.login;

	String _nome,
	       _cpf,
				 _email, 
		     _senha,
				 _dicaSenha;

	@override
	Widget build(BuildContext context) {
		return new Scaffold(
			appBar: new AppBar(
				title: new Text("Login"),
		  	),
			body: new Container(
				padding: EdgeInsets.all(16.0),
				child: new Form(
					key: formKey,
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.stretch,
						children: buildInputs() + buildButtons(),
					)
				)
			)
	  );
	}

	List<Widget> buildInputs() {
		List<Widget> arrayInputs = [
			new TextFormField(
				decoration: new InputDecoration(labelText: 'Email'),
				validator: (value) => value.isEmpty ? 'O campo email é obrigatório!' : null,
				onSaved: (value) => _email = value,
			),
		];

		if(_formType == FormType.login){
			arrayInputs += [
				new TextFormField(
					decoration: new InputDecoration(labelText: 'Senha'),
					obscureText: true,
					validator: (value) => value.isEmpty ? 'O campo senha é obrigatório!' : null,
					onSaved: (value) => _senha = value,
				),
			];
		} else if(_formType == FormType.cadastrar) {
			arrayInputs += [
				new TextFormField(
					decoration: new InputDecoration(labelText: 'Nome'),
					validator: (value) => value.isEmpty ? 'O campo nome é obrigatório!' : null,
					onSaved: (value) => _nome = value,
				),
				new TextFormField(
					decoration: new InputDecoration(labelText: 'CPF'),
					validator: (value) => value.isEmpty ? 'O campo CPF é obrigatório!' : null,
					onSaved: (value) => _cpf = value,
				),
				new TextFormField(
					decoration: new InputDecoration(labelText: 'Senha'),
					obscureText: true,
					validator: (value) => value.isEmpty ? 'O campo senha é obrigatório!' : null,
					onSaved: (value) => _senha = value,
				),
				new TextFormField(
					decoration: new InputDecoration(labelText: 'Dica de senha'),
					validator: (value) => value.isEmpty ? 'O campo dica de senha é obrigatório!' : null,
					onSaved: (value) => _dicaSenha = value,
				),
			];
		} else {
			arrayInputs += [
				new TextFormField(
					decoration: new InputDecoration(labelText: 'CPF'),
					validator: (value) => value.isEmpty ? 'O campo CPF é obrigatório!' : null,
					onSaved: (value) => _cpf = value,
				),
			];
		}

		return arrayInputs;
	}

	List<Widget> buildButtons() {
		List<Widget> arrayButtons = [];

		if(_formType == FormType.login){
			return [
				new RaisedButton(
					child: new Text("Login", style: new TextStyle(fontSize: 17.0)),
					onPressed: logarUsuario,
				),
				new FlatButton(
					child: new Text("Não é cadastrado? Clique aqui", style: new TextStyle(fontSize: 15.0)),
					onPressed: moverCadastro,
				),
				new FlatButton(
					child: new Text("Esqueci minha senha :(", style: new TextStyle(fontSize: 12.0)),
					onPressed: moverEsqueci,
				)
			];
		} else if(_formType == FormType.cadastrar) {
			arrayButtons += [
				new RaisedButton(
					child: new Text("Cadastrar", style: new TextStyle(fontSize: 17.0)),
					onPressed: cadastrarUsuario,
				),
			];
		} else {
			arrayButtons += [
				new RaisedButton(
					child: new Text("Dica de Senha", style: new TextStyle(fontSize: 17.0)),
					onPressed: cadastrarUsuario,
				),
			];
		}

		return arrayButtons += [
			new FlatButton(
				child: new Text("Cancelar", style: new TextStyle(fontSize: 15.0)),
				onPressed: moverLogin,
			)
		];
	}

	bool validaDados() {
		final form = formKey.currentState;

		if (form.validate()){
			form.save();
			return true;
    } else
			return false;
	}

	void moverLogin(){
		formKey.currentState.reset();
		setState(() {
			_formType = FormType.login;
		});
	}

	void moverCadastro(){
		formKey.currentState.reset();
		setState(() {
			_formType = FormType.cadastrar;
		});
	}

	void moverEsqueci(){
		formKey.currentState.reset();
		setState(() {
			_formType = FormType.esqueci;
		});
	}

	void cadastrarUsuario() async {
		if(validaDados()){
			try {
				AuthResult user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _senha);
				print("Created: $user");
			} catch (error) {
				print("Error:  $error");
			}
		}
	}

	void logarUsuario() async {
		if(validaDados()){
			try {
				AuthResult user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _senha);
				print("Signed in: $user");
			} catch (error) {
				print("Error:  $error");
			}
		}
	}

	void esqueciSenha(){
		// TDB
	}
}