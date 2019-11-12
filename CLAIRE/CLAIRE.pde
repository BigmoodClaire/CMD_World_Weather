//rain
//(138.43,226) - PURPLE
//(230,230,250)- BACKGROUND

class Drop{
  float x = random (width);
  float y = random (-200,-100);
  float yspeed = random (4,10) ;
  float len = random (10,20);
  
  void fall(){
    y = y + yspeed;
    yspeed = yspeed + 0.05;
    
    if (y > height){
      y = random (-200, -100);
      yspeed = random (1,5) ;
  }
 }
  
  void show(){
    
    stroke (138,43,226);
    line(x,y,x,y+10);
  }
  
  
}

Drop[] drops = new Drop [500];

void setup(){
  size (640,360);
  for (int i = 0; i < drops.length; i++) {
  drops[i] = new Drop();
  }
}

void draw(){
  background(230,230,250);
  for(int i = 0; i < drops.length; i++) {
  drops[i].fall();
  drops[i].show();
  
  }
}
