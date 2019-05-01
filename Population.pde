class Population {
 private ArrayList<Dot> dots = new ArrayList<Dot>();
 int populationStartX;
 int populationStartY;
 float fitnessSum = 0.0;
 
 Population(int capacity, int startX, int startY) {
   populationStartX = startX;
   populationStartY = startY;
   
  for(int i = 0; i < capacity; i++) {
    dots.add(new Dot(startX, startY));
  }
 }
 
 //------------------------------------------------------------------------------------------
 
 void draw() {
    for(Dot dot : dots) {
       dot.draw(); 
    }
 }
 
 //------------------------------------------------------------------------------------------
 
 void update() {
   
    for(Dot dot : dots) {
       if(isDotTouchedSomething(dot)) {
          dot.isAlive = false; 
       } else if(isDotReachedGoal(dot)) {
         dot.isAlive = false;
         dot.hasReachedGoal = true;
       }
       
       dot.update();
    }
 }
 
 //------------------------------------------------------------------------------------------
 
 boolean isDotTouchedBorder(Dot dot) {
   /*
   dot.x < 5
   dot.x > WINDOW_SIZE - 5
   dot.y < 5 + SUPERVISOR_HEIGHT
   dot.y > WINDOW_SIZE - 5
   */
   
   return (dot.position.x < 5 || dot.position.x > GLOBAL_WINDOW_SIZE - 5 || dot.position.y < 5 + GLOBAL_SUPERVISOR_HEIGHT || dot.position.y > GLOBAL_WINDOW_SIZE - 5);
 }
 
 //------------------------------------------------------------------------------------------
 
 boolean isDotTouchedWall(Dot dot) {
   /*
   dot.x > wall.x
   dot.x < waal.x + wall.width
   dot.y > wall.y
   dot.y < wall.y + wall.height
   */
   
   for(Shape wall : GLOBAL_WALLS) {
      if(dot.position.x >= wall.position.x 
      && dot.position.x <= wall.position.x + wall.width
      && dot.position.y >= wall.position.y 
      && dot.position.y <= wall.position.y + wall.height) {
        return true;
      }
   }
   
   return false;
 }
 
 //------------------------------------------------------------------------------------------
 
 boolean isDotReachedGoal(Dot dot) {
  /*
  dot.x > goal.x
  dot.x < goal.x + goal.width
  dot.y > goal.y
  dot.y < goal.y + goal.height
  */
   return (dot.position.x > GLOBAL_GOAL.position.x 
   && dot.position.x < GLOBAL_GOAL.position.x + GLOBAL_GOAL.width
   && dot.position.y > GLOBAL_GOAL.position.y
   && dot.position.y < GLOBAL_GOAL.position.y + GLOBAL_GOAL.height);
 }
 
 //------------------------------------------------------------------------------------------
 
 boolean isDotTouchedSomething(Dot dot) {
   return isDotTouchedBorder(dot) || isDotTouchedWall(dot);
 }
 
 //------------------------------------------------------------------------------------------
 
 int getMinStep() {
  int min = -1;
  
  for(Dot dot : dots) {
    if(dot.hasReachedGoal && min == -1) {
     min = dot.dna.currentStep; 
    }
    
     if(dot.hasReachedGoal && (dot.dna.currentStep < min)) {
      min = dot.dna.currentStep; 
     }
  }
  
  return min;
 }
 
 //------------------------------------------------------------------------------------------
 
 int dotReachedGoalCount() {
   int count = 0;
   
   for(Dot dot : dots) {
    if(dot.hasReachedGoal) {
      count++;
    }
   }
   
   return count;
 }
 
 //------------------------------------------------------------------------------------------
 
 int dotAliveCount() {
   int count = 0;
   
   for(Dot dot : dots) {
    if(dot.isAlive) {
     count++; 
    }
   }
   
   return count;
 }
 
 //------------------------------------------------------------------------------------------
 
 void evaluateFitness() {
   fitnessSum = 0.0;
   float dotFitness = 0.0;
   
   for(Dot dot : dots) {
     if(dot.hasReachedGoal) {
       dotFitness = 1.0/16.0 + 10000.0/(float)(dot.dna.currentStep * dot.dna.currentStep);
     } else {
      //Fitness is based on the distance from the goal
      float distanceToGoal = dist(dot.position.x, dot.position.y, GLOBAL_GOAL.position.x, GLOBAL_GOAL.position.y);
      dotFitness = 1.0/(distanceToGoal * distanceToGoal);
     }
     
     dot.fitness = dotFitness;
     fitnessSum += dotFitness;
   }
 }
 
 //------------------------------------------------------------------------------------------
 
 void naturalSelection() {
   ArrayList<Dot> newDots = new ArrayList<Dot>();
   Dot bestDot = getBestDot();
   
   Dot newDot = new Dot(populationStartX, populationStartY);
   newDot.dna = bestDot.dna.clone();
   newDot.isBest = true;
   
   newDots.add(newDot);
   
   for(int i = 0; i < dots.size() - 1; i++) {
       Dot newDotBis = new Dot(populationStartX, populationStartY);
       newDotBis.dna = bestDot.dna.clone();
       
       newDots.add(newDotBis);
   }
   
   dots = newDots;
 }
 
 //------------------------------------------------------------------------------------------
 
 Dot getBestDot() {
   float maxFitness = 0.0;
   Dot bestDot = null;
   
   for(Dot dot : dots) {
    if(dot.fitness > maxFitness) {
     maxFitness = dot.fitness; 
     bestDot = dot;
    }
  }
  
  return bestDot;
 }
 
 //------------------------------------------------------------------------------------------
 
 /*Dot selectParent() {
    float rand = random(fitnessSum); 
    float runningSum = 0.0;
    
    for(Dot dot : dots) {
       runningSum += dot.fitness;
       
       if(runningSum > rand) {
          return dot; 
       }
    }
    
    //Will never happen
    return null;
 }*/
 
 //------------------------------------------------------------------------------------------
 
 void mutate() {
   for(Dot dot : dots) {
     dot.dna.mutate();
   }
 }
}
