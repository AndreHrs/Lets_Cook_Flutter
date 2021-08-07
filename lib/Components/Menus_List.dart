import 'package:final_project/Models/MenuDetailsParam.dart';
import 'package:final_project/Models/MenuListModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<MenuListModel>> fetchData(String catName) async {
  final String url =
      'https://www.themealdb.com/api/json/v1/1/filter.php?c=' + catName;
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    var jsonData = jsonDecode(response.body);
    List<MenuListModel> dataList = [];

    for (var item in jsonData['meals']) {
      MenuListModel newData = MenuListModel(
        idMeal: item['idMeal'],
        strMeal: item['strMeal'],
        strMealThumb: item['strMealThumb'],
      );
      dataList.add(newData);
    }
    return dataList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}

class Menus_List extends StatefulWidget {
  final String categoryName;
  const Menus_List({Key? key, required this.categoryName}) : super(key: key);
  @override
  _Menus_ListState createState() => _Menus_ListState();
}

class _Menus_ListState extends State<Menus_List> {
  late Future<List<MenuListModel>> MenuDataList;

  @override
  void initState() {
    super.initState();
    MenuDataList = fetchData(widget.categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: MenuDataList,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text('Loading'),
              ),
            );
          } else {
            // Cast snapshot.data to certain type to safely proceed with null safety
            final data = snapshot.data as List<MenuListModel>;
            return ListView.separated(
                itemCount: data.length,
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemBuilder: (BuildContext context, int i) {
                  return GestureDetector(
                    child: (ListTile(
                      leading: CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(data[i].strMealThumb),
                      ),
                      title: Text(data[i].strMeal),
                    )),
                    onTap: () {
                      Navigator.pushNamed(context, '/menuDetails',
                          arguments: MenuDetailsParam(
                              randomize: false, idMeal: data[i].idMeal));
                    },
                  );
                });
          }
        },
      ),
    );
  }
}
