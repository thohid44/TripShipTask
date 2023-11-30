import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyWidget extends StatefulWidget {
   var list=[];
  var id; 
  var name;
 MyWidget(this.list, this.id,this.name);


  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool isSelect =false; 
var selectedValue;  
var classValue;
  @override
  Widget build(BuildContext context) {
    return  Container(
              alignment: Alignment.center,
              height: 35.h,
              width: 320.w,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.r)),
             child:  DropdownButton(
                      hint:
                          Text("${isSelect ? selectedValue : 'Select Category'}"),
                      underline: SizedBox(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      value: classValue,
                      items: widget.list
                          .map((e) => DropdownMenuItem(
                                onTap: () {
                                  selectedValue = e['name'].toString();
                                  widget.name = e['name'].toString();
                                //       print("Name print from custm widget ${widget.name}");
                                },
                                value: e['id'],
                                child: Text(
                                  "${e['name']}",
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        var id = value;
                    print("Category Id $id");
                        // _con.getClassId(value.toString());
                        setState(() {
                          widget.id = value.toString();
                    //      print("Id print from custm widget ${widget.id}");

                  isSelect = true; 
                        });
                      })
            );
          
  }
}


//  Container(
//               alignment: Alignment.center,
//               height: 35.h,
//               width: 320.w,
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(10.r)),
//              child:  DropdownButton(
//                       hint:
//                           Text("${isSelect ? selectedValue : 'Select Category'}"),
//                       underline: SizedBox(),
//                       icon: const Icon(Icons.keyboard_arrow_down),
//                       value: classValue,
//                       items: categories
//                           .map((e) => DropdownMenuItem(
//                                 onTap: () {
//                                   selectedValue = e['name'].toString();
//                                 },
//                                 value: e['id'],
//                                 child: Text(
//                                   "${e['name']}",
//                                 ),
//                               ))
//                           .toList(),
//                       onChanged: (value) {
//                         var id = value;
//                     print("Category Id $id");
//                         // _con.getClassId(value.toString());
//                         setState(() {
//                           classId = value.toString();
//                      isSelect = true; 
//                         });
//                       })
//             ),
          