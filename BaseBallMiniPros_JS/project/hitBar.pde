int hitBarWidth = 3;
int hitBarHeight = 40;
int hitBarX = 845;
int hitBarY = 580;
int hitBarSpeed = 4;
int barY = (height - barHeight) / 2;
int hit = 0;

boolean barMovingRight = true;


void moveAndDisplayBar() {
  // Move the bar left or right
  //print(hitBarSpeed);
  if (barMovingRight) {
    hitBarX += hitBarSpeed;
    if (hitBarX + hitBarWidth + 20 >= width) {
      barMovingRight = false;
    }
  } else {
    hitBarX -= hitBarSpeed;
    if (hitBarX <= 845) {
      barMovingRight = true;
    }
  }
  
  // Display the bar
  fill(0);
  noStroke();

  rect(hitBarX, hitBarY, hitBarWidth, hitBarHeight);
}

float getHitBarScore() {
  // best, worst, edge, 1158 606, 842 598, width
  float val = 0;
  if (hitBarX < 1158) {
    val = 2 - abs(1158 - hitBarX) / 200.0;
  }
  else {
    val = 2 - abs(1158 - hitBarX) / 50.0;
  }
  return val;
}

void drawHitBar() {
  int barWidth = 30;
  int barHeight = 400;
  int barX = width - barWidth - 30;
  int barY = (height - barHeight) / 2;
  
  // Draw the hit bar
  noStroke();
  fill(255, 0, 0); // Red
  rect(barX, barY + barHeight * 3/4, barWidth, barHeight/4);
  fill(255, 255, 0); // Yellow
  rect(barX, barY + barHeight * 1/2, barWidth, barHeight/4);
  fill(255, 165, 0); // Orange
  rect(barX, barY + barHeight * 1/4, barWidth, barHeight/4);
  fill(0, 128, 0); // Green
  rect(barX, barY, barWidth, barHeight/4);
  
  // Draw the hit bar labels
  fill(0);
  textSize(16);
  textAlign(CENTER, BOTTOM);
  text("OUT", barX + barWidth/2, barY + barHeight - 10);
  textAlign(CENTER, CENTER);
  text("SINGLE", barX + barWidth/2, barY + barHeight * 3/4 - 10);
  text("DOUBLE", barX + barWidth/2, barY + barHeight * 1/2 - 10);
  text("TRIPLE", barX + barWidth/2, barY + barHeight * 1/4 - 10);
  
  // Draw the hitTime bar
  float frameBarY = height - 10;
  float movingBarY = -barY + frameBarY - (frameCount - ball.hitTime) * 2;
  fill(0);
  rect(barX, movingBarY, barWidth, 6);
  
  //println(movingBarY);
  //println(barY);
  hit = 3 - abs((int) (barY - movingBarY) / 100);
  //println(hit);
}
