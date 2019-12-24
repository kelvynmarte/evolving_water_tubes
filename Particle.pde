class Particle {
  PVector initialPosition;
  PVector position;
  PVector direction;
  float speed = 1f; 
  float size;
  boolean isAlive = true;
  float addedAngle = 0;
  float lifeTime;
  
 
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
    if (isAlive && lifeTime < frameCount){
      isAlive = false;
      println("particle died");
      
      
      if(random(0,3) < 2){
        particles.add(new Particle(position.x-1, position.y));
        particles.add(new Particle(position.x+1, position.y));
      }

    }
    boolean[] collisionAhead = new boolean[4];
    
    if (isAlive == false) return;
    float temporarySpeed = speed;
     
    float randomValue = (float) Math.floor((noise(initialPosition.x, initialPosition.y, frameCount/200f) * 16));
    float r = randomValue * (float) Math.PI / 4f;
    
    
    //System.out.println(r);
    PVector f = PVector.fromAngle(r + addedAngle);
    
    // particle can not go back
    if(f.x < 0) return;
    
    //f = PVector.fromAngle((float)Math.PI/2);
    //System.out.println(f);
    boolean particleWillColide = false;
    for (int i = 6; i < 10; i++){
      PVector v = position.copy().add(f.copy().mult(i));
      color pixelColor = get((int)v.x, (int)v.y);   
      if(red(pixelColor) > 0) {
        particleWillColide = true;
        //isAlive = false;
      }
    }
    
    if(particleWillColide){
      addedAngle += Math.PI / 2;
      
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
