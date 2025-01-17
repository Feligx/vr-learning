import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pawrent/home/posts/Post_fund.dart';
import 'package:pawrent/home/profile/userprofile.dart';
import 'package:pawrent/adopt/adopt.dart';
import 'package:pawrent/home/veterinaries/vet_detailed.dart';
import 'package:pawrent/settings/settings.dart';
import 'package:pawrent/home/foundations/foundations_detailed.dart';

import '../reports/reportes.dart';

class Home1 extends StatefulWidget {
  const Home1({Key? key}) : super(key: key);

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  static const List<Widget> _widgetOptions = <Widget>[
    pagvet(),
    pagadopt(),
    paghome(),
    pagfun(),
    settingList(),
  ];

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    bool isDark = queryData.platformBrightness == Brightness.dark;
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid, provider, photoUrl="", displayName = "";

    void getCurrentUserInfo() async {
      debugPrint(auth.currentUser?.uid);
      uid=auth.currentUser!.uid;
      provider=auth.currentUser!.providerData[0].providerId.toString();

      if(provider == "password"){
        photoUrl = auth.currentUser?.photoURL?.toString()??"https://www.nintenderos.com/wp-content/uploads/2022/03/kirby-y-la-tierra-olvidada...png1-Cropped.png";
        displayName = (auth.currentUser?.displayName)??"Kirby";
      }else{
        photoUrl=auth.currentUser!.photoURL!;
        displayName=auth.currentUser!.displayName!;
      }
    }

    getCurrentUserInfo();
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        leadingWidth: 80,
//        titleTextStyle: TextStyle(
//            fontWeight: FontWeight.bold, fontSize: 18),
        title: Text(displayName),
        leading: IconButton(
          icon: CircleAvatar(
            backgroundImage: NetworkImage(
                //"https://avatars.githubusercontent.com/u/34454204?v=4"
                photoUrl,
            ),
            radius: 30.0,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserProfile()),
            );
          },
        ),
        toolbarHeight: 70,
        actions: [
          Container(
              margin: EdgeInsets.only(right: 10.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => reportsForm()),
                    );
                  },
                  icon: Icon(
                    Icons.report_problem_outlined,
                    //color: Colors.indigo,
                    size: 30,
                  )))
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital_outlined,),
            label: 'Veterinaria',
            backgroundColor: (isDark)?Colors.black : null,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Adoptar',
            backgroundColor: (isDark)?Colors.black : null,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: (isDark)?Colors.black : null,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.volunteer_activism_outlined),
            label: 'Fundaciones',
            backgroundColor: (isDark)?Colors.black : null,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
            backgroundColor: (isDark)?Colors.black : null,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class paghome extends StatelessWidget {
  const paghome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.grey[200],
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Últimos reportes",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {

                  },
                  child: Text(
                    "Ver todos",
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              ],
            )
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width:50,
                  height:50,
                  child: Icon(Icons.location_pin, size: 25, color: Color(0xFFEB5050)),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF2DBDB)),
                ),
                Column(
                  children:[
                    Text("Mascota reportada Bogotá"),
                    Text("Sep 18, 2020"),
                  ]
                ),
                Text("Hace 1h", style: TextStyle(color: Color(0xFFEB5050)),),
              ],
            )
          ),
          const Divider(
            height: 20,
            indent: 20,
            endIndent: 20,
          ),
          Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width:50,
                    height:50,
                    child: Icon(Icons.location_pin, size: 25, color: Color(0xFF29AB67)),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFCFEDDD)),
                  ),
                  Column(
                      children:[
                        Text("Mascota perdida - Bogotá"),
                        Text("Sep 15, 2021"),
                      ]
                  ),
                  Text("Hace 3h", style: TextStyle(color: Color(0xFF29AB67)),),
                ],
              )
          ),
          const Divider(
            height: 20,
            indent: 20,
            endIndent: 20,
          ),
          Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width:50,
                    height:50,
                    child: Icon(Icons.location_pin, size: 25, color: Color(0xFF405AE1)),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFD8DCF0)),
                  ),
                  Column(
                      children:[
                        Text("Mascota encontrada Bogotá"),
                        Text("Sep 12, 2022"),
                      ]
                  ),
                  Text("Hace 2d", style: TextStyle(color: Color(0xFF405AE1)),),
                ],
              )
          ),
          const Divider(
            height: 20,
            indent: 20,
            endIndent: 20,
          ),

          Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 40),
            padding: EdgeInsets.all(10.0),
            child: InkWell(
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      //margin: EdgeInsets.only(right: 100.0),
                      child: Column(
                        children: [Text("Novedades", style: TextStyle(color: Colors.black))],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: Image(
                            image: NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/pawpaw-9d57b.appspot.com/o/profile_assets%2Fpets%2Fcat1.jpg?alt=media&token=13e2e16a-6487-4859-ad18-5ee429ed5f7a",
                                scale: 2.5)))
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => pagnov()),);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class pagfun extends StatefulWidget {
  const pagfun({Key? key}) : super(key: key);

  @override
  State<pagfun> createState() => _pagfunState();
}

class _pagfunState extends State<pagfun> {

  bool _queried = false;
  List<Widget> foundations = [];

  Future getData() async {
    if (!_queried) {
      foundations= [];
      var firestore = FirebaseFirestore.instance;
      await firestore.collection("foundations").get().then((value){
        value.docs.forEach((element) {
          print(element.id);
          foundations.add(
            InkWell(
              child: Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                padding: EdgeInsets.all(10.0),
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width:100,
                        //margin: EdgeInsets.only(right: 100.0),
                        child: Column(
                          children: [Text(element.data()["name"], overflow: TextOverflow.fade,)],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                          child: Image(
                              image: NetworkImage(
                                  element.data()["pfp"],
                                  scale: 2.5)))
                    ],
                  ),
                ),
              ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => foundDetailed(id: element.id,)));
                }
            ),
          );
        });
        setState(() {
          _queried = true;
        });
      });
    }
    print(foundations);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    bool isDark = queryData.platformBrightness == Brightness.dark;
    if(!_queried)getData();
    debugPrint(_queried.toString());
    return Container(
      //color: Colors.grey[200],
      child: Column(children:[
        Container(
          margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Buscar',
            //icon: Icon(Icons.search),
            suffixIcon: Icon(Icons.search, color: (isDark) ? Colors.white : Colors.black,),
          ),
        )),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 10.0, left: 20.0),
          child: Text("Fundaciones en Bogotá", style: TextStyle(fontSize: 15.0),),
        ),
        const Divider(
          height: 20,
          indent: 20,
          endIndent: 20,
          color: Colors.black,
        ),
        Expanded(
          child: ListView(
            children: foundations.isEmpty?[Container(child: Center(child: CircularProgressIndicator()))]:foundations,
      ),
        )]
      )
    );
  }
}

class loadingCircle extends StatefulWidget {
  const loadingCircle({Key? key}) : super(key: key);

  @override
  State<loadingCircle> createState() => _loadingCircleState();
}

class _loadingCircleState extends State<loadingCircle> {

  bool _isLoading = true;

  final loader = Container(
      child: Center(
        child: CircularProgressIndicator(),
      ));
  final empty = Container(
      child: Center(
        child: Text("No hay nada"),
      ));

  Future loadingWaiter() async{
    await Future.delayed(Duration(seconds: 5));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    loadingWaiter();
    return _isLoading?loader:empty;
  }
}


class pagvet extends StatefulWidget {
  const pagvet({Key? key}) : super(key: key);

  @override
  State<pagvet> createState() => _pagvetState();
}

class _pagvetState extends State<pagvet> {

  var Data = [];
  var _isQueried = false;

  Future getVets() async {
    print("Querying...");
    Data = [];
    FirebaseFirestore.instance
        .collection('vets')
        .get().then((value) =>
    {
      setState((){
        value.docs.forEach((doc) {
          print(doc.data());
          Data.add(doc.data());
        });
        print("Data");
        print(Data);
      })
    });
    _isQueried=true;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    bool isDark = queryData.platformBrightness == Brightness.dark;

    if(!_isQueried)getVets();
    return Container(
        //color: Colors.grey[200],
        child: Column(children:[
          Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Buscar',
                  //icon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.search, color:(isDark)?Colors.white:Colors.black),
                ),
              )),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10.0, left: 20.0),
            child: Text("Veterinarios en Bogotá", style: TextStyle(fontSize: 15.0),),
          ),
          const Divider(
            height: 20,
            indent: 20,
            endIndent: 20,
            color: Colors.black,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: Data.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
//                padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: CircleAvatar(
                                radius: 50.0,
                                backgroundImage: NetworkImage(
                                    Data[index]['pfp']))),
                        Container(
                          width: 150,
                          child: Column(
                            children: [Text(Data[index]['name'], textAlign: TextAlign.center,), Text(Data[index]['tel'].toString())],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.chevron_right_outlined),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => vetProfile(name: Data[index]['name'],address: Data[index]['address'], pfp: Data[index]['pfp'], tel: Data[index]['tel'],)));
                            print("hola");
                          },
                        )
                      ],
                    ),
                  );
                }
            )
          )]
        )
    );
  }
}
