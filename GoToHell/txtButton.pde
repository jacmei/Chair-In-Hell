class txtButton {
 int x, y;
 String text;
 int size;
 color nColor;
 color overColor;
 boolean over;
 
 txtButton(int x, int y, String text, int size, color nc, color oc) {
   this.x = x;
   this.y = y;
   this.text = text;
   nColor = nc;
   overColor = oc;
   this.size = size;
 }
 
 void draw() {
   //colorMode(HSB);
   textAlign(LEFT, BOTTOM);
   textSize(size);
   over();
   if (over) {
     fill(overColor);
   }
   else {
     fill(nColor);
   }
   text(text, x, y);
 }
 
 void over() {
  if (mouseX >= x && mouseX <= x + textWidth(text) && mouseY <= y && mouseY >= y - size) {
   over = true; 
  }
  else {
   over = false; 
  }
 }
}