import 'package:snake_game/services/food.dart';

class Snake{
  List<dynamic> s;
  int len;

  void updatehead()
  {
    switch(s[0]['dir']){
      case 'L': s[0]['x']-=1;break;
      case 'R': s[0]['x']+=1;break;
      case 'U': s[0]['y']-=1;break;
      case 'D': s[0]['y']+=1;break;
    }

  }

  void setsnake(){
    s=[{'x':10,'y':13,'dir':'D'},{'x':10,'y':12,'dir':'D'},{'x':10,'y':11,'dir':'D'},
    {'x':10,'y':10,'dir':'D'},{'x':10,'y':9,'dir':'D'}];
    len=5;
  }

  void move(){
    Map temp1={'x':s[0]['x'],'y':s[0]['y'],'dir':s[0]['dir']};
    updatehead();
    for(int i=1;i<s.length;i++){
      dynamic temp2=s[i];
      s[i]=temp1;
      temp1=temp2;
     }
  }


  void leftmove(){
    if(s[0]['dir']!='R')
     s[0]['dir']='L';
  
  }

  void rightmove(){
    if(s[0]['dir']!='L')
        s[0]['dir']='R';

  }

  void upmove(){
    if(s[0]['dir']!='D')
        s[0]['dir']='U';
  }


void downmove(){
  if(s[0]['dir']!='U')
        s[0]['dir']='D';
}


bool iseaten(Food f){
  if(f.x==s[0]['x'] && f.y==s[0]['y'])
     return true;
  else 
     return false;

}

void snakeGrow(){
  switch(s[len-1]['dir']){
    case 'R': s.add({'x':s[len-1]['x']-1,'y':s[len-1]['y'],'dir':s[len-1]['dir']});
              len++;
              break;

    case 'L':s.add({'x':s[len-1]['x']+1,'y':s[len-1]['y'],'dir':s[len-1]['dir']});
              len++;
              break;

    case 'U':s.add({'x':s[len-1]['x'],'y':s[len-1]['y']+1,'dir':s[len-1]['dir']});
              len++;
              break;

    case 'D':s.add({'x':s[len-1]['x']-1,'y':s[len-1]['y']-1,'dir':s[len-1]['dir']});
              len++;
              break;
    

  }
}

bool eatItSelf(){
  Map head=s[0];
  for(int i=1;i<len;i++){
    if(head['x']==s[i]['x'] && head['y']==s[i]['y'])
       return true;
  }
  return false;
}


}