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

Capture cam; 
PImage rainImg;
Drop[] drops = new Drop [500];
//PImage img; //london image I dont need right now

int w = 640;
int h = 480;
int fps = 60;//frame rate on which the camera will display it
boolean isRainClicked;


void setup()
{
  size(640, 480); 
  background (0, 0, 0); 
  
  // RAIN EFFECT SETUP //
   for (int i = 0; i < drops.length; i++) 
   {
     drops[i] = new Drop();
   }

  // WEBCAM SETUP//
  size (640, 480);
  cam = new Capture(this, w, h); //"this" refers to THIS processing sketch
  cam.start();
  // EFFECT SETUP //
  rainImg = loadImage("rain.png");
  isRainClicked = false;
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
  if(mouseX < rainImg.width && mouseY<rainImg.height)
  {
    isRainClicked = true;
  }
}

void draw()
{
  image(cam, 0, 0);
  image(rainImg, 0, 0, 100, 100);

  if (cam.available())
  {
    cam.read();//delivers image only when new images are available, gets rid of jitter
  }
  if (isRainClicked == true)
  {
    rainEffect();
  }

}
 
