class Drop // Drop class declared
{
  float x = random (width);
  float y = random (-200, -100);
  float yspeed = random (1, 5) ;
  float len = random (10, 20);

  void fall() 
  {
    y = y + yspeed;
    yspeed = yspeed + 0.02;

    if (y > height) 
    {
      y = random (-200, -100);
      yspeed = random (1, 5) ;
    }
  }

  void show() 
  {
    strokeWeight(4);
    stroke (167, 186, 254);
    line(x, y, x, y+10);
  }
}

 // end of class

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
  opencv = new OpenCV(this, cam.width, cam.height); 
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  
  // RAIN EFFECT SETUP //
  for (int i = 0; i < drops.length; i++) 
  {
    drops[i] = new Drop();
    //img = loadImage("londdon.jpg");
  }
  // WEBCAM SETUP//
  size (640, 480);
  cam = new Capture(this, w, h); //"this" refers to THIS processing sketch
  cam.start();
  rainImg = loadImage("rain.png");
}

void draw()
{

  if (cam.available())
  {
    cam.read();//delivers image only when new images are available, gets rid of jitter
  }
  image(cam, 0, 0);
  image(rainImg, 0, 0, 100, 100);

  // DISPLAYS RAIN EFFECT //
  for (int i = 0; i < drops.length; i++) 
  {
    drops[i].fall();
    drops[i].show();
  }
  
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
