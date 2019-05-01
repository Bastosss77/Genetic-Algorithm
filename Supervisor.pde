class Supervisor extends Shape {
  int generationCount = 0;
  int minStep = -1;
  int generationMinStep = -1;
  int dotGoalReachedCount = 0;
  int dotAlive = -1;
  int generationToReachGoal = -1;
  
  Supervisor(int x, int y, int width, int height) {
    super(x, y, width, height, color(255));
  }
  
  //------------------------------------------------------------------------------------------
  
  void draw() {
     if(width >= 200 && height >= 100) {
      stroke(0);
      fill(shapeColor);
      rect(position.x, position.y, width, height);
      noStroke();
      
      //Draw all texts
      drawGenerationCount();
      drawMinStep();
      drawGenerationMinStep();
      drawDotReachedGoalCount();
      drawDotAlive();
      drawGenerationToReachGoal();
     }
  }
  
  //------------------------------------------------------------------------------------------
  
  private void drawGenerationCount() {
    int x = (int) ((position.x + width) / 2) - 50;
    int y = (int) position.y + 15;
    String text = "Generation : " + generationCount;
    
    fill(0);
    textSize(15);
    text(text, x, y);
  }
  
  //------------------------------------------------------------------------------------------
  
  private void drawMinStep() {
    String text = "Min step (all generations) : " + minStep;
    
    fill(0);
    textSize(12);
    text(text, position.x + 5, position. y + 30);
  }
  
  //------------------------------------------------------------------------------------------
  
  private void drawGenerationMinStep() {
    String text = "Minimum step (this generation) : " + generationMinStep;
    
    fill(0);
    textSize(12);
    text(text, position.x + 5, position.y + 45);
  }
  
  //------------------------------------------------------------------------------------------
  
  private void drawDotReachedGoalCount() {
    String text = "Dot have reached goal : " + dotGoalReachedCount;
    
    fill(0);
    textSize(12);
    text(text, position.x + 5, position.y + 70);
  }
  
  //------------------------------------------------------------------------------------------
  
  private void drawDotAlive() {
  String text = "Dot alive : " + dotAlive;
    
    fill(0);
    textSize(12);
    text(text, position.x + 5, position.y + 85);
  }
  
  //------------------------------------------------------------------------------------------
  
  private void drawGenerationToReachGoal() {
    String text = "Generation to reach goal : " + generationToReachGoal;
    
    fill(0);
    textSize(12);
    text(text, position.x + width - 200, position.y + 30);
  }
  
  //------------------------------------------------------------------------------------------
  
  void updateWithPopulation(Population population) {
    int currentMinStep = population.getMinStep();
    
    if(currentMinStep != -1) {
      if(minStep == -1) {
        minStep = currentMinStep;
      } else {
         minStep = currentMinStep < minStep ? currentMinStep : minStep;
      }  
  }
    
   generationCount = GLOBAL_GENERATION;
   generationMinStep = currentMinStep;
   dotGoalReachedCount = population.dotReachedGoalCount();
   dotAlive = population.dotAliveCount();
   
   if(dotGoalReachedCount > 0 && generationToReachGoal == -1) {
     generationToReachGoal = GLOBAL_GENERATION;
   }
  }
}
