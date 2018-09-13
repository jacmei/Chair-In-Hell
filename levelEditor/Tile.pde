class Tile {
 int xcor, ycor;
 int type; //0 = air; 1 = platform; 2 = wall; 3 = breakable; 4 = damage;
 boolean over, contact;
 color col;

 Tile(int x, int y, int type) {
   xcor = x;
   ycor = y;
   contact = false;
   this.type = type;
 }
 
 void draw() {
   over();
   if (!over) {
     if (type == 0) {
       col = color(150, 60, 120);
     }
     else if (type == 1) {
       col = color(340, 20, 20);
     }
     else if (type == 2) {
       col = color(340, 20, 50);
     }
     else if (type == 3) {
       col = color(25, 120, 85);
     }
     else if (type == 4) {
       col = color(5, 180, 85);
     }
   }
   else {
     hovered = this;
     if (type == 0) {
       col = color(150, 60, 180);
     }
     else if (type == 1||type == 2) {
       col = color(340, 20, 80);
     }
     else if (type == 3) {
       col = color(25, 120, 145);
     }
     else if (type == 4) {
       col = color(5, 180, 145);
     }
   }
   fill(col);
   noStroke();
   rect(xcor * tileSize, ycor * tileSize, tileSize, tileSize);
   //stroke(0, 255, 200);
   //point((xcor + 1) * tileSize, (ycor + 1) * tileSize);
 }
 
 void over() {
  if (mouseX >= xcor * tileSize && mouseX < (xcor + 1) * tileSize
  && mouseY >= ycor * tileSize + 4 && mouseY < (ycor + 1) * tileSize + 4) {
   over = true;
  }
  else {
   over = false; 
  }
 }
}