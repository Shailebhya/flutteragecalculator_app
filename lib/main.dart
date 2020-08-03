import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.brown,
    ),
    home:HomePage()
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  double age =0.0;
  var selectedYear;
  Animation animation;
  AnimationController animationController;
  @override
void initState() {
    // TODO: implement initState
    animationController=AnimationController(
      vsync: this,duration: Duration(
      milliseconds: 1500
    )
    );
    animation=animationController;
    super.initState();
  }
  @override
  void dispose(){
    animationController.dispose();
    super.dispose();
  }

  void _showPicker(){
    void calculateAge(){
      setState(() {
        age =( 2020 - selectedYear).toDouble();
        animation=Tween<double>(
          begin: animation.value,end: age
        ).animate(CurvedAnimation(curve: Curves.fastOutSlowIn,
        parent: animationController));
        animation.addListener(() {
          setState(() {
          });
        });
      });

      animationController.forward();
    }
    showDatePicker(context: context, 
        initialDate: DateTime(2020),
        firstDate: DateTime(1900),
        lastDate: DateTime.now()).then((DateTime dt){
          setState(() {
            selectedYear=dt.year;
            calculateAge();
          });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Age Calci"),
      ),
      body: Center(
        child: Column(
          children: [
            OutlineButton(
              child: Text(selectedYear!= null ? selectedYear.toString():"Select your Year Of Birth"),
              borderSide: BorderSide(
                color: Colors.black,
                width: 3
              ),
              color: Colors.black,
              onPressed:_showPicker,
            ),
            Padding(
              padding: EdgeInsets.all(20),
            ),
            Text("Your age is ${animation.value.toStringAsFixed(0)}",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic
            ),)
          ],
        ),
      ),
    );
  }
}
