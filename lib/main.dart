import 'package:flutter/material.dart';
import 'dart:async';
import 'package:snake_game/services/snake.dart';
//import 'package:swipedetector/swipedetector.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:snake_game/services/food.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));

}

int row=45,col=25;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<List<int>> grid=List<List<int>>.generate(row, (i) =>List<int>.generate(col, (j) => 0));
  Snake sn=new Snake();
  Food food=Food();
  String status='Tap to start';
  int score=0;
  bool isGameOver=false;
  String diffLevel='medium';
  int delay=350;

  @override
  void initState(){
    super.initState();
    food.genrateFood();
    sn.setsnake();
    update();
   
  }

  void update(){
     for(int i=0;i<row;i++)
        for(int j=0;j<col;j++)
        {
            if(i==0 || j==0 || i==row-1 || j==col-1)
                grid[i][j]=3;
            else
              grid[i][j]=0;

        }
  
    for(int i=0;i<sn.s.length;i++)
       grid[sn.s[i]['y']][sn.s[i]['x']]=1;
    
    grid[food.y][food.x]=2;
    
  }

  bool isGameover(){
    if(sn.s[0]['x']>col-2 || sn.s[0]['x']<=0 || sn.s[0]['y']>row-2 || sn.s[0]['y']<=0)
       return true;
    if(sn.eatItSelf())
      return true;
    return false;

  }
  
  void start(){
    if(status=='Tap to start' || status=='Game Over'){
      status='Game is running';
      sn.setsnake();
      food.genrateFood();
      score=0;
      isGameOver=false;
    Timer.periodic(Duration(milliseconds: delay ), (timer) { 
      sn.move();
      setState(() {
        update();
      });
       
      if(sn.iseaten(food)){
        sn.snakeGrow();
        food.genrateFood();
        score+=5;
      }

      if(isGameover()){
        setState(() {
          status='Game Over';
          isGameOver=true;
          update();
        });
        timer.cancel();
      }
       
    });
    }

  }

  void _onVerticalSwipe(SwipeDirection dir){
    if(dir==SwipeDirection.up)
      setState(() {
        sn.upmove();
        update();
      });
       

    if(dir==SwipeDirection.down)
       setState(() {
        sn.downmove();
        update();
      });


  }
  void _onHorizontalSwipe(SwipeDirection dir){
    if(dir==SwipeDirection.left)
        setState(() {
        sn.leftmove();
        update();
      });

    if(dir==SwipeDirection.right)
       setState(() {
        sn.rightmove();
        update();
      });
    

  }


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.brown[200],
      appBar: AppBar(
        backgroundColor: Colors.green,
       // title: Text('Score: '+score.toString()),
        title: DropdownButton<String>(
          value: diffLevel,
    
          icon: Icon(Icons.arrow_downward),
          items:  <String>['easy','medium','hard'].map<DropdownMenuItem<String>>((String value) {
                           return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                               );
                        }).toList(),

         onChanged: (String newval){
             if(newval=='easy') delay=400;
             else if(newval=='medium') delay=350;
             else if(newval=='hard')   delay=100;
             setState((){diffLevel=newval;});
         }
         ),
    
        
      ),
      
      body:SimpleGestureDetector(  
        child:!isGameOver?Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: grid.map((e) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: e.map((f) => Container(height: 10, width: 10,color: f==0?Colors.white:f==1?Colors.brown:f==3?Colors.green[900]:Colors.green[600], )).toList(),
          )).toList(),
      ):Center(child: Container(
        height:200,
        width: 500,
        child: Column(
              children: [
                Text(status,
                    style: TextStyle(
                     fontSize: 40,
                     )
                 ),
                 Text('Score:'+score.toString(),
                    style: TextStyle(
                     fontSize: 30,
                     )
                 ),
                 SizedBox(height: 50,),
                 Text("Tap here",
                    style: TextStyle(
                     fontSize: 20,
                     )
                 ),

         ]
        )
      ),
      ),
      onVerticalSwipe: _onVerticalSwipe ,
      onHorizontalSwipe: _onHorizontalSwipe ,
      onTap: start,

     
    ) ,
      
    );
  }
}

