import processing.sound.*;
SoundFile song, strikeout, hitSound;

PImage field, batImg, ballImg, menuBallImg;
color homeRunColor;
  // Load the image from the "data" folder
PImage bar;
Baseball ball;
BaseballBat bat;
int barWidth, barHeight;
boolean firstP = true;
boolean displayGameMenu = false;
Scoreboard scoreboard;  
Player[] roboTeam; // Declare array of players
Player[] runners;

void resetBall() {
  ball = new Baseball();
  hitBarSpeed = 4 + 2 * difficulty;
}

void setup() {
  ball = new Baseball();
  song = new SoundFile(this, "ballgame.mp3");
  hitSound = new SoundFile(this, "hit.mp3");
  //strikeout = new SoundFile(this, "strikeout.mp3");
  //strikeout.loop();
  
  song.loop();
  bat = new BaseballBat();
  field = loadImage("field.png");
  batImg = loadImage("bat.png");
  ballImg = loadImage("baseball.png");  
  menuBallImg = loadImage("menuball.png");  
  homeRunColor = field.get(30,30);
  bar = loadImage("bar.png");
  barWidth = bar.width * 3 / 4;
  barHeight = bar.height * 3 / 4;
  size(1244,652);
  background(field);
  displayMenu();
  difficulty = 0;
  hitBarSpeed = 4;
  scoreboard = new Scoreboard();
  runners = new Player[4];
  initializeTeam();
}

void draw() {

  drawBackground();   
  strokeWeight(5);
  if (mousePressed && (mouseX > 33 && mouseX < 146) && (mouseY > 506 && mouseX < 619))
    displayGameMenu = true;
    
   drawTeam();
   if (ball.swung)
     bat.swing();
   bat.drawBat();
   
   if (!menuQuit) {
     //displayGameOverMenu();
     displayMenu();
     return;
   } else displayGameMenuButton();
   // intro menu was quiz and game menu not open
   
   if (scoreboard.inning > 4) {
     displayGameOverMenu();
     return;
   }
   else {
     drawRunners(); // must wait for choose color to draw runners
     scoreboard.displayScoreboard();
   }
   
     // displays over everything
  if (displayGameMenu) {
     displayGameMenu();
     return;
  }

   image(bar,845,580,barWidth,barHeight);

   moveAndDisplayBar();

  // pitch ball
  if ((keyPressed && key == 'p' && !ball.isPitched) || ball.isPitched && !ball.isHit) {
    if (firstP) {
      delay(60);
      firstP = false;    
    }
    hitBarSpeed = 0;
    ball.pitch(4);
  }
  
    // hit the ball
  if (keyPressed && key == ' ' && !ball.swung && ball.isPitched) {
    // println("swing");
     bat.swing();
     ball.swing();
  }
  
  // player misses
  if (ball.isPitched && ball.isStrike) {
    //ball.fieldBall();
    ball = new Baseball();
    bat = new BaseballBat();
    return;
  }
  
  // player hits
  else if (ball.isHit) {
    // move outfielders
    drawHitBar();

    // check if ball is fielded, then new ball
  }

  ball.display();
}
// END OF DRAW FUNCTION --------------------------------------------------

void initializeTeam() {
  // Create each player position and add to array
  roboTeam = new Player[9]; // Initialize array size to 9
  
  roboTeam[0] = new Player(Position.PITCHER, color(255, 0, 0));
  roboTeam[1] = new Player(Position.CATCHER, color(255, 0, 0));
  roboTeam[2] = new Player(Position.FIRST_BASE, color(255, 0, 0));
  roboTeam[3] = new Player(Position.SECOND_BASE, color(255, 0, 0));
  roboTeam[4] = new Player(Position.SHORTSTOP, color(255, 0, 0));
  roboTeam[5] = new Player(Position.THIRD_BASE, color(255, 0, 0));
  roboTeam[6] = new Player(Position.LEFT_FIELD, color(255, 0, 0));
  roboTeam[7] = new Player(Position.CENTER_FIELD, color(255, 0, 0));
  roboTeam[8] = new Player(Position.RIGHT_FIELD, color(255, 0, 0));
  
  runners[0] = new Player(Position.RUNNER, teamColor);
  runners[1] = new Player(Position.RUNNER, teamColor);
  runners[2] = new Player(Position.RUNNER, teamColor);
  runners[3] = new Player(Position.RUNNER, teamColor);
}

void drawTeam() {
  for (int i = 0; i < 9; i++) {
    roboTeam[i].updatePosition();
    //if (ball.isHit)
    //roboTeam[i].moveTowardsInterceptPoint();
    roboTeam[i].drawPlayer();
  }
}

void drawRunners() {
  for (int i = 0; i < 4; i++) {
    runners[i].drawPlayer();
    //println(runners[i].x);
  }
}



void resetTeam() {
  for (int i = 0; i < 9; i++) {
    // speed increases with difficulty
    if (roboTeam[i].speed < (difficulty + 1.0) * 1.5)
      roboTeam[i].speed = (difficulty + 1.0) * 1.5;
    //print(roboTeam[i].speed);
    roboTeam[i].resetPosition();
  }
}

//void mouseClicked() {
//    println(mouseX, mouseY); // for debugging
//}

// made this function because i need to use 
// the bezier curve as part of the background
void drawBackground() {
  background(field);
  
  fill(homeRunColor);
  // based on   bezier(63, 190, 332, 0, 909, 0, 1174, 193);
  // serves as fence
  stroke(0);
  strokeWeight(1);
  beginShape();
  vertex(9, 0); // start at bottom left corner
  strokeWeight(2);
  vertex(9, 157);
  vertex(63, 190);
  bezierVertex(332, 0, 909, 0, 1174, 193);
  strokeWeight(0);
  vertex(1226, 158);
  vertex(1226, 0); // end at bottom right corner
  endShape(CLOSE);
}

void displayResultAndPause() {
  if (hit < 4) {
    strokeWeight(1);
    fill(255,0,0);
      text("OUT", width/2, height/2, 50);
      circle(0,0,10);
      print("out");
  }
}

//void playStrike3() {
////  strikeout.play();
////}
