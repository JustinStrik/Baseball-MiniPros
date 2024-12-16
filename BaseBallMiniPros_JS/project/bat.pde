class BaseballBat {
  float length = 15;
  float angle = 0; // pointing straight down initially
  // - PI after swing
  float pivotX = 603;
  float pivotY = 524;
  color batColor = color(255, 204, 0);
  boolean swingCompleted = false;
  
  void drawBat() {
    pushMatrix();
    translate(pivotX, pivotY);
    rotate(angle);
    
    // draw bat
    fill(batColor);
    stroke(1);
    strokeWeight(0.2);
    rect(-1, 0, 2, length);
    
    popMatrix();
  }
  
  void swing() {
  float speed = 0;
  float score = getHitBarScore();
  
  if (score <= 1.0) {
    speed = 0.5;
  } else if (score <= 2.0) {
    speed = 1.0;
  } else if (score <= 3.0) {
    speed = 1.5;
  } else if (score <= 4.0) {
    speed = 2.0;
  } else if (score <= 5.0) {
    speed = 2.5;
  } else if (score <= 6.0) {
    speed = 3.0;
  }
  
  float targetAngle = - PI; // swing up
  
  // rotate the bat gradually
  if (angle > targetAngle) {
    angle -= speed * PI / 5;
    //delay(10);
    //this.drawBat();
  }
  swingCompleted = true;
}

void reset() {
  angle = 0;
}

}
