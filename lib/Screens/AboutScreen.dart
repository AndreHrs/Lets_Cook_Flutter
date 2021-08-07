import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void _launchURL(String _url) async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'assets/images/cooking.png',
                            height: 175,
                            width: 175,
                          ),
                          SizedBox(
                            height: 13,
                          ),
                          Text(
                            "Let's Cook",
                            style: TextStyle(fontSize: 30),
                          ),
                          SizedBox(
                            height: 13,
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
                          "Powered by this amazing public API",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          "The Meal DB",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            _launchURL('https://www.themealdb.com/');
                          },
                          child: Text('Pay them a visit here!'))
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'App authored by',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Andre Harsono',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            'andreharsono27@gmail.com',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Image.asset('assets/images/instagram.png'),
                        iconSize: 50,
                        onPressed: () {
                          _launchURL('https://www.instagram.com/andre_hrs/');
                        },
                      ),
                      IconButton(
                        icon: Image.asset('assets/images/linkedin.png'),
                        iconSize: 50,
                        onPressed: () {
                          _launchURL(
                              'https://www.linkedin.com/in/andre-harsono-52a2421b9/');
                        },
                      ),
                      IconButton(
                        icon: Image.asset('assets/images/github.png'),
                        iconSize: 50,
                        onPressed: () {
                          _launchURL('https://github.com/AndreHrs');
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Credits to flaticon.com for graphical resources',
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Author of main icon : mangsaabguru",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                _launchURL(
                                    'https://www.flaticon.com/authors/mangsaabguru');
                              },
                              child: Text('Check out his resources here!')),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    ],
                  )
                ])),
      ),
    );
  }
}
