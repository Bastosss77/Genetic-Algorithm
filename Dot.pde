class Dot extends Shape {
 Dna dna = new Dna();
 PVector velocity = new PVector(0, 0);
 PVector acceleration = new PVector(0, 0);
 boolean isAlive = true;
 boolean hasReachedGoal = false;
 boolean isBest = false;
 float fitness = 0.0;
 
 Dot(int x, int y) {
   super(x, y, 5, 5, color(0));
   
  velocity.limit(1);
 }
 
 //------------------------------------------------------------------------------------------
 
 void draw() {
    fill(shapeColor);
    ellipse(position.x, position.y, width, height);
 }
  
  //------------------------------------------------------------------------------------------
  
  void move() {
   PVector nextDirection = dna.nextDirection();
   
   if(nextDirection != null) {
      velocity.add(nextDirection);
      position.add(velocity);
   } else {
     isAlive = false;
   }
  }
  
  //------------------------------------------------------------------------------------------
  
  void update() {    
   if(isAlive && !hasReachedGoal) {
     shapeColor = color(0);
     move();
   } else if(hasReachedGoal) {
     shapeColor = color(155, 155, 155);
   } else if(isBest) {
     shapeColor = color(0, 255, 0);
   } else {
    shapeColor = color(255, 255, 255, 0); 
   }
 }
}
