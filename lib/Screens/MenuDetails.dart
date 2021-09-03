import 'dart:convert';
import 'dart:developer';

import 'package:final_project/Components/CategoriesList.dart';
import 'package:final_project/Components/MenuDetailsComponent.dart';
import 'package:final_project/Models/MenuDetailsModel.dart';
import 'package:final_project/Models/MenuDetailsParam.dart';
import 'package:final_project/Models/MenuListModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MenuDetails extends StatefulWidget {
  const MenuDetails({Key? key}) : super(key: key);

  @override
  _MenuDetailsState createState() => _MenuDetailsState();
}

class _MenuDetailsState extends State<MenuDetails> {
  late Future<MenuDetailsModel> menuDetails;

  Future<MenuDetailsModel> fetchData(bool randomize, String? mealId) async {
    final String url = 'https://www.themealdb.com/api/json/v1/1/' +
        (randomize ? ('random.php') : ('lookup.php?i=' + mealId!));
    print('String url ${url}');

    final response = await http.get(Uri.parse(url));
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Get details data')));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonData = jsonDecode(response.body);
      print(jsonDecode(response.body));
      List<MenuDetailsModel> dataList = [];

      for (var item in jsonData['meals']) {
        MenuDetailsModel newData = MenuDetailsModel.fromJson(item);
        dataList.add(newData);
      }
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Fetched Data')));
      return dataList[0];
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as MenuDetailsParam;
    final idMeal = args.randomize ? '' : args.idMeal;
    setState(() {
      fetchData(args.randomize, idMeal);
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as MenuDetailsParam;
    final idMeal = args.randomize ? '' : args.idMeal;
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Details'),
      ),
      body: Center(
        child: FutureBuilder(
            future: fetchData(args.randomize, idMeal), //Coba ganti jadi menuDetails
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Loading_Details();
              } else {
                final data = snapshot.data as MenuDetailsModel;
                return SingleChildScrollView(
                  child: MenuDetailsComponent(data: data),
                );
              }
            }),
      ),
    );
  }
}

class Loading_Details extends StatelessWidget {
  const Loading_Details({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Loading Menu Details'),
    );
  }
}
