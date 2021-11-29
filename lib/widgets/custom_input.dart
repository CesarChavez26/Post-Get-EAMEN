import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final TextInputType keyboardType;
  final IconData icono;
  final String placeHolder;
  final bool isPassword;
  final TextEditingController textController;
  const CustomInput({
    Key? key,
    this.keyboardType = TextInputType.text,
    required this.icono,
    required this.placeHolder,
    this.isPassword = false,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 15),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: Color.fromRGBO(33, 158, 188, 1),
          borderRadius: BorderRadius.circular(20)),
      child: TextField(
        controller: textController,
        autocorrect: false,
        keyboardType: keyboardType,
        //Reemplazar el texto por *
        obscureText: isPassword,
        style: TextStyle(color: Colors.white, fontSize: 20),
        decoration: InputDecoration(
            prefixIcon: Icon(
              icono,
              color: Color.fromRGBO(255, 183, 3, 1),
            ),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: placeHolder,
            hintStyle: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    );
  }
}
