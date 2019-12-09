// SNOW CLASS //
class Snow 
{
  float x = random (width);
  float y = random (-600, -100);
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
    stroke (255, 255, 255);
    ellipse(x, y, 5, 5);
    
  
  }
}

// RAIN CLASS //
class Drop 
{
  float x = random (width);
  float y = random (-600, -100);
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

import gab.opencv.*;  //library for computer vision
import java.awt.Rectangle; // the area of space inclosed inside the rectangle
import processing.video.*;//imports video library

Capture cam;
OpenCV opencv;
Rectangle[] faces = null;

// UI BUTTONS
PImage titleButton;
PImage rainButton;
PImage snowButton;
PImage sunButton;
PImage windButton;

PImage hatButton;
PImage sunglassesButton;
PImage scarfButton;
PImage umbrellaButton;

// WEATHER INSTANCES DECLARED
Drop[] drops = new Drop [500];
Snow[] snowdrops = new Snow [500];

//PROPS 
PImage glassesProp;

//SUN EFFECT
PImage sun;
float x,y,r;


int w = 640;
int h = 480;
int fps = 60;
boolean isRainClicked = false;
boolean isSnowClicked = false;
boolean glassesPropClicked = false;


void setup()
{
  size(640, 480); 
  background (0, 0, 0);
  
  // RAIN EFFECT SETUP //
   for (int i = 0; i < drops.length; i++) 
   {
     drops[i] = new Drop();
   }
   
   // SNOW EFFECT SETUP //
   for (int i = 0; i < snowdrops.length; i++) 
   {
     snowdrops[i] = new Snow();
   }

  // WEBCAM SETUP//
  //size (640, 480);
  cam = new Capture(this, w, h, 30); //"this" refers to THIS processing sketch
  cam.start();
  
  //OPEN CV SETUP
  opencv = new OpenCV(this, cam.width, cam.height); 
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  
  

  // EFFECT BUTTONS SETUP //
  titleButton = loadImage("title.png");
  rainButton = loadImage("rain-button.png");
  snowButton = loadImage("snow-button.png");
  sunButton = loadImage("sun-button.png");
  windButton = loadImage("wind-button.png");
  
  // PROPS BUTTONS SETUP //
  hatButton = loadImage("hat-button.png");
  sunglassesButton = loadImage("sunglasses-button.png");
  scarfButton = loadImage("scarf-button.png");
  umbrellaButton = loadImage("umbrella-button.png");
  
 
}

void checkForFaces() {
  opencv.loadImage(cam); 
  faces = opencv.detect();
}

void snowEffect()
{
   for (int i = 0; i < snowdrops.length; i++) 
   {
     snowdrops[i].fall();
     snowdrops[i].show();
   }
}

void rainEffect()
{
   for (int i = 0; i < drops.length; i++) 
   {
     drops[i].fall();
     drops[i].show();
   }
}

void mouseReleased()
{
  if((mouseX > 540 && mouseX < 640) && (mouseY > 100 && mouseY < 180)) // declares what a click on rain button is
  {
    glassesPropClicked = !glassesPropClicked;//toggles the boolean
  }
  if((mouseX > 0 && mouseX < 100) && (mouseY > 100 && mouseY < 180)) // declares what a click on rain button is
  {
    isRainClicked = !isRainClicked;//toggles the boolean
  }
  
  if((mouseX > 0 && mouseX < 100) && (mouseY > 200 && mouseY < 280))  // declares what a click on snow button is
  {
    isSnowClicked = !isSnowClicked;//toggles the boolean
  }
}

void draw()
{
 
  
  image(cam, 0, 0);
  pushMatrix();
  scale(-1,1);
  image(cam.get(), -width, 0);
  popMatrix();
  
  image(titleButton, 130, 0, 400, 30);
  image(rainButton, 0, 100, 100, 80);
  image(snowButton, 0, 200, 100, 80);
  image(sunButton, 0, 300, 100, 80);
  image(windButton, 0, 400, 100, 80);
  
  image(sunglassesButton, 540, 100, 100, 80);
  image(umbrellaButton, 540, 200, 100, 80);
  image(hatButton, 540, 300, 100, 80);
  image(scarfButton, 540, 400, 100, 80);


  if (cam.available())
  {
    cam.read();//delivers image only when new images are available, gets rid of jitter
    
  }
 
  if (frameCount % 30 == 0) 
  { // when framecount is equal to 30 return it to zero, this allows the frames to not jitter or lag
    thread("checkForFaces"); // allows the cpu to run several tasks at once.
  }
  //image(cam, 0, 0);
  
  if ((faces!=null) && (glassesPropClicked == true)) 
  { // if faces is not equal to none and the glasses button was clicked
    for (int i=0; i< faces.length; i++) 
    { 
      glassesProp = loadImage("Glasses.png");
      image(glassesProp, faces[i].x, faces[i].y, faces[i].width, faces[i].height/2);
    }
  } 
  else if ((faces==null) && (glassesPropClicked == true))
  { // if faces IS equal to none
    textAlign(CENTER); 
    fill(255, 0, 0); 
    textSize(56); 
    println("no faces");
    text("UNDETECTED", 200, 100);
  }
  
  if (isRainClicked == true) //if button is pressed
  {
    rainEffect();
  }
  
  if (isSnowClicked == true)
  {
    snowEffect();
  }
}

 void captureEvent(Capture cam)
   {
     cam.read();
   }
