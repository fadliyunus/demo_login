import 'package:flutter/material.dart';

class HalamanUtama extends StatelessWidget {
  final String idUser,firstname,lastname,username;
  HalamanUtama({Key key,this.idUser,this.firstname,this.lastname,this.username}): super(key:key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(height: 10),


          Container(
            padding: EdgeInsets.all(10.0),
            child: Text("idUser  : " + idUser,
              style: TextStyle(
                fontSize: 12.0,fontWeight: FontWeight.bold
              ),
            ),
          ),
           Container(
            padding: EdgeInsets.all(10.0),
            child: Text("firstname  : " + firstname,
              style: TextStyle(
                fontSize: 12.0,fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text("lastname  : " + lastname,
              style: TextStyle(
                fontSize: 12.0,fontWeight: FontWeight.bold
              ),
            ),
          ),
           Container(
            padding: EdgeInsets.all(10.0),
            child: Text("username  : " + username,
              style: TextStyle(
                fontSize: 12.0,fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ),
    );
  }
}