import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripshiptask/Utils/colors.dart';

class MyForm extends StatelessWidget {
  bool isBorderVisible = true;
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return 
          Card(
            child: Container(
              alignment: Alignment.center,
             
              width: 300.w,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5.r),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffF1F4F9).withOpacity(0.5), //color of shadow
                      spreadRadius: 8, //spread radius
                      blurRadius: 7, // blur radius
                      offset: Offset(3, 5), // changes position of shadow
                    
                    ),
                  ]),
              // padding: const EdgeInsets.all(5.0),
             
                child: TextFormField(
                  controller: _textController,
                  decoration: InputDecoration(
                      hintText: 'Enter text',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      border: InputBorder.none
                      // border: isBorderVisible
                      //     ? OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(5.0),
                      //       )
                      //     : InputBorder.none,
                      ),
                  style: TextStyle(fontSize: 13.sp),
                  //  keyboardType: TextInputType.text,
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  // onTap: () {
                  //   setState(() {
                  //     isBorderVisible = false;
                  //   });
                  // },
                  // onFieldSubmitted: (value) {
                  //   setState(() {
                  //     isBorderVisible = true;
                  //   });
                  // },
                ),
              
            
                   
                  
                
              ),
          );
  }
}
