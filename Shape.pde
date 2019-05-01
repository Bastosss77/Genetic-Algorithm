class Shape {
  PVector position;
  int width;
  int height;
  color shapeColor;
  
 Shape(int x, int y, int width, int height, color shapeColor) {
   position = new PVector(x, y);
   this.width = width;
   this.height = height;
   this.shapeColor = shapeColor;
 }
 
 //------------------------------------------------------------------------------------------
 
 void draw() {
   fill(shapeColor);
   rect(position.x, position.y, width, height);
 }
}
