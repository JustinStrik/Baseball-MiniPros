boolean menuQuit = false;
boolean gameMenuOpen = false;
static int difficulty = 0; // 0 = easy, 1 = hard
color teamColor = color(0, 0, 255); // default team color

boolean buttonSelected(int x, int y, int w, int h) {
  return (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h);
}

void displayMenu() {  
  // grey out back area
  fill(0, 128);
  rect(0, 0, width, height);
  
  // Title
  image(batImg, width / 2 - 150, 10, 400, 80);
  textSize(30);
  fill(0);
  textAlign(CENTER);
  text("Baseball MiniPros", width/2, 60);
  
  
  // Difficulty level
  textSize(30);
  fill(0);
  textAlign(LEFT);
  pushMatrix();
  scale(-1,1);
  image(batImg, -500, 165, 250, 50);
  popMatrix();
  text("Difficulty:", 340, 200);
  
  fill(difficulty == 0 ? color(255, 0, 0) : 255); // red if selected, white otherwise
  //rect(width/2 - 125, 185, 100, 30);
  // change ball size if selected
  if (difficulty == 0)
     image(menuBallImg, width/2 - 125, 150, 100, 100);
  else image(menuBallImg, width/2 - 115, 160, 80, 80);

  fill(0);
  textAlign(CENTER);
  text("Easy", width/2 - 75, 207);
  
  fill(difficulty == 1 ? color(255, 0, 0) : 255); // red if selected, white otherwise
  //rect(width/2 + 25, 185, 100, 30);
  if (difficulty == 1)
    image(menuBallImg, width/2 + 25, 150, 100, 100);
  else image(menuBallImg, width/2 + 35, 160, 80, 80);

  fill(0);
  textAlign(CENTER);
  text("Hard", width/2 + 75, 207);
  
  // difficulty 0
  if (buttonSelected(width/2 - 125, 150, 100, 100)) {
    if (mousePressed) {
      difficulty = 0;
    }
  }
  
   // difficulty 1
  if (buttonSelected(width/2 + 25, 150, 100, 100)) {
    if (mousePressed) {
      difficulty = 1;
    }
  }
  
  // PLAY BALL button :)
  if (buttonSelected(width/4, height * 2 / 3 + 100, width/2, 50)) {
      if (mousePressed) {
          runners[0] = new Player(Position.RUNNER, teamColor);
          runners[1] = new Player(Position.RUNNER, teamColor);
          runners[2] = new Player(Position.RUNNER, teamColor);
          runners[3] = new Player(Position.RUNNER, teamColor);
        menuQuit = true;
      }
  }
  
  // Team color
  textSize(30);
  fill(0);
  textAlign(LEFT);
  pushMatrix();
  scale(-1,1);
  image(batImg, -500, 235, 250, 50);
  popMatrix();
  //text("Difficulty:", 350, 200);
  
  text("Team Color:", 340, 270);
  
  fill(255);
  rect(width/2 - 125, 255, 100, 30);
  fill(teamColor);
  rect(width/2 - 120, 260, 90, 20);
  
  fill(255);
  rect(width/2 + 25, 255, 100, 30);
  fill(0);
  textAlign(CENTER);
  text("Select", width/2 + 75, 277);
  
  // team color button
  if (buttonSelected(width/2 + 25, 255, 100, 30)) {
    if (mousePressed) {
      teamColor = color(random(255), random(255), random(255));
      delay(20);
    }
  }
  
  // Play ball button
  fill(255);
  rect(width/4, height * 2 / 3 + 100, width/2, 50);
  fill(0);
  textAlign(CENTER);
  textSize(20);
  text("PLAY BALL!", width/2, height * 2 / 3 + 130);
}
void displayGameOverMenu() {
  // grey out back area
  fill(0, 128);
  rect(0, 0, width, height);

  // Title
  textSize(50);
  fill(0);
  textAlign(CENTER);
  image(batImg, width / 2 - 140, 40, 400, 80);
  text("GAME OVER", width / 2, 100);

  // Score
  fill(255, 0, 0);
  textSize(50);
  textAlign(CENTER);
  image(ballImg, width/2 - 150, height/2 - 150, 300, 300);
  text("Score", width / 2, height / 2 - 80);
  textSize(70);
  text(scoreboard.score1, width / 2, height / 2 + 90);

  // Start Over button
  fill(255);
  //rect(width / 4 - 50, height * 2 / 3, width / 2 + 100, 80, 20);
  fill(0);
  textAlign(CENTER);
  textSize(30);
  pushMatrix();
  scale(-1,1);
  image(batImg, -(3 * width / 4 + 30), height * 2 / 3 + 10, 700, 60);
  popMatrix();
  text("START OVER", width / 2, height * 2 / 3 + 55);

  if (buttonSelected(width / 4 - 50, height * 2 / 3, width / 2 + 100, 80)) {
    if (mousePressed) {
      startOver();
    }
  }

  // Quit button
  fill(255);
  //rect(width / 4 - 50, height * 3 / 4 + 20, width / 2 + 100, 80, 20);
  fill(0);
  textAlign(CENTER);
  textSize(30);
  image(batImg, width / 4 - 30, height * 3 / 4 + 30, 700, 60);
  text("QUIT", width / 2, height * 3 / 4 + 75);

  if (buttonSelected(width / 4 - 50, height * 3 / 4 + 20, width / 2 + 100, 80)) {
    if (mousePressed) {
      exit();
    }
  }
}

void displayGameMenuButton() {
  image(menuBallImg, 30, height - 150, 120, 120);
  textSize(40);
  fill(255, 0, 0);
  textAlign(CENTER);
  text("Menu", 90, height - 80);
}

void displayGameMenu() {
    // grey out back area
  fill(0, 128);
  rect(0, 0, width, height);

  // Title
  textSize(50);
  fill(0);
  textAlign(CENTER);
  image(batImg, width / 2 - 170, 40, 500, 80);
  text("GAME PAUSED", width / 2, 100);

  // Start Over button
  fill(255);
  //rect(width / 4 - 50, height * 2 / 3, width / 2 + 100, 80, 20);
  fill(0);
  textAlign(CENTER);
  textSize(30);
  pushMatrix();
  scale(-1,1);
  image(batImg, -(3 * width / 4 + 30), height * 2 / 3 + 10, 700, 60);
  popMatrix();
  text("RESUME", width / 2, height * 2 / 3 + 55);

  if (buttonSelected(width / 4 - 50, height * 2 / 3, width / 2 + 100, 80)) {
    if (mousePressed) {
      displayGameMenu = false;
    }
  }

  // Quit button
  fill(255);
  //rect(width / 4 - 50, height * 3 / 4 + 20, width / 2 + 100, 80, 20);
  fill(0);
  textAlign(CENTER);
  textSize(30);
  image(batImg, width / 4 - 30, height * 3 / 4 + 30, 700, 60);
  text("QUIT", width / 2, height * 3 / 4 + 75);

  if (buttonSelected(width / 4 - 50, height * 3 / 4 + 20, width / 2 + 100, 80)) {
    if (mousePressed) {
      exit();
    }
  }
}


void startOver() {
  setup();
}
