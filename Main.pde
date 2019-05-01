ArrayList<Shape> GLOBAL_WALLS = new ArrayList<Shape>();
Shape GLOBAL_GOAL;
Population GLOBAL_POPULATION;
Supervisor GLOBAL_SUPERVISOR;
int GLOBAL_GENERATION = 0;

int GLOBAL_WINDOW_SIZE = 700; 
int GLOBAL_SUPERVISOR_HEIGHT = 100;

void setup() {
  size(700, 700);  //Couldn't use variable
  setupPopulation();
  setupWalls();
  setupGoal();
  setupSupervisor();
}

//------------------------------------------------------------------------------------------

void draw() {
  background(255);
  GLOBAL_SUPERVISOR.draw();
  GLOBAL_GOAL.draw();
  
  for(Shape wall : GLOBAL_WALLS) {
     wall.draw(); 
  }
  
  if(GLOBAL_POPULATION.dotAliveCount() > 0) {
    GLOBAL_POPULATION.draw();
    update();
  } else {
   GLOBAL_POPULATION.evaluateFitness();
   GLOBAL_POPULATION.naturalSelection();
   GLOBAL_POPULATION.mutate(); 
   GLOBAL_GENERATION++;
  }
}

//------------------------------------------------------------------------------------------

private void update() {
  GLOBAL_SUPERVISOR.updateWithPopulation(GLOBAL_POPULATION);
  GLOBAL_POPULATION.update();
}

//------------------------------------------------------------------------------------------

private void setupSupervisor() {
   GLOBAL_SUPERVISOR = new Supervisor(0, 0, GLOBAL_WINDOW_SIZE, 100); 
}

//------------------------------------------------------------------------------------------

private void setupGoal() {
  int goalWidth = 100;
  int goalHeight = 40;
  color goalColor = color(255, 0, 0);
  int goalX = (GLOBAL_WINDOW_SIZE / 2) - 50;
  
  GLOBAL_GOAL = new Shape(goalX, GLOBAL_SUPERVISOR_HEIGHT + 2, goalWidth, goalHeight, goalColor);
}

//------------------------------------------------------------------------------------------

void setupWalls() {
  int wallHeight = 15;
  color wallColor = color(0, 0, 255);
  
  Shape wallOne = new Shape(150, 400 + GLOBAL_SUPERVISOR_HEIGHT, 400, wallHeight, wallColor);
  Shape wallTwo = new Shape(0, 200 + GLOBAL_SUPERVISOR_HEIGHT, 250, wallHeight, wallColor);
  Shape wallThree = new Shape(GLOBAL_WINDOW_SIZE - 250, 200 + GLOBAL_SUPERVISOR_HEIGHT, 250, wallHeight, wallColor);

  GLOBAL_WALLS.add(wallOne);
  GLOBAL_WALLS.add(wallTwo);
  GLOBAL_WALLS.add(wallThree);
}

//------------------------------------------------------------------------------------------

private void setupPopulation() {
  int populationSize = 500;
  int populationStartX = GLOBAL_WINDOW_SIZE / 2;
  int populationStartY = GLOBAL_WINDOW_SIZE - 20;
  
  GLOBAL_POPULATION = new Population(populationSize, populationStartX, populationStartY);
}

//------------------------------------------------------------------------------------------
