class Saw {
 int xcor, ycor, damage, rad; 
 
 Saw(int x, int y, int damage, int rad) {
   xcor = x;
   ycor = y;
   this.damage = damage;
   this.rad = rad;
 }
 
 void draw() {
   fill(5, 180, 85);
   ellipse(xcor, ycor, rad * 2, rad * 2);
 }
 
 boolean insideSaw() {
   return (double)rad <= Math.sqrt((double)(Math.pow(mouseX - xcor, 2) + Math.pow(mouseY - ycor, 2)));
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