class Particle {
  PVector initialPosition;
  PVector position;
  PVector direction;
  float speed = 1f; 
  float size;
  boolean isAlive = true;
  float addedAngle = 0;
  float lifeTime;
  ArrayList<Integer> directionsWithoutCollision = new ArrayList<Integer>();
  
 
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
      println("particle died");
      
      if(random(0,3) < 2){
        particles.add(new Particle(position.x-1, position.y));
        particles.add(new Particle(position.x+1, position.y));
      }

    }
    
    
    if (isAlive == false) return;
    float temporarySpeed = speed;
     
    int directionAngleValue = (int) Math.floor((noise(initialPosition.x, initialPosition.y, frameCount/200f) * 8));
    
    float r = (float) directionAngleValue * (float) Math.PI / 1f;
    
    
    //System.out.println(r);
    PVector f = PVector.fromAngle(r + addedAngle);
    
    // particle can not go back
    if(f.x < 0) return;
    
    //f = PVector.fromAngle((float)Math.PI/2);
    //System.out.println(f);
    
    for (int detectionAngle = 0; detectionAngle < 8; detectionAngle++){
      boolean particleWillColide = false;
      for (int detectionDistance = 2; detectionDistance < 10; detectionDistance++){
        PVector v = position.copy().add(f.copy().mult(detectionDistance));
        color pixelColor = get((int)v.x, (int)v.y);   
        if(red(pixelColor) > 0) {
          particleWillColide = true;
          //isAlive = false;
        }
      }
      if(particleWillColide && detectionAngle == directionAngleValue){
        println("finde new direction");
        addedAngle += Math.PI / 2;
      }
      if(particleWillColide == false){
        directionsWithoutCollision.add(detectionAngle);  
      }
    }
    
    position.add(f.copy().mult(speed));
    
  }

  // Custom method for drawing the object
  void display() {
    fill(tubeColor);
    noStroke();
    ellipse(position.x, position.y,  size, size);
  }
}
