class Particle {
  PVector initialPosition;
  PVector position;
  PVector direction;
  float speed = 1f; 
  float size;
  boolean isAlive = true;

  float lifeTime;
  ArrayList<Integer> directionsWithoutCollision = new ArrayList<Integer>();
  int directionAngleNumber;
  int addedAngleNumber = 0;
  
 
  // Contructor
  Particle(float x, float y) {
    position = new PVector(x,y);
    initialPosition = new PVector(x,y);
    direction = new PVector(1,0);
    size = 2f;//random(1.5f,3.5f);
    lifeTime = random(frameCount+120,frameCount+1000);
  }
  
  // Custom method for updating the variables
  void update() {
    directionsWithoutCollision.clear();
    
    if (isAlive && lifeTime < frameCount){
      isAlive = false;
      
      if(random(0,3) < 2){
        particles.add(new Particle(position.x-1, position.y));
        particles.add(new Particle(position.x+1, position.y));
      }

    }
 
    if (isAlive == false) return;
    float temporarySpeed = speed;
     
    directionAngleNumber = (int) Math.floor((noise(initialPosition.x, initialPosition.y, frameCount/100f) * 8));
    
    
    int resulingDirectionAngleNumber = directionAngleNumber + addedAngleNumber;
    //if(resulingDirectionAngleNumber > 5) findNewAddedAngleNumber();
    
    float r = (float) (directionAngleNumber + addedAngleNumber) * (float) Math.PI / 4f;
    
    
    //System.out.println(r);
    PVector f = PVector.fromAngle(r);
    
    // particle can not go back
    
    boolean particleWillCollideIfContinuing = false;
    for (int detectionAngle = 0; detectionAngle < 8; detectionAngle++){
      boolean collisionAheadAtAngle = false;
      for (float detectionDistance = 3f; detectionDistance < 40; detectionDistance+=.25f){
        PVector v = position.copy().add(PVector.fromAngle(detectionAngle * (float)Math.PI/4f).mult(detectionDistance));
          
        
        // find adjacent colors
        
        for(int dX = -1; dX < 1; dX ++){
          for(int dY = -1; dY < 1; dY++){
            color pixelColor = get((int)v.x + dX, (int)v.y + dY); 
            if(red(pixelColor) > 0) {
              collisionAheadAtAngle = true;
            }
          }
        }
        
        
      }
      if(collisionAheadAtAngle && detectionAngle == (directionAngleNumber + addedAngleNumber)){
        particleWillCollideIfContinuing = true;

      }
      if(collisionAheadAtAngle == false){
        
        // filter for directions down
        if(detectionAngle <= 4) directionsWithoutCollision.add(detectionAngle); 
         
      }
    }
    
    if(particleWillCollideIfContinuing){
        //println("finde new direction");
        //println(directionsWithoutCollision);
        findNewAddedAngleNumber();
    }
    
    position.add(f.copy().mult(speed));
    
  }
  
  void findNewAddedAngleNumber(){
    if(directionsWithoutCollision.size() == 0){
      isAlive = false;
    }else{
      int newDirection = directionsWithoutCollision.get((int)random(0,directionsWithoutCollision.size()));
      addedAngleNumber = newDirection - directionAngleNumber;
      //println("new direction " + newDirection);
      //println("added angle number " + addedAngleNumber);
      //println("direction angle number " + directionAngleNumber);
    }
  }

  // Custom method for drawing the object
  void display() {
    fill(tubeColor);
    noStroke();
    ellipse(position.x-size/2, position.y-size/2,  size, size);
  }
}
