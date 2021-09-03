import 'package:final_project/Components/Menus_List.dart';
import 'package:final_project/Models/CategoriesModel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MenuList extends StatelessWidget {
  const MenuList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CategoriesModel;

    String getExcerpt(String fullText) {
      String firstParagraph = fullText.split('\n')[0];
      if (fullText.length <= 200) {
        return fullText;
      }
      else{
        if(firstParagraph.length <= 200){
          return firstParagraph;
        }
        else{
          return firstParagraph.substring(0, 200) + '...';
        }
      }
      
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(args.strCategory),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Column(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(
                      args.strCategoryThumb,
                      height: 150,
                      width: 160,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                        child: RichText(
                      text: TextSpan(
                        text: getExcerpt(args.strCategoryDescription),
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        children: <TextSpan>[
                          args.strCategoryDescription.length >
                                  200
                              ? TextSpan(
                                  text: '\nclick here to read details',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                          context, '/catDetails',
                                          arguments: args);
                                    })
                              : TextSpan(
                                  text: '',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.blue),
                                )
                        ],
                      ),
                    ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text(
                    'Menus from this Category',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )
                ]),
                Expanded(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  child: Menus_List(categoryName: args.strCategory),
                ),
              ]),
            )));
  }
}
