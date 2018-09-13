class Door {
 boolean exit;
 int xcor, ycor;
 
 Door(int x, int y, boolean ex) {
   xcor = x;
   ycor = y;
   exit = ex;
 }
 
 void draw() {
   if (exit) {
     fill(21, 51, 220);
   }
   else{
     fill(21, 20, 150);
   }
   rect(xcor, ycor, 30, 40);
 }
}