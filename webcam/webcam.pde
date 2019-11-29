class Drop // Drop class declared
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

 // end of class

import processing.video.*;//imports video library

Capture cam;
PImage titleButton;
PImage rainButton;
PImage snowButton;
PImage sunButton;
PImage windButton;

PImage hatButton;
PImage sunglassesButton;
PImage scarfButton;
PImage umbrellaButton;
Drop[] drops = new Drop [500];


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
  
  isRainClicked = false; //Rain button isnt clicked
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
  if(mouseX < rainButton.width && mouseY<rainButton.height) // declares what a click is
  {
    isRainClicked = !isRainClicked; //sets the button to true
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
  if (isRainClicked == true) //if button is pressed
  {
    rainEffect();
  }
  else if (isRainClicked == false)
  {
    
  }

}
 
