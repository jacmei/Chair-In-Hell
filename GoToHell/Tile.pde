class Tile {
 int xcor, ycor, breakStart;
 int type; // 0 = air; 1 = platform; 2 = wall; 3 = breakable; 4 = damage;
 boolean over, contact, countStart, hasBroken;
 color col;

 Tile(int x, int y, int type) {
   xcor = x;
   ycor = y;
   contact = false;
   countStart = false;
   hasBroken = false;
   this.type = type;
 }
 
 void draw() {
   if (type == 0) {
     col = color(150, 60, 120, 0);
   }
   else if (type == 1) {
     col = color(200, 120, 40);
   }
   else if (type == 2) {
     col = color(200, 120, 50);
   }
   else if (type == 3) {
     col = color(25, 120, 85);
     if (contact && !countStart) {
       breakStart = millis();
       countStart = true;
       hasBroken = true;
     }
     if (contact && countStart) {
       if ((millis() - breakStart) / 1000.0 >= 2) {
         type = 0;
         countStart = false;
       }
     }
   }
   else if (type == 4) {
     col = color(5, 180, 85);
   }
   /*if (getTile(mainChar.xcor + 5, mainChar.ycor + 30) == this ||    //DOWN
       getTile(mainChar.xcor + 15, mainChar.ycor + 30) == this ||    
       getTile(mainChar.xcor - 5, mainChar.ycor + 5) == this ||   //LEFT
       getTile(mainChar.xcor - 5, mainChar.ycor + 25) == this ||  
       getTile(mainChar.xcor + 25, mainChar.ycor + 5) == this ||  //RIGHT
       getTile(mainChar.xcor + 25, mainChar.ycor + 25) == this ||
       getTile(mainChar.xcor + 5, mainChar.ycor - 5) == this ||  //UP
       getTile(mainChar.xcor + 15, mainChar.ycor - 5) == this) {
   col = color(255);
   //println(type);
   }*/
   fill(col);
   noStroke();
   rect(xcor * tileSize, ycor * tileSize, tileSize, tileSize);
   //stroke(0, 255, 200);
   //point((xcor + 1) * tileSize, (ycor + 1) * tileSize);
 }
 
 String toString() {
  return "(" + xcor + "," + ycor+ ")" + " " + type; 
 }
}
 