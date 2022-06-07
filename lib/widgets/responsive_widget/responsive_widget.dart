import 'package:flutter/material.dart';


class ResponsiveWidget extends StatelessWidget {
  final Widget child;
   ResponsiveWidget({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(constraints: BoxConstraints(
        maxWidth: 600,
        
      ),
      child: child,
      ),);
  }
}