import gab.opencv.*;  //library for computer vision
import processing.video.*; // allows video
import java.awt.Rectangle; // the area of space inclosed inside the rectangle

PImage img;
Capture cam; // telling processing to expect the camera later
OpenCV opencv; 
Rectangle[] faces = null; 
Drop[] drops = new Drop [500]; // 500 rain drops

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
  }

  cam = new Capture( this, 640, 480, 30); 
  cam.start(); // start the webcam
  opencv = new OpenCV(this, cam.width, cam.height); 
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); // cascade is an AI that searches for pre defines facial features to declare as FACES
}

void checkForFaces() {
  opencv.loadImage(cam); 
  faces = opencv.detect();
}

void rain() {
  for (int i = 0; i < drops.length; i++) 
  {
    drops[i].fall();
    drops[i].show();
  }
}

void draw() {

  if (cam.available())
  {
    cam.read();//delivers image only when new images are available, gets rid of jitter
  }
  if (frameCount % 30 == 0) { // when framecount is equal to 30 return it to zero, this allows the frames to not jitter or lag
    thread("checkForFaces"); // allows the cpu to run several tasks at once.
  }
  image(cam, 0, 0); 

  if (faces!=null) { // if faces is not equal to none
    for (int i=0; i< faces.length; i++) { 
      img = loadImage("Glasses.png");
      image(img, faces[i].x, faces[i].y, faces[i].width, faces[i].height/2);
    }
  } else if (faces==null) { // if faces IS equal to none
    textAlign(CENTER); 
    fill(255, 0, 0); 
    textSize(56); 
    println("no faces");
    text("UNDETECTED", 200, 100);
  }

  rain(); // run the rain function over the detection screen
}

void captureEvent(Capture cam) { // read the currently running
  cam.read();
}
