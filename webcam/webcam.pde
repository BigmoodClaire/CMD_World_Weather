import processing.video.*;//imports video library

Capture cam;
PImage rainImg;

int w = 640;
int h = 480;
int fps = 60;//frame rate on which the camera will display it

void setup()
{
  
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
}
