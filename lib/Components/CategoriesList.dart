import 'package:final_project/Models/CategoriesModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<CategoriesModel>> fetchData() async {
  final String url = 'https://www.themealdb.com/api/json/v1/1/categories.php';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    var jsonData = jsonDecode(response.body);
    List<CategoriesModel> dataList = [];

    for (var item in jsonData['categories']) {
      CategoriesModel newData = CategoriesModel(
          idCategory: item['idCategory'],
          strCategory: item['strCategory'],
          strCategoryThumb: item['strCategoryThumb'],
          strCategoryDescription: item['strCategoryDescription']);
      dataList.add(newData);
    }
    return dataList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}

class Categories_List extends StatefulWidget {
  const Categories_List({Key? key}) : super(key: key);
  @override
  _Categories_ListState createState() => _Categories_ListState();
}

class _Categories_ListState extends State<Categories_List> {
  late Future<List<CategoriesModel>> catDataList;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   setState(() {
  //     getJsonData();
  //   });
  // }
  @override
  void initState() {
    super.initState();
    catDataList = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: catDataList,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text('Loading'),
              ),
            );
          } else {
            // Cast snapshot.data to certain type to safely proceed with null safety
            final data = snapshot.data as List<CategoriesModel>;
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
                        backgroundImage: NetworkImage(data[i].strCategoryThumb),
                      ),
                      title: Text(data[i].strCategory),
                      subtitle: Text(data[i].strCategoryDescription.substring(0,40) + '...'),
                    )),
                    onTap: () {
                      Navigator.pushNamed(context, '/menuList', arguments: data[i]);
                    },
                  );
                });
          }
        },
      ),
    );
  }
}
