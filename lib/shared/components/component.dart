import 'package:flutter/material.dart';

Widget defaultButton({
  double width =double.infinity,
  Color background = Colors.pink,
 required void Function()? function ,
  required String text,
  double reduse =0.0,
  bool isUpperCase =true,
})=> Container(
  width: width,

  decoration: BoxDecoration(
    color:background,
    borderRadius: BorderRadius.circular(reduse)
  ),
  child: MaterialButton(
    onPressed: function,

    child:  Text(
       isUpperCase? text.toUpperCase():text,
      style: const TextStyle(
          color: Colors.white
      ),
    ),
  ),
);



Widget defaultTextFormFelid({
  required TextEditingController controller,
  required TextInputType type,
   required String lable,
  required IconData perfix,
  required String? Function(String?) validate,
   IconData? suffix,
  Function (String)? onSubmit,
  Function (String)? onChange,
  Function ()? onTap,
  Function? suffixPressed,
  bool isPassword =false,
  int? maxLiness = 1


})=> TextFormField(
maxLines: maxLiness,
     onTap: onTap,
        onFieldSubmitted: onSubmit,
      validator: validate,



         onChanged:onChange   ,
         controller:controller ,
          obscureText: isPassword,
         keyboardType:type,
         decoration:  InputDecoration(
         prefixIcon: Icon (perfix,),
         suffixIcon: suffix!=null?
         IconButton(
           onPressed:(){
             suffixPressed!();
           } ,
           icon:Icon(suffix),
          ):null,
         labelText:lable,
       border: const OutlineInputBorder(),

),
);


Widget buildItemTask(Map model)=> Card(
  margin:const EdgeInsets.all(10.0),
  child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 40,
          width: 80,
          decoration: BoxDecoration(
              color: Colors.blue[900],
              borderRadius: BorderRadius.circular(10.0)
          ),
          child: Center(child: Text('${model['time']}')),
        ),
        const SizedBox(width: 16.0,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children:  [
            Text('${model['title']}',
              style:const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Text(
              '${model['date']}',
              style:const TextStyle(

                fontSize: 15.0,
              ),
            )
          ],
        )
      ],
    ),
  ),
);