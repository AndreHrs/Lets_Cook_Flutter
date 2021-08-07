import 'package:final_project/Components/Menus_List.dart';
import 'package:final_project/Models/CategoriesModel.dart';
import 'package:flutter/material.dart';

class MenuList extends StatelessWidget {
  const MenuList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CategoriesModel;
    return Scaffold(
        appBar: AppBar(
          title: Text(args.strCategory),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                  Flexible(child: Text(args.strCategoryDescription.split('\n')[0]))
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
                child: Menus_List(categoryName : args.strCategory),
              ),
            ])));
  }
}
