class Scoreboard {
  int w = 120;
  int h = 200;
  int balls;
  int strikes;
  int outs;
  int score1; // team 1 score
  int score2; // team 2 score
  int inning = 1;
  
  Scoreboard() {
    balls = 0;
    strikes = 0;
    outs = 0;
    score1 = 0;
    score2 = 0;
  }
  
  Scoreboard(int b, int s, int o, int sc) {
    balls = b;
    strikes = s;
    outs = o;
    score1 = 0;
    score2 = 0;
  }
  
  void resetCount() {
    resetBall();
    balls = 0;
    strikes = 0;
  }
  
  //void displayScoreboardOG() {
  //  textSize(20);
  //  textAlign(RIGHT);
  //  fill(0);
  //  text("Balls: " + balls, width-50, 30);
  //  text("Strikes: " + strikes, width-50, 60);
  //  text("Outs: " + outs, width-50, 90);
  //  text("You: " + score1, width-50, 120);
  //  text("RoboMinis: " + score2, width-50, 150);
  //}
  
  void addBall() {
    balls++;
    if (balls == 4) {
      balls = 0;
      strikes = 0;
    }
  }
  
  void addStrike() {
    //println("strike");
    strikes++;
    if (strikes == 3) {
      balls = 0;
      strikes = 0;
      //playStrike3();

      addOut();
    }
    
    hitBarSpeed = 4 + 2 * difficulty;
  }
  
  void addOut() {
    outs++;
    if (outs >= 3) {
      // up inning
      inning++;
      difficulty++;
      hitBarSpeed += 2; // goes up w/ difficulty
      outs = 0;
      resetCount();
    }
  }
  
  void userScore() {
    score1++;
  }
  
void displayScoreboard() {
    fill(0);
    rect(width - w - 20, 0, w, h);
    // top row team colors and logos
    fill(teamColor);
    rect(width - w - 20, 0, w / 2, h / 4);
    fill(255, 0, 0);
    rect(width - w / 2 - 20, 0, w / 2, h / 4);
    
    // first level text
    textAlign(LEFT);
    textSize(35);
    fill(255);
    text("You",width - w - 15, h / 4 - 15);
    textSize(30);
    text("Mini",width - w / 2 - 20, h / 8);
    text("Pros",width - w / 2 - 20, h / 8 + 20);
    
    
    // 2nd level white scores
    fill(255);
    rect(width - w - 20, h / 4, w / 2, h / 4);
    rect(width - w / 2 - 20, h / 4, w / 2, h / 4);
    textSize(40);
    textAlign(CENTER);
    fill(0);
    text(score1, width - w + 10, h / 2 - 12);
    text(score2, width - w / 2 + 10, h / 2 - 12);
    
    // third row. left half is inning / level
    // right half is outs
    
    stroke(255);
    noFill();
    rect(width - w - 20, h / 2, w / 2, h / 4);
    rect(width - w / 2 - 20, h / 2, w / 2, h / 4);

    // left side
    fill(255, 255, 0); // yellow
    strokeWeight(1);
    stroke(255);
    triangle(width - 3 * w / 4 - 45, h / 2 + 15, width - 3 * w / 4 - 40, h / 2 + 5, width - 3 * w / 4 - 40 + 5, h / 2 + 15);
    noFill();
    triangle(width - 3 * w / 4 - 45, h / 2 + 25, width - 3 * w / 4 - 40, h / 2 + 35, width - 3 * w / 4 - 40 + 5, h / 2 + 25);
    fill(255);
    text(inning, width - 3 * w / 4 - 15, h / 2 + 35);
    
    stroke(255, 255, 0);
    noFill();
    // right side of 3rd row
    if (scoreboard.outs >= 2) {
       fill(255, 255, 0);
    }
    // second out circle
    circle(width - w / 4 - 8, h / 2 + 25, 12);
    if (scoreboard.outs >= 1) {
       fill(255, 255, 0);
    }
    circle(width - w / 4 - 30, h / 2 + 25, 12);

    // last row, bases and count
    // different for each base
    int baseX = 1135;  // horizontal position of the top corner of the square
    int baseY = 155;  // vertical position of the top corner of the square
    int squareSize = 10;  // size of the square
    
    pushMatrix();  // save the current transformation matrix
    translate(baseX, baseY);  // move the square to the specified top corner position
    rotate(radians(45));  // rotate the square by 45 degrees
    
    // 2nd base
    if (playerOnBase(2)) 
      fill(255,255,0);
    else noFill();
    rect(0, 0, squareSize, squareSize);  // draw the square at the rotated position
    
    // 1st base
    if (playerOnBase(1)) 
      fill(255,255,0);
    else noFill();
    rect(squareSize * 1.5, 0, squareSize, squareSize);  // draw the square at the rotated position
    
    // 3rd base
    if (playerOnBase(3)) 
      fill(255,255,0);
    else noFill();
    rect(0, squareSize * 1.5, squareSize, squareSize);  // draw the square at the rotated position
    popMatrix();  // restore the previous transformation matrix

    fill(255);
    text(balls + "-" + strikes, baseX + 60, baseY + 35);
  }
}
