static int state, tileSize; //  0 = Main Menu; 1 = Play / Stage Select; 2 = Stat Record; 3 = Pause;
                            // 11 - 20 = stages 1 - 10
PFont font;
int fontsize = 20, beforePause, unlockedStage;
txtButton[] butts0 = new txtButton[3];
txtButton[] butts1 = new txtButton[11];
txtButton[] butts3 = new txtButton[3];
Tile[] board;
BufferedReader reader, reader2;
PrintWriter out;
Character mainChar;
char currentKey;
color buttonNormal, buttonHover;
PImage mainmenu, stagebg;
Saw[] sawlist;
Door[] doorlist = new Door[2];
Timer timer;
float[] records = new float[10];

void setup() {
  reader = createReader("save.txt");
  reader2 = createReader("records.txt");
  load();
  size(640, 480);
  tileSize = width / 64;
  colorMode(HSB);
  state = 0;
  buttonNormal = color(240, 127, 190);
  buttonHover = color(248, 163, 230);
  background(190, 80, 40);
  noStroke();
  mainmenu = loadImage("mainmenu.png");
  font = createFont("Impact", 16, true);
  butts0[0] = new txtButton(width / 5, height / 3 + 10 * height / 48, "Play", fontsize, buttonNormal, buttonHover);
  butts0[1] = new txtButton(width / 5, height / 3 + 15 * height / 48, "Records", fontsize, buttonNormal, buttonHover);
  butts0[2] = new txtButton(width / 5, height / 3 + 20 * height / 48, "Exit", fontsize, buttonNormal, buttonHover);
  butts1[0] = new txtButton(width / 10, height - height / 10, "Back", fontsize, buttonNormal, buttonHover);
  for (int i = 1; i < butts1.length; i ++) {
    if (i < 10 && i != 5) {
      if (i > unlockedStage) {
        butts1[i] = new txtButton(i % 5 * width / 6, ((i / 6) + 1) * height * 4 / 11, "0" + i, fontsize, color(170), color(170));
      }else{
        butts1[i] = new txtButton(i % 5 * width / 6, ((i / 6) + 1) * height * 4 / 11, "0" + i, fontsize, buttonNormal, buttonHover);
      }
    } 
    else if (i == 5) {
      if (i > unlockedStage) {
        butts1[i] = new txtButton(5 * width / 6, ((i / 6) + 1) * height * 4 / 11, "0" + i, fontsize, color(170), color(170));
      }else{
        butts1[i] = new txtButton(5 * width / 6, ((i / 6) + 1) * height * 4 / 11, "0" + i, fontsize, buttonNormal, buttonHover);
      }
    } 
    else {
      if (i > unlockedStage) {
        butts1[i] = new txtButton(5 * width / 6, ((i / 6) + 1) * height * 4 / 11, "" + i, fontsize, color(170), color(170));
      }else {
        butts1[i] = new txtButton(5 * width / 6, ((i / 6) + 1) * height * 4 / 11, "" + i, fontsize, buttonNormal, buttonHover);
      }
    }
  }
  butts3[0] = new txtButton(width / 5 + 40, 330, "Resume", fontsize, buttonNormal, buttonHover);
  butts3[1] = new txtButton(width/ 5 + 170, 330, "Back", fontsize, buttonNormal, buttonHover);
  butts3[2] = new txtButton(width/ 5 + 270, 330, "Exit", fontsize, buttonNormal, buttonHover);
  board = new Tile[64 * 48];
  timer = new Timer();
}

void draw() {
  textAlign(LEFT, BOTTOM);
  if (state == 0) {
    background(mainmenu);
    fill(buttonHover);
    textFont(font, 48);
    text("GO TO HELL", width / 5, height / 3);
    butts0[0].draw();
    butts0[1].draw();
    butts0[2].draw();
  } 
  else if (state == 1) {
    background(190, 80, 40);
    fill(buttonHover);
    textFont(font, 36);
    textAlign(CENTER, BOTTOM);
    text("Stage Select", width / 2, height / 5);
    for (int i = 0; i < butts1.length; i ++) {
      butts1[i].draw();
    }
    fill(255);
    line(width / 10, height - height / 10, 0, 0);
  } 
  else if (state == 2) {
    background(190, 80, 40);
    fill(buttonHover);
    textFont(font, 36);
    textAlign(CENTER, BOTTOM);
    text("Records", width / 2, height / 5);
    for (int i = 0; i < 10; i++) {
      fill(buttonNormal);
      textFont(font, 18);
      text("Stage" + ( i + 1) + ":", width / 3, height * (i + 1) / 17 + 110);
      fill(200);
      text(records[i] + " sec", width * 2 / 3 - 20, height * (i + 1) / 17 + 110);
    }
    butts1[0].draw();
  }
  else if (state == 3) {
    fill(255);
    textSize(100);
    text("PAUSE", 120, 290);
    butts3[0].draw();
    butts3[1].draw();
    butts3[2].draw();
  }
  else if (state > 10 && state < 21) {
    background(190, 80, 40);
    for (int x = 0; x < 10; x ++) {
      if (state == 11 + x) {
        timer.end();
        stagebg = loadImage("stagebg" + (x + 1) + ".png");
        background(stagebg);
        for (int i = 0; i < board.length; i ++) {
          board[i].draw();
        }
        for (int i = 0; i < doorlist.length; i ++) {
          doorlist[i].draw();
          if (i == 1 && doorlist[i].insideDoor((int)mainChar.xcor, (int)mainChar.ycor)) {
            updateRecords(timer.result());
            setStage(state - 10 + 1);
          }
        }
        mainChar.draw();
        for (int i = 0; i < sawlist.length; i ++) {
          sawlist[i].draw();
        }
        textSize(15);
        fill(255);
        text("" + timer.result(), 25, 35);
      }
    }
  }
}

void keyReleased() {
  if (keyCode == RIGHT) {
    mainChar.xacceleration = -0.2;
    mainChar.xrightSlowDown = true;
    mainChar.movingRight = false;
    mainChar.keyPriorityRight = false;
  }
  if (keyCode == LEFT) {
    mainChar.xacceleration = 0.2;
    mainChar.xleftSlowDown = true;
    mainChar.movingLeft = false;
    mainChar.keyPriorityLeft = false;
  }
  if (keyCode == UP) {
    mainChar.hasJumped = false;
  }
  if (key == ' ') {
    mainChar.sprint = false;
  }
}

void keyPressed() {
  if (key == 27 && state < 21 && state > 10) {
    key = 0;
    beforePause = state;
    state = 3;
  }
  else if (key == 27 && state == 3) {
    key = 0;
    state = beforePause;
  }
  else if (key == 27) {
    key = 0;
  }
}
 
void mousePressed() {
  if (state == 0) {
    if (butts0[0].over == true) {
      state = 1;
      println("Clicked Play");
    } 
    else if (butts0[1].over == true) {
      state = 2;
      println("Clicked Records");
    } 
    else if (butts0[2].over == true) {
      exit();
    }
  }
  else if (state == 1) {
    if (butts1[0].over == true) {
      state = 0; 
    } 
    else {
      for (int n = 1; n < butts1.length; n ++) {
        if (unlockedStage >= n && butts1[n].over == true) {
          setStage(n);
        }
      }
    }
  }
  else if (state == 2) {
    if (butts1[0].over == true) {
      state = 0; 
    } 
  }
  else if (state == 3) {
    if (butts3[0].over == true) {
      state = beforePause;
    }
    else if (butts3[1].over == true) {
      state = 1;
    }
    else if (butts3[2].over == true) {
      exit();
    }
  }
}

// takes pixel coordinates and returns the Tile on those coordinates
Tile getTile(float x, float y) {
  int xcor = (int)x / 10;
  int ycor = (int)y / 10;
  return board[xcor + ycor * 64];
}

void setStage(int n) {
  state = 10 + n;
  if (state != 21) {
    if (unlockedStage < n) {
      unlockedStage = n;
      out = createWriter("save.txt");
      out.print(n + "");
      out.flush(); 
      out.close();
      butts1[n].nColor = buttonNormal;
      butts1[n].overColor = buttonHover;
      //println("New save"); 
    }
    println("Stage " + n);
    String[] lines = loadStrings("stage" + n + ".txt");
    String[] tileInfo;
    for (int i = 0; i < board.length; i ++) {
      tileInfo = lines[i].split(",");
      board[i] = new Tile(Integer.parseInt(tileInfo[0]), Integer.parseInt(tileInfo[1]), Integer.parseInt(tileInfo[2]));
    }
    String[] door = lines[board.length + 1].split(",");
    doorlist[0] = new Door(Integer.parseInt(door[0]), Integer.parseInt(door[1]), false);
    door = lines[board.length + 2].split(",");
    doorlist[1] = new Door(Integer.parseInt(door[0]), Integer.parseInt(door[1]), true);
    sawlist = new Saw[lines.length - (board.length + 4)];
    String[] saw;
    for (int i = 0; i < sawlist.length; i ++) {
      saw = lines[board.length + 4 + i].split(",");
      sawlist[i] = new Saw(Integer.parseInt(saw[0]), Integer.parseInt(saw[1]), Integer.parseInt(saw[2]), Integer.parseInt(saw[3]));
    }
    mainChar = new Character(0, 0, 0, 0, doorlist[0].xcor + 5, doorlist[0].ycor + 10);
    timer.begin();
  }
  else if (state == 21) {
    state = 1;
  }
}

void load() {
  try {
    String line = reader.readLine();
    if (!line.isEmpty()) {
      unlockedStage = Integer.parseInt(line);
    }
    String[] lines = loadStrings("records.txt");
    for (int i = 0; i < 10; i ++) {
      records[i] = Float.parseFloat(lines[i]);
    }
  }
  catch(IOException e) {
    e.printStackTrace();
  }
}

void updateRecords(float n) {
  if (n < records[state - 11] || records[state - 11] == 0.0) {
    records[state - 11] = n;
    out = createWriter("records.txt");
    for (int i = 0; i < 10; i ++) {
      out.println(records[i] + "");
    }
    out.flush(); 
    out.close(); 
  }
}