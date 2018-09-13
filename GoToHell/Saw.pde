class Saw {
 int xcor, ycor, damage, rad;
 PImage img = loadImage("saw.png");
 
 Saw(int x, int y, int damage, int rad) {
   xcor = x;
   ycor = y;
   this.damage = damage;
   this.rad = rad;
 }
 
 void draw() {
   //fill(5, 180, 85);
   //ellipse(xcor, ycor, rad * 2, rad * 2);
   image(img,xcor-rad, ycor-rad, rad * 2, rad * 2);
 }
 
 boolean insideSaw(float x, float y) {
   return (double)rad - 3 >= Math.sqrt((double)(Math.pow(x - xcor, 2) + Math.pow(y - ycor, 2))) ||
   (double)rad - 3 >= Math.sqrt((double)(Math.pow(x + 20 - xcor, 2) + Math.pow(y - ycor, 2))) ||
   (double)rad - 3 >= Math.sqrt((double)(Math.pow(x - xcor, 2) + Math.pow(y + 30 - ycor, 2))) ||
   (double)rad - 3 >= Math.sqrt((double)(Math.pow(x + 20 - xcor, 2) + Math.pow(y + 30 - ycor, 2)));
 }
 
 void grow() {
   rad += 1; 
 }
 
 void shrink() {
   if(rad > 5) {
     rad -= 1;
   }
 }
}