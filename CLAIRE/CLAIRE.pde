//rain
//(138.43,226) - PURPLE
//(230,230,250)- BACKGROUND
class Drop{
  float x = width/2;
  float y = 0;
  float yspeed = 1;
  
  void fall(){
    y = y + yspeed;
  }
  
  void show(){
    
    stroke (138,43,226);
    line(x,y,x,y+10);
  }
  
  
}

Drop[] drops = new Drop [100];

void setup(){
  size (640,360);
  for (int i = 0; i < drops.length; i++); {
  drops[i] = new Drop();
  }
}

void draw(){
  background(230,230,250);
  for(int i = 0; i < drops.length; i++); {
  drops[i].fall();
  drops[i].show();
  
  }
}
