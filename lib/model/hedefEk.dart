import 'package:flutter/material.dart';
//import 'package:syncfusion_flutter_datepicker/datepicker.dart';
//import 'package:intl/intl.dart';

void main() {
  runApp(const HedefEkleme());
}

class HedefEkleme extends StatelessWidget {
  const HedefEkleme({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
      ),
      home: const HedefEklemeSayfa(title: 'Yeni Hedef Ekle'),
    );
  }
}

class HedefEklemeSayfa extends StatefulWidget {
  const HedefEklemeSayfa({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HedefEklemeSayfa> createState() => _HedefEklemeSayfaState();

}

class MultiSelect extends StatefulWidget {
  final List<String> items;
  const MultiSelect({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}
class _MultiSelectState extends State<MultiSelect> {
  // this variable holds the selected items
  final List<String> _selectedItems = [];

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Uygun Günleri Seç'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
            value: _selectedItems.contains(item),
            title: Text(item),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (isChecked) => _itemChange(item, isChecked!),
          ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: _cancel,
        ),
        ElevatedButton(
          child: const Text('Submit'),
          onPressed: _submit,
        ),
        ],
    );
  }
}

class _HedefEklemeSayfaState extends State<HedefEklemeSayfa> {
  List<String> _selectedItems = [];

  void _showMultiSelect() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> _items = [
      'Pazartesi',
      'Salı',
      'Çarşamba',
      'Perşembe',
      'Cuma',
      'Cumartesi',
      'Pazar'
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: _items);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
    }
  }

  //void _incrementCounter() {
    //print('incrementerCounter çalıştı');
    //setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      //_counter++;
    //});
  //}
  //String text=" ";




  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Yeni Hedef Ekle"),
        actions: [
          IconButton(
              icon: Icon(Icons.cancel_sharp),
          onPressed: () {
                print("Yeni hedef iptal edildi");// Girilen verilen silinmesini/kaydedilmemesini sağla
          },)
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            HedefBaslik(),
            HedefTanimi(),
            ElevatedButton(
              child: const Text('Bu hedefe ulaşmak için haftalık hangi günleri ayırabilirsin? (Opsiyonel)', textAlign: TextAlign.center,),
              onPressed: _showMultiSelect,
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20,),
                minimumSize: const Size(400 , 75),
              ),
            ),
            //const Divider(
              //height: 100,
            //),
            // display selected items

            Wrap(
              children: _selectedItems
                  .map((e) => Chip(
                label: Text(e),
              ))
                  .toList(),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(10.0),
              color: Colors.indigo.shade100,
              child: Text("Takvimde uygun olacağın günleri seçebilir veya bu işi bize bırakabilirsin",
                textAlign: TextAlign.left,
                textScaleFactor: 1.5,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(" Hedef Önizlemesi",
                textAlign: TextAlign.left,
                textScaleFactor: 2.0,
                style: TextStyle(
                    fontWeight: FontWeight.w700
                ),
              ),
            ),

            Container(
              child: Stack(
                children:<Widget>[

                  Container(
                    constraints: BoxConstraints.expand(
                      height: Theme.of(context).textTheme.headline4!.fontSize! * 1.1 + 100.0,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    alignment: Alignment.topLeft,
                    color: Colors.indigo.shade100,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.playlist_add_check_circle, size: 50,),
                  ),
                  Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("       Örnek Hedef Başlığı",
                        textAlign: TextAlign.left,
                        textScaleFactor: 2.0,
                      ),
                      Text("                ", textScaleFactor: 0.5,),
                      Text('          Örnek Hedef Tanımı', textAlign: TextAlign.left,textScaleFactor: 1.5,),
                      Text("                ", textScaleFactor: 1.5,),
                      Divider(),
                      Text("                Deadline _________", textScaleFactor: 1.0,),

                    ],
                  ),


                ]
              )
            ),
            //Text("Örnek Hedef Tanımı", textScaleFactor: 1.5,),




          ],
            //SfDateRangePicker(
              //onSelectionChanged: _onSelectionChanged,
              //selectionMode: DateRangePickerSelectionMode.range,
          //),
        ),
      ),




      //floatingActionButton: FloatingActionButton(
        //onPressed: _incrementCounter,
        //tooltip: 'Increment',
        //child: const Icon(Icons.add),
      //),


      //ElevatedButton(
       //   child: const Text('Takvimden uygun olacağınız günleri seçebilir veya bu işi bize bırakabilirsiniz.', textAlign: TextAlign.center,),
      //  onPressed: () async{},
     // ),
      bottomNavigationBar: BottomNavigationBar(
        // currentIndex: 0,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),label:"Anasayfa",),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),label: "Done"),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),label:"Profil",),
        ],
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class HedefBaslik extends StatefulWidget {
  const HedefBaslik({
    Key? key,
  }) : super(key: key);

  @override
  State<HedefBaslik> createState() => _HedefBaslikState();
}

class _HedefBaslikState extends State<HedefBaslik> {

  late TextEditingController controller;
  @override
  void initState(){
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.indigo.shade100,
        labelText: "Hedef Başlığı",
        labelStyle: TextStyle(color: Colors.indigo.shade500),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          icon: Icon(Icons.delete, color: Colors.indigo.shade500,),
          onPressed: (){
            controller.text="";
          },
        ),

        hintText: "Hedef Başlığı",
      ),
      onChanged: (value){
        print(value);
      },
    );
  }
}
class HedefTanimi extends StatefulWidget {
  const HedefTanimi({
    Key? key,
  }) : super(key: key);

  @override
  State<HedefTanimi> createState() => _HedefTanimi();
}

class _HedefTanimi extends State<HedefTanimi> {

  late TextEditingController controller;
  @override
  void initState(){
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.indigo.shade100,
        labelText: "Hedef Tanımı",
        labelStyle: TextStyle(color: Colors.indigo.shade500),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          icon: Icon(Icons.delete, color: Colors.indigo.shade500,),
          onPressed: (){
            controller.text="";
          },
        ),

        hintText: "Hedef Tanımı",
      ),
      onChanged: (value){
        print(value);
      },
    );
  }
}
