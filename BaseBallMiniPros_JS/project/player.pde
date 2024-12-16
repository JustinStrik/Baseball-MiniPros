enum Position {
  PITCHER, CATCHER, FIRST_BASE, SECOND_BASE, SHORTSTOP, THIRD_BASE, LEFT_FIELD, CENTER_FIELD, RIGHT_FIELD, RUNNER
}

int runnerIndex = 0;

class Player {
  Position position;
  boolean outfielder = false;
  boolean inPosToCatch = false;
  int base = -1; // for runners only, -1 if not on base
  float x, y; // pixels per second
  float speed = (difficulty + 1.0) * 2;
  float ballInterceptX, ballInterceptY;
  color teamColor;
  
  Player(Position position, color c) {
    this.position = position;
    if (position == Position.LEFT_FIELD || position == Position.CENTER_FIELD
        || position == Position.RIGHT_FIELD)
    this.outfielder = true;
     
    if (this.position == Position.RUNNER) {
      x = 445;
      y = 530;
    }
    teamColor = c;
    speed = (difficulty + 1.0) * 2;
    resetPosition();
  }
  
  void resetPosition() {
    inPosToCatch = false;
    switch (position) {
      case PITCHER:
        x = 617;
        y = 340;
        break;
      case CATCHER:
        x = 618;
        y = 554;
        break;
      case FIRST_BASE:
        x = 845;
        y = 313;
        break;
      case SECOND_BASE:
        x = 782;
        y = 211;
        break;
      case SHORTSTOP:
        x = 463;
        y = 224;
        break;
      case THIRD_BASE:
        x = 387;
        y = 325;
        break;
      case RIGHT_FIELD:
        x = 973;
        y = 133;
        break;
      case CENTER_FIELD:
        x = 620;
        y = 77;
        break;
      case LEFT_FIELD:
        x = 304;
        y = 150;
        break;
      case RUNNER:
        break;
    }
  }
  
  //void moveToBall() {
  //  // Code to move player to the ball at (x, y)
    
  //}
  
  void tryToFieldBall() {
    if (dist(ball.x, ball.y, x, y) < 10) {
      ball.fieldBall();
    }
  } 
  
void drawPlayer() {
  // draw head
  stroke(0);
  strokeWeight(1);
  fill(255, 227, 167);
  ellipse(x, y, 25, 25);

  // draw body
  fill(teamColor);
  rect(x-5, y+7.5, 10, 20);

  // draw arms
  stroke(0);
  strokeWeight(1);
  line(x-15, y+15, x-5, y+15);
  line(x+5, y+15, x+15, y+15);

  // draw legs
  stroke(0);
  strokeWeight(1);
  line(x-2.5, y+27.5, x-2.5, y+40);
  line(x+2.5, y+27.5, x+2.5, y+40);
}
  

void updatePosition() {
  if (ball.isHit) {
      // dont move if ball is gone or if you're in position
    if (ball.aboveWall(x,y) || inPosToCatch)
      return;
    // if ball is to outfield, infielders do not move
    if (ball.outField) {
      // for outfielders to catch the ball
      if (position != Position.LEFT_FIELD &&  position != Position.CENTER_FIELD &&
          position != Position.RIGHT_FIELD) 
            return;
        // for outfielders to go for a fly ball

          float dx = ball.landingX - x;
          float dy = ball.landingY - y;
          float distance = sqrt(dx*dx + dy*dy);
          if (distance < 1)
            return;
      
          // move player towards the ball
          if (distance > 0) {
            float xStep = speed * dx / distance;
            float yStep = speed * dy / distance;
            x += xStep;
            y += yStep;
          }   
        
          if (distance < 4) {
            //println(distance);
            //println("in pos to catch");
            inPosToCatch = true;
            ball.caughtWhenFielded = true;
          }
       return; 
    }
    // calculate distance between player and ball
    float dx = ball.x - x;
    float dy = ball.y - y;
    float distance = sqrt(dx*dx + dy*dy);

    // move player towards the ball
    if (distance > 0) {
      float xStep = speed * dx / distance;
      float yStep = speed * dy / distance;
      x += xStep;
      y += yStep;
    }
  }
  this.tryToFieldBall();
}

  // advance runners
  void advance(int hitVal, boolean hitter) {
    // hitvalues, 1, 2, 3, 4 for single, double...
    
    if (ball.caughtWhenFielded)
      hitVal = 0;
    if (hitter)
      base += 1;
      
    //print("hitval: ");
    //println(hitVal);
    
    base += hitVal;
    if (base > 3) {
      base = -1;
      scoreboard.userScore();
      x = 466;
      y = 575;
    }
    else if (base == 1) {
      x = 866;
      y = 362;
    }
    else if (base == 2) {
      x = 617;
      y = 212;
    }
    else if (base == 3) {
      x = 367;
      y = 363;
    }
  }
}

void advanceRunners() {
     //print("hit: ");
    //println(hit);
    if (hit != 0) {
        for (int i = 0; i < 4; i++) {

           //println(runners[i].base);
            //println("runner index: " + runnerIndex);

          if (runners[i].base == -1 && i != runnerIndex)
            continue;
           
           runners[i].advance(hit, i == runnerIndex);
      }
      
        runnerIndex++;
        if (runnerIndex > 3)
          runnerIndex = 0;
    }
}

// check if player is on base int base
boolean playerOnBase(int base) {
  for (int i = 0; i < 4; i++) {
    if (runners[i].base == base)
      return true;
  }
  return false;
}
