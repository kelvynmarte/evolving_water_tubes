 import java.util.*;

 PImage particleOrign;
 color backgroundColor = #000000;
 color tubeColor = #FFFFFF;
 ArrayList<Particle> particles;

 void setup() {
   background(backgroundColor);
   size(1080, 1080);
   particleOrign = loadImage("particle_orign_template_05.png");
   
   particles = new ArrayList<Particle>();
   // load origin points 
   particleOrign.loadPixels();
   for (int y = 0; y < height; y++) {
     for (int x = 0; x < width; x++) {
       int loc = x + y*width;
       
       float r = red(particleOrign.pixels[loc]);
       if(r==0){
         Particle p = new Particle(x, y);
         particles.add(p);
       }
     }
   }
 }
 
 void draw() {
  for (int i = 0; i < particles.size(); i++) {
    //particles[i].update();
    particles.get(i).update();
    particles.get(i).display();
  }
 }
