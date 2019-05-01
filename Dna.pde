class Dna {
  private ArrayList<PVector> directions;
  private int currentStep = 0;
  
  private static final int DIRECTION_NUMBER = 400;
  
  Dna() {
    directions = randomizeDirections(DIRECTION_NUMBER);
  }
  
  //------------------------------------------------------------------------------------------
  
  private ArrayList<PVector> randomizeDirections(int capacity) {
    ArrayList<PVector> randomDirections = new ArrayList<PVector>();
    
    for(int i = 0; i < capacity; i++) {
      PVector direction = PVector.fromAngle(random(2*PI));
      randomDirections.add(direction);
    }
    
    return randomDirections;
  }
  
  //------------------------------------------------------------------------------------------
  
  PVector nextDirection() {
    if(currentStep < directions.size()) {
      PVector nextDirection = directions.get(currentStep);
      currentStep++;
      
      return nextDirection;
    }
    
    return null;
  }
  
  //------------------------------------------------------------------------------------------
  
  void mutate() {
     float mutationRate = 0.01;
     
     for(int i = 0; i < directions.size(); i++) {
        float rand = random(1);
        
        if(rand <= mutationRate) {
           float randomAngle = random(2*PI);
           directions.set(i, PVector.fromAngle(randomAngle));
        }
     }
  }
  
  //------------------------------------------------------------------------------------------
  
  Dna clone() {
   Dna clone = new Dna();
   
   for(int i = 0; i < DIRECTION_NUMBER; i++) {
     clone.directions.set(i, directions.get(i));
   }
  
  return clone;
  }
}
