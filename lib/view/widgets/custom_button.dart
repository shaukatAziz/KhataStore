import 'package:flutter/material.dart';
class RoundButton extends StatelessWidget {
  const RoundButton({super.key,
     this.width=200,
     this.height=50,
    required this.onpress,
     this.ButtonColor=Colors.blueAccent,
    this.textColors,
     this.loading=false,
    required this.title
  });
   final double width,height;
   final VoidCallback onpress;
   final  ButtonColor,textColors;
   final bool loading;
   final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
           InkWell(
             onTap: onpress,
             child:Container(
               width: width,
               height: height,
               decoration: BoxDecoration(
                 color: ButtonColor,
                 borderRadius:BorderRadius.circular(50),
                 
               ),
               child: loading?Center(child: CircularProgressIndicator(),):
               Center(child: Text(title,style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white70),),)
             ) ,
           )
      ],

    );
  }
}
