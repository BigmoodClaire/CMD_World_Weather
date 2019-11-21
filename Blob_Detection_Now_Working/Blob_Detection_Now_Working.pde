import gab.opencv.*; 
import processing.video.*; 
import java.awt.Rectangle;

Capture cam; 
OpenCV opencv; 
Rectangle[] faces;
Drop[] drops = new Drop [500];

int w = 640;
int h = 480;
int fps = 60;//frame rate on which the camera will display it

void setup() { 
  size(640, 480); 
  background (0, 0, 0); 
  
    // RAIN EFFECT SETUP //
  for (int i = 0; i < drops.length; i++) 
  {
    drops[i] = new Drop();
    //img = loadImage("londdon.jpg");
  }
  
  cam = new Capture( this, 640, 480, 30); 
  cam.start(); 
  opencv = new OpenCV(this, cam.width, cam.height); 
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
}

void draw() { 
  
   for (int i = 0; i < drops.length; i++) 
  {
    drops[i].fall();
    drops[i].show();
  }
  
  if (cam.available())
  {
    cam.read();//delivers image only when new images are available, gets rid of jitter
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
