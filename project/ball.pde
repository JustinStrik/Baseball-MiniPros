class Baseball {
  boolean isPitched, isHit, swung, isStrike, fielded, foul;
  boolean grounder, outField,isHomeRun, onGround, caughtWhenFielded;
  float x, y, landingX, landingY, distToLand; // where the ball will land
  float hitAngle, hitSpeed, hitHeight, hitTime, hitDistance, swingTime;
  // 616 521 home plate

  Baseball() {
    isPitched = false;
    isHit = false;
    isStrike = false;
    swung = false;
    x = 617;
    y = 363;
    hitHeight = 0;
    isHomeRun = false;
    outField = false;
    onGround = true;
    caughtWhenFielded = false;
    hitTime = 10000000;
    distToLand = 100000; // impossibly large
  }
  
  void pitch(int speed) {
    isPitched = true;

    // Set the initial position of the pitch
    // Move the pitch to the right based on the speed parameter
    y = y + speed + difficulty; // difficulty increases with innings
    
    if (y > 541) {
      isPitched = false;
      //println("here shouldnt");
      scoreboard.addStrike();
      resetBall();
    }
  }

  
  void display() {
    
    updateBall();
    
    fill(255);
    stroke(0.5);
    fill(255,0,0);
    ellipse(landingX, landingY, 10, 10);
    
    //if (x < 0 || y < 0) {
    //  scoreboard.resetCount();
    //}
    
    if (y < 190 && isHomeRun == true) {
      textSize(200);
      if (foul) {
        // isHomeRun = false;
        text("FOUL", width/2, height/2, 250);
        //delay(150);
      }
      else {
        text("HOME RUN", width/2, height/2, 50);
              
      }

    }
      
    // ball itself
    fill(255);
    strokeWeight(1);
    circle(x, y, 8.5);
    image(ballImg, x - 4, y - 4, 8, 8);
    // ellipse(x, y, 8, 8);
  }
  
  void updateBall() {
    //if (hitTime + 1200 < frameCount) {
    //  print(frameCount);
    //   isHomeRun = true; //<>//
    //}
    if (hitTime + 120 < frameCount && foul) {
       resetTeam();
       bat.reset();
       resetBall();
       if (scoreboard.strikes < 2)
         scoreboard.addStrike();
       return;
    }
    if (isHit) {
      x += 2 * hitSpeed * cos(hitAngle);
      y -= abs(hitSpeed * sin(hitAngle));
      
      if (!onGround) {
        //println("in air");
        float lastDistToLand = distToLand;
        distToLand = dist(x, y, landingX, landingY);
        // farthest at distToLand = 1/2 dist, apex
        // 616 521 home plate
        float shadowDistFromBall = 30 * abs((hitDistance / 2 - distToLand));
        //println(shadowDistFromBall);
        //print("disttoland: ");
        //println(distToLand);
        
        //if (shadowDistFromBall < 1)
        //  onGround = true;
        if (distToLand > lastDistToLand) {
           onGround = true;
           if (caughtWhenFielded) {
             hit = 0;
             fielded = true;
             fieldBall();
           }
           // lands where cant catch
           if (foul) {
             resetTeam();
             bat.reset();
             resetBall();

             fielded = true;      
             return;
           }
           if (isHomeRun && onGround) {
              hit = 4;
              advanceRunners();
              scoreboard.resetCount();
              resetTeam();
              bat.reset();
              fielded = true;
           }

        }
          
        //println(shadowDistFromBall);
        fill(0, 128); // semi translucent black (shadow)
        //ellipse(x - shadowDistFromBall, y - shadowDistFromBall, 7, 7); 
      }
      else if (aboveWall(x, y)) {
        hitSpeed *= -1.0/4;
      }
    }
  }
  
  void swing() {
    if (swung || !isPitched)
      return;
    swung = true;
    // hits ball
    if (y > 509 && y < 540) {
      isHit = true;
      hitSound.play();
      hitAngle = atan2( x - 603, y - 524);
      //hitAngle = 2.4; // for testing fouls
      if (hitAngle > 2.29 || hitAngle < 0.87)
        foul = true;
      
      hitSpeed = 3 * getHitBarScore();
      hitTime = frameCount;
      if (hitSpeed > 4) {
        outField = true;
        onGround = false;
        landingX = x - 200 * hitSpeed * -cos(hitAngle);
        //println("Landingx " + landingX);
        landingY = y - 100 * hitSpeed * sin(hitAngle);
        //println("LandingY " + landingY);
        hitDistance = dist(x, y, landingX, landingY);

        if (foul) {
          if (scoreboard.strikes < 2)
            scoreboard.addStrike();
        }
        if (aboveWall(landingX, landingY))
          isHomeRun = true;

      }
      
      //println(hitSpeed);
    } else {
      isStrike = true;
      scoreboard.addStrike();
    }
  }
  
  void fieldBall() {
    // only play foul if caught
    if (foul && !caughtWhenFielded) {
      return;
    }
    if (caughtWhenFielded || hit == 0)
      scoreboard.addOut();
    // advance runners
    
    // shows hit and pauses
    displayResultAndPause();
      //delay(30);

    advanceRunners();
    scoreboard.resetCount();
    resetTeam();
    bat.reset();
    fielded = true;
  }
  
  boolean aboveWall(float x, float y) {
    // based on   bezier(63, 190, 332, 0, 909, 0, 1174, 193);
    if (x < 63 || x > 1174) {
          if (!foul && landingY < 191)
            return true;
    }
    // point / width for last variable, distance along cruve
    float onCurveY = bezierPoint(190, 0, 0, 193, (x - 63) / (1174 - 63));
  return y < onCurveY;
}

}
