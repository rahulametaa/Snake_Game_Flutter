import 'dart:math';

int row=45,col=25;

class Food{
 int x,y;

 void genrateFood(){
   var rnd=Random();
   x=rnd.nextInt(col-1);
   y=rnd.nextInt(row-1);
   if(x==0)
     x=1;
   if(y==0)
    y=1;
 }

}