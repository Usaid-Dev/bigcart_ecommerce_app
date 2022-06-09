import 'package:flutter/material.dart';

class custom_textfield extends StatelessWidget {
  final InputDecoration inputDecoration;
  final bool obscure_txt;
  final TextInputType txt_input_type;
  final Color txtfield_color;
  final double txtfield_padding;
  final FormFieldValidator fieldValidator;
  final FormFieldSetter onsaved;

  const custom_textfield
      ({Key? key, required this.inputDecoration,
    this.obscure_txt=false,
    this.txt_input_type=TextInputType.text,
    this.txtfield_color=Colors.white,
    this.txtfield_padding=10, required this.fieldValidator,
    required this.onsaved}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 17,right: 17),
        padding:  EdgeInsets.all(txtfield_padding),
        decoration: BoxDecoration(
            color: txtfield_color,
            borderRadius: BorderRadius.circular(5)),
        child: TextFormField(
          validator: fieldValidator,
          onSaved: onsaved,
          keyboardType: txt_input_type,
          obscureText: obscure_txt,
          style: const TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w500),
          decoration: inputDecoration)
    );
  }
}
