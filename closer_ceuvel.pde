import processing.opengl.*;
import SimpleOpenNI.*;
SimpleOpenNI kinect;
float x_adjust = 0;
float y_adjust = 0;
float z_adjust = 0;

void setup() {
  size(1024, 768, OPENGL);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  stroke(0);
  fill(#D18E86);
    noStroke();
//  stroke(255);
}

void draw() {
  //background(#D1E2F1);
  background(10);
  ambientLight(50, 50, 50);
  directionalLight(255, 255, 255, -.05, 0.2, 0);
  directionalLight(255, 255, 255, .1, -0.5, 0);
  kinect.update();
  // prepare to draw centered in x-y
  // pull it 1000 pixels closer on z
  translate(width/2, height/2, -1000);
  scale(-1,1,1);
  //rotateY(t); // flip y-axis from "realWorld"
  PVector[] depthPoints = kinect.depthMapRealWorld(); // get the depth data as 3D points
  
  for (int i = 0; i < depthPoints.length; i+=31) {
    
    // get the current point from the point array
    PVector currentPoint = depthPoints[i];
    int sc=9;
    if(currentPoint.z>500&&currentPoint.z<8000) {
    
    // draw the triangle
    pushMatrix();
    translate(currentPoint.x, -currentPoint.y, currentPoint.z);
    
      beginShape(TRIANGLES);
      //rotate(random(2*PI));
      rotateX(6*PI*i/depthPoints.length+x_adjust);
      rotateY(6*PI*i/depthPoints.length+y_adjust);
      rotateZ(6*PI*i/depthPoints.length+z_adjust);
      vertex(sc,0,0);
      vertex(-sc,sc,0);
      vertex(-sc,-sc,0);
      
      vertex(sc,0,0);
      vertex(-sc,sc,0);
      vertex(-sc,0,sc);
      
      vertex(sc,0,0);
      vertex(-sc,0,sc);
      vertex(-sc,-sc,0);
      endShape();
    popMatrix();
       
    }
  }
  x_adjust+=0.05;
  y_adjust+=0.05;
  z_adjust+=0.05;
}
