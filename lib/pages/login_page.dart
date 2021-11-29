import 'package:express_examenu3/models/usuario.dart';
import 'package:express_examenu3/services/auth_services.dart';
import 'package:express_examenu3/widgets/custom_button.dart';
import 'package:express_examenu3/widgets/custom_input.dart';
//import 'package:express_examenu3/widgets/custom_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(2, 48, 71, 1),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Container(
            //Toda la pantalla
            height: MediaQuery.of(context).size.height * .9,
            child: Column(
              children: [
                //CustomLogo(texto: 'Usuario'),
                _Form(),
                /*CustomLabel(
                  texto: 'Crear Cuenta',
                  color: Color.fromRGBO(146, 184, 31, 1),
                  ruta: 'register',
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  _Form({Key? key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  List<Usuario> response = [];

  final nombreCtrl = TextEditingController();
  final apeCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    Future getUsers() async {
      authService.getUser().then(
        (value) {
          response = value;
          setState(() {});
        },
      );
    }

    getUsers();

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          CustomInput(
              icono: Icons.person,
              placeHolder: 'Nombre',
              keyboardType: TextInputType.emailAddress,
              textController: nombreCtrl),
          CustomInput(
            icono: Icons.person,
            placeHolder: 'Apellido',
            keyboardType: TextInputType.text,
            textController: apeCtrl,
          ),
          CustomButton(
            texto: 'Registrar',
            onPressed: authService.autenticando
                ? () => {}
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginRes =
                        await authService.login(nombreCtrl.text, apeCtrl.text);
                    if (loginRes) {
                      //Navigator.pushNamed(context, 'usuarios');
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      //Mostrar alerta
                      /*mostrarAlerta(context, 'Error en el login',
                          'Credenciales incorrectas');*/
                    }
                    //Navigator.pushReplacementNamed(context, 'usuarios');
                  },
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: response
                  .map((e) => Text(
                        '${e.nombre} ${e.apellido}',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
