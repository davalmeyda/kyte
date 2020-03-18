import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kytestore/Providers/LoginProvider.dart';
import 'package:kytestore/componentes/Login/curva.dart';
import 'package:kytestore/componentes/Login/logo.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  LoginProvider loginProvider = new LoginProvider();

  // Boton Login
  Widget botonLogin(String text, Color splashColor, Color highlightColor,
      Color fillColor, Color textColor, void function()) {
    return RaisedButton(
      highlightElevation: 0.0,
      splashColor: splashColor,
      highlightColor: highlightColor,
      elevation: 0.0,
      color: fillColor,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: textColor, fontSize: 20),
      ),
      onPressed: () {
        function();
      },
    );
  }

  // Input de Login
  Widget _inputText(
      Icon icon, String hint, TextEditingController controller, bool obsecure) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        keyboardType: obsecure == false
            ? TextInputType.emailAddress
            : TextInputType.visiblePassword,
        controller: controller,
        obscureText: obsecure,
        style: TextStyle(
          fontSize: 20,
        ),
        decoration: InputDecoration(
            hintStyle: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
            hintText: hint,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 3,
              ),
            ),
            prefixIcon: Padding(
              child: IconTheme(
                data: IconThemeData(color: Theme.of(context).primaryColor),
                child: icon,
              ),
              padding: EdgeInsets.only(left: 30, right: 10),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).accentColor,
      body: Column(
        children: <Widget>[
          Logo(),
          SizedBox(
            height: 60,
          ),
          _inputText(Icon(Icons.account_circle), "Nombre de Usuario",
              _emailController, false),
          SizedBox(
            height: 20,
          ),
          _inputText(Icon(Icons.lock), "Contraseña", _passwordController, true),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 50,
                    child: botonLogin(
                      "Ingresar",
                      Colors.black,
                      Colors.white,
                      Colors.white,
                      Theme.of(context).accentColor,
                      () => validarUsuario(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          curva()
        ],
      ),
    );
  }

  // Alerta
  void _showDialog({String title, String content}) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(content),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future validarUsuario() async {
    try {
      String resultado =
          await signIn(_emailController.text, _passwordController.text);
      await loginProvider.rolUsuario(resultado);
      Navigator.pushReplacementNamed(context, "venderView");
    } catch (error) {
      _showDialog(content: error, title: "error");
      return null;
    }
  }

  // Validar Inicio de sesion
  Future<String> signIn(String email, String password) async {
    FirebaseUser user;
    String errorMessage;

    try {
      final auth = FirebaseAuth.instance;
      AuthResult result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = result.user;
    } catch (error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Ingrese una direccion de correo electronico valida.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "La contraseña es incorrecta.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "No existe este Usuario.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage =
              "El usuario con este correo electrónico ha sido deshabilitado.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Demasiadas intentos. Inténtalo de nuevo más tarde.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage =
              "Iniciar sesión con correo electrónico y contraseña no está habilitado.";
          break;
        default:
          errorMessage = "Ocurrió un error indefinido.";
      }
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    return user.uid;
  }
}
