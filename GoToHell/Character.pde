class Character {
  float xvelocity, xacceleration, yvelocity, yacceleration, xcor, ycor, gravity, speedlimit, newSpeedLimit;
  boolean xleftSlowDown, xrightSlowDown, xstartUp, yslowDown, isFalling, hasJumped, movingLeft, movingRight, keyPriorityLeft, keyPriorityRight, wallClimbL, wallClimbR, sprint;
  //PShape square;
  PImage sprite = loadImage("charspriteR.png");

  Character(float xvelocity, float xacceleration, float yvelocity, float yacceleration, float xcor, float ycor) {
    this.xvelocity = xvelocity;
    this.xacceleration = xacceleration;
    this.yvelocity = yvelocity;
    this.yacceleration = yacceleration;
    this.xcor = xcor;
    this.ycor = ycor;
    xleftSlowDown = false;
    xrightSlowDown = false;
    xstartUp = false;
    isFalling = false;
    hasJumped = false;
    speedlimit = 3.0;
    newSpeedLimit = 4.0;
    movingLeft = false;
    movingRight = false;
    wallClimbL = false;
    wallClimbR = false;
    keyPriorityLeft = false;
    keyPriorityRight = false;
    sprint = false;
    //square = createShape(RECT, 0, 0, 10, 10);
    //square.setFill(color(0, 100, 75));
    //square.setStroke(false);
  }

  void draw() {
    //shape(square, xcor, ycor);
    //rect(xcor, ycor, 10, 15);
    image(sprite, xcor, ycor);
    xvelocity += xacceleration;
    yvelocity += yacceleration;
    xcor += xvelocity;
    ycor += yvelocity;
    if (xrightSlowDown == true) {
      if (xvelocity <= 0) {
        xvelocity = 0;
        xacceleration = 0;
        xrightSlowDown = false;
      }
    }
    if (xleftSlowDown == true) {
      if (xvelocity >= 0) {
        xvelocity = 0;
        xacceleration = 0;
        xleftSlowDown = false;
      }
    }
    if (yslowDown == true) {
      if (yvelocity >= 0) {
        yslowDown = false;
      }
    }
    if (keyPressed) {
      if (keyCode == LEFT) {
        sprite = loadImage("charspriteL.png");
      }
      if (!intoWallL()) {
        if (keyCode == LEFT) {
          //println("MOVING LEFT");
          movingLeft = true;
          keyPriorityLeft = true;
          keyPriorityRight = false;
          if (wallClimbR) {
            wallClimbR = false;
          }
        }
      }
      if (keyCode == RIGHT) {
        sprite = loadImage("charspriteR.png");
      }
      if (!intoWallR()) {
        if (keyCode == RIGHT) {
          //println("MOVING RIGHT");
          movingRight = true;
          keyPriorityLeft = false;
          keyPriorityRight = true;
          if (wallClimbL) {
            wallClimbL = false;
          }
        }
      }
      if (!intoCeiling()) {
        if (keyCode == UP) {
          if (!hasJumped) {
            if (isFalling == false) {
              yvelocity = -speedlimit - 1;
              yacceleration = 0.15;
              yslowDown = true;
              isFalling = true;
            }
            else if (wallClimbL || wallClimbR) {
              yvelocity = -speedlimit - 1;
              yacceleration = 0.15;
              yslowDown = true;
              isFalling = true;
            } 
          }
          hasJumped = true;
        }
      }
      if (key == ' ') {
        sprint = true;
      }
    }
    if (movingLeft && keyPriorityLeft) {
      if (yvelocity == 0 && yacceleration == 0) {
        if (sprint == true) {
          if (xvelocity >= -newSpeedLimit) {
            xacceleration = -0.3;
            xstartUp = true;
          }
          else if (xvelocity < -newSpeedLimit) {
            if (xstartUp == true) {
              xacceleration = 0;
              xstartUp = false;
            }
          }
        }
        else {
          if (xvelocity >= -speedlimit) {
            xacceleration = -0.2;
            xstartUp = true;
          }
          else if (xvelocity < -speedlimit) {
            if (xstartUp == true) {
              xacceleration = 0;
              xstartUp = false;
            }
          }
        }
      }
      else {
        if (wallClimbR) {
          wallClimbR = false;
        }
        if (sprint == true) {
          if (xvelocity >= -newSpeedLimit) {
            xacceleration = -0.20;
            xstartUp = true;
          } 
          else if (xvelocity < -newSpeedLimit) {
            if (xstartUp == true) {
              xacceleration = 0;
              xstartUp = false;
            }
          }
        }
        else {  
          if (xvelocity >= -speedlimit) {
            xacceleration = -0.15;
            xstartUp = true;
          } 
          else if (xvelocity < -speedlimit) {
            if (xstartUp == true) {
              xacceleration = 0;
              xstartUp = false;
            }
          }
        }
      }
    }
    if (movingRight && keyPriorityRight) {
      if (yvelocity == 0 && yacceleration == 0) {
        if (sprint == true) {
          if (xvelocity <= newSpeedLimit) {
            xacceleration = 0.3;
            xstartUp = true;
          }
          else if (xvelocity > newSpeedLimit) {
            if (xstartUp == true) {
              xacceleration = 0;
              xstartUp = false;
            }
          }
        }
        else {
          if (xvelocity <= speedlimit) {
            xacceleration = 0.2;
            xstartUp = true;
          }
          else if (xvelocity > speedlimit) {
            if (xstartUp == true) {
              xacceleration = 0;
              xstartUp = false;
            }
          }
        }
      }
      else {
        if (wallClimbL) {
          wallClimbR = false;
        }
        if (sprint == true) {
          if (xvelocity <= newSpeedLimit) {
            xacceleration = 0.20;
            xstartUp = true;
          } 
          else if (xvelocity > newSpeedLimit) {
            if (xstartUp == true) {
              xacceleration = 0;
              xstartUp = false;
            }
          }
        }
        else {  
          if (xvelocity <= speedlimit) {
            xacceleration = 0.15;
            xstartUp = true;
          } 
          else if (xvelocity > speedlimit) {
            if (xstartUp == true) {
              xacceleration = 0;
              xstartUp = false;
            }
          }
        }
      }
    }
    if (intoWallL() || intoPlatBreakL()) {
      //println("Colliding With Left Wall");
      getTile(xcor - 1, ycor + 5).contact = true;
      getTile(xcor - 1, ycor + 25).contact = true;
      println(getTile(xcor - 1, ycor + 5).contact);
      if (!intoFloor()) {
        yvelocity += -abs(xvelocity / 4);
        if (intoWallL() && !intoPlatBreakR()) {
          wallClimbL = true;
        }
      }
      if (xvelocity < 0) {
        xvelocity = 0;
        xacceleration = 0;
      }
      if (!intoAirLeft()) {
        xcor += 1;
      }
    } 
    else {
      wallClimbL = false;
    }
    if (intoWallR() || intoPlatBreakR()) {
      //println("Colliding With Right Wall");
      getTile(xcor + 20, ycor + 5).contact = true;
      getTile(xcor + 20, ycor + 25).contact = true;
      println(getTile(xcor + 20, ycor + 5).contact);
      if (!intoFloor()) {
        yvelocity += -abs(xvelocity / 4);
        if (intoWallR() && !intoPlatBreakR()) {
          wallClimbR = true;
        }
      }
      if (xvelocity > 0) {
        xvelocity = 0;
        xacceleration = 0;
      }
      if (!intoAirRight()) {
        xcor -= 1;
      }
    }
    else {
      wallClimbR = false;
    }
    if (intoCeiling()) {
      //println("Colliding With Ceiling");
      getTile(xcor + 5, ycor - 5).contact = true;
      getTile(xcor + 15, ycor - 5).contact = true;
      if (yvelocity < 0) {
        yvelocity = 0;
      }
      if (!intoAirCeiling()) {
        ycor += 1;
      }
    }
    if (intoDeath()) {
      timer.begin();
      mainChar = new Character(0, 0, 0, 0, doorlist[0].xcor + 5, doorlist[0].ycor + 10);
      for (int i = 0; i < board.length; i ++) {
        if (board[i].hasBroken == true) {
          board[i].hasBroken = false;
          board[i].contact = false;
          board[i].countStart = false;
          board[i].type = 3;
        }
      }
    }
    if (intoFloor()) {
      //println("Colliding With Floor");
      getTile(xcor + 5, ycor + 32.5).contact = true;
      getTile(xcor + 15, ycor + 32.5).contact = true;
      if (yvelocity > 0) {
        yvelocity = 0;
        yacceleration = 0;
        isFalling = false;
      }
      if (!intoAirFeet()) {
        ycor -= 1;
      }
      wallClimbR = false;
      wallClimbL = false;
    }
    else if (wallClimbR || wallClimbL) {
      if (!yslowDown) {
        yvelocity = 1;
        yacceleration = 0;
      }
    }
    else {
      yacceleration = 0.15;
      isFalling = true;
      wallClimbL = false;
      wallClimbR = false;
    }
    if (yvelocity >= 2.5) {
      yvelocity = 2.5;
      yacceleration = 0;
    }
  }
  
  boolean intoAirLeft() {
    return 0 == getTile(xcor + 5, ycor + 5).type ||
    0 == getTile(xcor + 5, ycor + 25).type;
  }
  
  boolean intoAirRight() {
    return 0 == getTile(xcor + 15, ycor + 5).type ||
    0 == getTile(xcor + 15, ycor + 25).type;
  }
  
  boolean intoAirFeet() {
    return 0 == getTile(xcor + 5, ycor + 25).type ||
    0 == getTile(xcor + 15, ycor + 25).type;
  }
  
  boolean intoAirCeiling() {
    return 0 == getTile(xcor + 5, ycor + 5).type ||
    0 == getTile(xcor + 15, ycor + 5).type;
  }

  boolean intoFloor() {
    return 0 != getTile(xcor + 5, ycor + 30).type || 
    0 != getTile(xcor + 15, ycor + 30).type;
  }

  boolean intoWallL() {
    return 2 == getTile(xcor - 5, ycor + 5).type || //-1, 1
    2 == getTile(xcor - 5, ycor + 25).type; //-1, 22
  }
  
  boolean intoWallR() {
    return 2 == getTile(xcor + 25, ycor + 5).type || //21, 1
    2 == getTile(xcor + 25, ycor + 25).type; //21, 22
  }
  
  boolean intoPlatBreakL() {
    return 1 == getTile(xcor - 1, ycor + 5).type || //-1, 1
    1 == getTile(xcor - 1, ycor + 25).type || //-1, 22
    3 == getTile(xcor - 1, ycor + 5).type || 
    3 == getTile(xcor - 1, ycor + 25).type;
  }
  
  boolean intoPlatBreakR() {
    return 1 == getTile(xcor + 20, ycor + 5).type || //21, 1
    1 == getTile(xcor + 20, ycor + 25).type || //21, 22
    3 == getTile(xcor + 20, ycor + 5).type || 
    3 == getTile(xcor + 20, ycor + 25).type;
  }
  
  boolean intoCeiling() {
    return 0 != getTile(xcor + 5, ycor - 5).type ||
    0 != getTile(xcor + 15, ycor - 5).type;
  }
  
  boolean intoDeath() {
    for(int i = 0; i < sawlist.length; i ++) {
      if (sawlist[i].insideSaw(xcor, ycor)) {
        return true; 
      }
    }
    return 4 == getTile(xcor + 5, ycor + 25).type || 
    4 == getTile(xcor + 15, ycor + 25).type ||
    4 == getTile(xcor + 5, ycor + 5).type || 
    4 == getTile(xcor + 15, ycor + 5).type ||
    4 == getTile(xcor + 5, ycor + 30).type ||
    4 == getTile(xcor + 15, ycor + 30).type;
  }
}