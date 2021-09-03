import 'package:final_project/Models/MenuDetailsModel.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void _launchURL(String _url) async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

class MenuDetailsComponent extends StatefulWidget {
  final MenuDetailsModel data;
  const MenuDetailsComponent({required this.data});

  @override
  _MenuDetailsComponentState createState() => _MenuDetailsComponentState();
}

class _MenuDetailsComponentState extends State<MenuDetailsComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: <Widget>[
                  Image.network(
                    widget.data.strMealThumb,
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  widget.data.strMeal,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            '${widget.data.strCategory}, ${widget.data.strArea}',
            style: TextStyle(fontSize: 14),
          ),
          makeTitle('Ingredients'),
          SizedBox(
            height: 5,
          ),
          ...(getIngredientRows(widget.data)), // Spread Operator
          SizedBox(
            height: 20,
          ),
          makeTitle('Instruction'),
          Text(widget.data.strInstructions),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              _launchURL(widget.data.strYoutube);
            },
            child: Text(
              'View youtube Instruction',
              style: TextStyle(fontSize: 20),
            ),
            style: ButtonStyle(),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}

Widget makeTitle(String usedText) {
  Widget returnedWidget = Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        usedText,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      )
    ],
  );
  return returnedWidget;
}

List<Widget> getIngredientRows(MenuDetailsModel data) {
  Map dataJson = data.toJson();
  List<Widget> widgetList = [];
  for (int i = 1; i <= 20; i++) {
    if (
      dataJson["strIngredient${i}"] == '' || dataJson["strIngredient${i}"] == 'null' || 
      dataJson["strIngredient${i}"] == ' ' || dataJson["strIngredient${i}"] == null
    ) {
      continue;
    }
    else{
      widgetList.add(Row(
        children: [
          Text(
            '${dataJson["strMeasure${i}"]} ${dataJson["strIngredient${i}"]}',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ));
    }
  }
  return widgetList;
}
