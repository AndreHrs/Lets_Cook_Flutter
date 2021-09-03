import 'package:final_project/Models/models.dart';
import 'package:flutter/material.dart';

class CategoryDetails extends StatelessWidget {
  const CategoryDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CategoriesModel;
    return Scaffold(
        appBar: AppBar(
          title: Text(args.strCategory),
        ),
        body: (Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.network(
                    args.strCategoryThumb,
                    height: 190,
                    width: 200,
                  ),
                ]),
                SizedBox(
                  width: 10,
                ),
                Text(args.strCategoryDescription)
              ],
            ),
          ),
        )));
  }
}
