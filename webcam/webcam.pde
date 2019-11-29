
import processing.video.*;//imports video library
import gab.opencv.*; 
import processing.video.*; 
import java.awt.Rectangle;

Capture cam; 
OpenCV opencv; 
Rectangle[] faces;
PImage rainImg;
Drop[] drops = new Drop [500];
//PImage img; //london image I dont need right now

int w = 640;
int h = 480;
int fps = 60;//frame rate on which the camera will display it

void setup()
{
  size(640, 480); 
  background (0, 0, 0); 
  
  

  // WEBCAM SETUP//
  size (640, 480);
  cam = new Capture(this, w, h); //"this" refers to THIS processing sketch
  cam.start();
  opencv = new OpenCV(this, cam.width, cam.height); 
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  rainImg = loadImage("rain.png");
}

void draw()
{
 // DISPLAYS RAIN EFFECT //
  for (int i = 0; i < drops.length; i++) 
  {
    drops[i].fall();
    drops[i].show();
  }
  
  if (cam.available())
  {
    cam.read();//delivers image only when new images are available, gets rid of jitter
  }
  image(cam, 0, 0);
  image(rainImg, 0, 0, 100, 100);

 
  
  opencv.loadImage(cam); 
  faces = opencv.detect(); 
  image(cam, 0, 0); 
 
  if (faces!=null) { 
    for (int i=0; i< faces.length; i++) { 
      noFill(); 
      stroke(255, 255, 0); 
      strokeWeight(10); 
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    }
  } 
  if (faces.length<=0) { 
    textAlign(CENTER); 
    fill(255, 0, 0); 
    textSize(56); 
    println("no faces");
    text("UNDETECTED", 200, 100);
  }
}
 
void captureEvent(Capture cam) { 
  cam.read();
}
