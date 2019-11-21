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
