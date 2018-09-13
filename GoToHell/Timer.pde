class Timer {
 int start, end;
 
 Timer() {
  start = 0;
  end = 0;
 }
 
 void begin() {
  start = millis(); 
 }
 
 void end() {
  end = millis(); 
 }
 
 float result() {
   return (end - start) / 1000.0;
 }
}